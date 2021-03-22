//
//  UserInfoTableViewCell.swift
//  Git App
//
//  Created by Sergey Galagan on 22.03.2021.
//

import Foundation
import UIKit

class UserInfoTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var blogLabel: UILabel!
    
    func showInfo(_ profile: UserProfile) {
        self.nameLabel?.text = "Name: " + profile.name!
        self.companyLabel?.text = "Company: " + profile.company!
        self.blogLabel?.text = "Blog: " + profile.blog!
    }
}
