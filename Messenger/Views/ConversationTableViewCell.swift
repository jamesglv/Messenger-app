//
//  ConversationTableViewCell.swift
//  Messenger
//
//  Created by James Ogilvie on 27/9/2022.
//

import UIKit
import SDWebImage

class ConversationTableViewCell: UITableViewCell {

    static let identifier = "ConversationTableViewCell"

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        return label
    }()

    private let userMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userMessageLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()


        userNameLabel.frame = CGRect(x: 25,
                                     y: 10,
                                     width: contentView.width - 60,
                                     height: (contentView.height-20)/2)

        userMessageLabel.frame = CGRect(x: 25,
                                        y: userNameLabel.bottom,
                                        width: contentView.width - 60,
                                        height: (contentView.height-20)/2)

    }

    public func configure(with model: Conversation) {
        self.userMessageLabel.text = model.latestMessage.text
        self.userNameLabel.text = model.name

    }

}
