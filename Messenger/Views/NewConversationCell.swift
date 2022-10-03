//
//  NewConversationCell.swift
//  Messenger
//
//  Created by James Ogilvie on 30/9/2022.
//

import Foundation
import SDWebImage

class NewConversationCell: UITableViewCell {

    static let identifier = "NewConversationCell"

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userNameLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()


        userNameLabel.frame = CGRect(x: 25,
                                     y: 10,
                                     width: contentView.width - 60,
                                     height: contentView.height-20)
    }

    public func configure(with model: SearchResult) {
        userNameLabel.text = model.name

    }

}
