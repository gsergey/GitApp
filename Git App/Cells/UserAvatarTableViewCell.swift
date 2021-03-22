//
//  UserAvatarTableViewCell.swift
//  Git App
//
//  Created by Sergey Galagan on 22.03.2021.
//

import Foundation
import UIKit

class UserAvatarTableViewCell: UITableViewCell {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var following: UILabel!
    @IBOutlet var followers: UILabel!
    
    
    func showInfo(_ profile: UserProfile) {
        self.avatarImageView.maskCircle()
        self.avatarImageView.loadCachedImageFromURLString(profile.avatar_url!, placeholder: UIImage(named: "avatar_template")) {
        }
        
        self.following?.text = "Following: \(profile.following)"
        self.followers?.text = "Followers: \(profile.followers)"
    }
}
