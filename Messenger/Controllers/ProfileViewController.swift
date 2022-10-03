//
//  ProfileViewController.swift
//  Messenger
//
//  Created by James Ogilvie on 22/9/2022.
//

import UIKit
import FirebaseAuth

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}

final class ProfileViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var data = [ProfileViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let profileName = UserDefaults.standard.value(forKey: "name") as? String ?? "No name"
        let profileEmail = UserDefaults.standard.value(forKey: "email") as? String ?? "No email"
        
        print("DATA BELOW")
        print(data)
        
        tableView.register(ProfileTableViewCell.self,
                           forCellReuseIdentifier: ProfileTableViewCell.identifier)
        

        data.append(ProfileViewModel(viewModelType: .info,
                                     title: "Hey \(profileName)",
                                     handler: nil))
        data.append(ProfileViewModel(viewModelType: .info,
                                     title: "Email Address \(profileEmail)",
                                     handler: nil))
        data.append(ProfileViewModel(viewModelType: .logout,
                                     title: "Log Out",
                                     handler: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            let actionSheet = UIAlertController(title: "",
                                          message: "Are you sure you want to sign out?",
                                          preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Sign Out",
                                                style: .destructive,
                                                handler: { [weak self] _ in
                
                guard let strongSelf = self else {
                    return
                }
                
                UserDefaults.standard.setValue(nil, forKey: "email")
                UserDefaults.standard.setValue(nil, forKey: "name")
                
                print("DATA IS...")
                print(strongSelf.data)
                
                //strongSelf.data.removeAll()
                //strongSelf.data = [ProfileViewModel]()
                
                print("Removed all")
                print(strongSelf.data)
                
                
//                print(UserDefaults.standard.value(forKey: "email"))
//                print(UserDefaults.standard.value(forKey: "name"))
                
                do {
                    try FirebaseAuth.Auth.auth().signOut()
                    
                    let vc = LoginViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    strongSelf.present(nav, animated: true)
                    
                }
                catch{
                    print("Failed to log out")
                }
                
            }))
            print("DATA IS...")
            print(strongSelf.data)
            actionSheet.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
            
            strongSelf.present(actionSheet, animated: true)
        }))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeader()
    }
    
    func createTableHeader() -> UIView? {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }
        
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        print(safeEmail)
//        let headerView = UIView(frame: CGRect(x: 0,
//                                        y: 0,
//                                        width: view.width,
//                                        height: 150))
//        headerView.backgroundColor = .link
//
//        let headerText = UILabel(frame: CGRect(x: 0,
//                                               y: 0,
//                                               width: self.view.width,
//                                               height: 50))
//        headerText.text = "Name: \(UserDefaults.standard.value(forKey:"name") as? String ?? "No Name")"
//
        //return headerView
        return nil//headerText
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        cell.setUp(with: viewModel)

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.row].handler?()
    }
}

class ProfileTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileTableViewCell"
    let profileName = UserDefaults.standard.value(forKey: "name") as? String ?? "No name"
    let profileEmail = UserDefaults.standard.value(forKey: "email") as? String ?? "No email"
    
    public func setUp(with viewModel: ProfileViewModel) {
        self.textLabel?.text = viewModel.title
        switch viewModel.viewModelType {
        case .info:
            textLabel?.textAlignment = .left
            selectionStyle = .none
        case .logout:
            textLabel?.textColor = .red
            textLabel?.textAlignment = .center
        }
    }
}
