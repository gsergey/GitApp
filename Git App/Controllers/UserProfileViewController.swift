//
//  UserProfileViewController.swift
//  Git App
//
//  Created by Sergey Galagan on 20.03.2021.
//

import UIKit


class UserProfileViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var userEntity: UsersList?
    var profileEntity: UserProfile!
    var notesTextString: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.showProgressHUD(self.view)
            self.fetchUserProfile()
        }
    }
    
    
    // MARK: - UI
    func configureUI() {
        self.navigationItem.title = self.profileEntity?.username!
    }
    
    
    // MARK: - API method for download user profile
    func downloadUserProfile(_ username: String, complition: @escaping (_ status: Bool) -> Void) {
        NetworkManager.downloadUserProfile(username: username, successComplition: { data in
            if let response = try? JSONDecoder().decode(UserProfileModel.self, from: data) {
                self.profileEntity = DataManager.sharedInstance.saveProfile(response)
                complition(true)
            } else {
                print("Decoding Error")
                complition(false)
            }
            
        }, failureComplition: { error in
            print("\(error)")
            complition(false)
        });
    }
    
    
    // MARK: - Action methods
    
    @IBAction func onSaveButtonTap(_ sender: Any?) {
        self.showAlert("Notes saved")
        saveNotes()
        self.view .endEditing(true)
    }
    
    
    // MARK: - Update data in db
    
    func markUserAsReviewed() {
        self.userEntity?.markAsReviewed()
    }
    
    func saveNotes() {
        self.profileEntity?.addNotes(self.notesTextString)
        self.userEntity?.addNotesMark(self.notesTextString)
    }
    
    func fetchUserProfile() {
        guard let user = self.userEntity else {
            self.navigationController?.popToRootViewController(animated: true)
            return
        }
        
        // fetch user profile if was stored previously
        self.profileEntity = DataManager.sharedInstance.fetchProfileWithID(user_id: Int(user.user_id))
        
        if self.profileEntity != nil {
            DispatchQueue.main.async {
                self.configureUI()
                self.tableView.reloadData()
                self.closeProgressHUD(self.view)
            }
        }
            
        // fetch user profile data from server side
        self.downloadUserProfile((user.username)!) { status in
            DispatchQueue.main.async {
                self.closeProgressHUD(self.view)
                
                if status {
                    // mark user's profile as reviewed
                    self.markUserAsReviewed()
                    
                    self.configureUI()
                    self.tableView.reloadData()
                } else {
                    self.showAlert("Could not download profile data. Please try again", handler: { (action) in
                        self.navigationController?.popViewController(animated: true)
                    })
                }
            }
        }
    }
}


// MARK: - UITableViewDataSource methods
extension UserProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserAvatarTableViewCell") as! UserAvatarTableViewCell
            if self.profileEntity != nil {
                cell.showInfo(self.profileEntity!)
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell") as! UserInfoTableViewCell
            if self.profileEntity != nil {
                cell.showInfo(self.profileEntity!)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserNotesTableViewCell") as! UserNotesTableViewCell
            if self.profileEntity != nil {
                if let notes = self.profileEntity?.notes {
                    cell.showNotes(notes)
                }
            }
            cell.textChanged {[weak tableView] (newText: String) in
                self.notesTextString = newText
                tableView?.beginUpdates()
                tableView?.endUpdates()
            }
            
            return cell
        }
    }
}


// MARK: - UITableViewDelegate methods

extension UserProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200
        
        case 1:
            return 100
            
        case 2:
            return 200
        default:
            return 200
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView .deselectRow(at: indexPath, animated: true)
        self.view .endEditing(true)
    }
}

// MARK: - UIScrollViewDelegate methods
extension UserProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
