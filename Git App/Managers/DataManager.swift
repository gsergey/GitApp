//
//  DataManager.swift
//  Git App
//
//  Created by Sergey Galagan on 21.03.2021.
//

import Foundation


class DataManager: NSObject {
    static let sharedInstance = DataManager()
    
    func saveUserList(list: [UserListModel]) {
        let context = CoreDataStack.sharedInstance.mainContext()
        _ = list.map{[UsersList.initWithAPIModel(entity: $0, inContext: context!)]}
        CoreDataStack.sharedInstance.saveContext()
    }
    
    func saveProfile(_ profile: UserProfileModel) -> UserProfile {
        let context = CoreDataStack.sharedInstance.mainContext()
        let profile = UserProfile.initWithAPIModel(entity: profile, inContext: context!)
        CoreDataStack.sharedInstance.saveContext()
        
        return profile
    }
    
    func saveProfileNotes(_ notes: String, for profile: UserProfile) {
        let context = CoreDataStack.sharedInstance.mainContext()
        profile.addNotes(notes: notes, inContext: context!)
        CoreDataStack.sharedInstance.saveContext()
    }
    
    func addNotesToUsersList(_ notesState: Bool, for profile: UsersList) {
        let context = CoreDataStack.sharedInstance.mainContext()
        profile.addNotesMark(isNotesAdded: notesState, inContext: context!)
        CoreDataStack.sharedInstance.saveContext()
    }
    
    func markProfileAsReviewed(userID: Int32) {
        let context = CoreDataStack.sharedInstance.mainContext()
        guard let user = UsersList.fetchUserWithID(userID, inContext: context!) else {
            return
        }
        user.markAsReviewed(context!)
        CoreDataStack.sharedInstance.saveContext()
    }
}
