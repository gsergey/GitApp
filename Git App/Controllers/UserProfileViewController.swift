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
    var profileEntity: UserProfile?
    var notesTextString: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showProgressHUD(self.view)
        
        DispatchQueue.main.async {
            
            // mark selected user as reviewed
            self.markUserAsReviewed()
            
            
            // fetch user profile data from server side
            self.downloadUserProfile((self.userEntity?.username)!) { status in
                DispatchQueue.main.async {
                self.closeProgressHUD(self.view)
                }
                if status {
                    DispatchQueue.main.async {
                        self.configureUI()
                        self.tableView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert("Could not profile data. Please try againg", handler: { (action) in
                            self.navigationController?.popViewController(animated: true)
                        })
                    }
                }
            }
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
                self.fetchNotes()
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
        saveNotes()
        self.view .endEditing(true)
    }
    
    
    // MARK: - Updated data in db
    
    func saveNotes() {
        DataManager.sharedInstance.saveProfileNotes(self.notesTextString ?? "", for: self.profileEntity!)
        var state: Bool = false
        if self.notesTextString.count > 0 {
            state = true
        }
        DataManager.sharedInstance.addNotesToUsersList(state, for: self.userEntity!)
        DataManager.sharedInstance.markProfileAsReviewed(userID: self.profileEntity!.user_id)
    }
    
    func markUserAsReviewed() {
        let context = CoreDataStack.sharedInstance.mainContext()!
        self.userEntity?.markAsReviewed(context)
        CoreDataStack.sharedInstance.saveContext()
    }
    
    func fetchNotes() {
        let context = CoreDataStack.sharedInstance.mainContext()!
        self.profileEntity?.fetchNotes(inContext: context)
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
    }
}

// MARK: - UIScrollViewDelegate methods
extension UserProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
