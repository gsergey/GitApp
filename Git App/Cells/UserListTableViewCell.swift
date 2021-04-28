//
//  UserListTableViewCell.swift
//  Git App
//
//  Created by Sergey Galagan on 21.03.2021.
//

import Foundation
import UIKit

class UserListTableViewCell: UITableViewCell {
    
    static let cellIdentifier: String = "UserListTableViewCell"
    
    // MARK: - Properties
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var notesImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    
    func configureCell(_ entity: UsersList, invertedAvatar: Bool) {
        
        self.usernameLabel?.text = entity.username!
        self.detailsLabel?.text = "Some details"
        self.notesImageView.isHidden = !entity.isNotes
        
        self.avatarImageView?.maskCircle()
        
        self.backgroundColor = entity.reviewed ? UIColor.lightGray : UIColor.systemBackground
        
        if let url = entity.avatar_url {
            self.avatarImageView?.loadCachedImageFromURLString(url, placeholder: UIImage(named: "avatar_template"), complitionBlock: { [self] in
                if invertedAvatar {
                    DispatchQueue.main.async {
                        self.avatarImageView.invertColor()
                    }
                }
            })
        }
    }
}
