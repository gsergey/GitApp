//
//  UserProfile+CoreDataProperties.swift
//  Git App
//
//  Created by Sergey Galagan on 20.03.2021.
//
//

import Foundation
import CoreData


extension UserProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserProfile> {
        return NSFetchRequest<UserProfile>(entityName: "UserProfile")
    }

    @NSManaged public var username: String?
    @NSManaged public var user_id: Int32
    @NSManaged public var twitter_username: String?
    @NSManaged public var location: String?
    @NSManaged public var blog: String?
    @NSManaged public var company: String?
    @NSManaged public var name: String?
    @NSManaged public var site_admin: Bool
    @NSManaged public var type: String?
    @NSManaged public var received_events_url: String?
    @NSManaged public var events_url: String?
    @NSManaged public var repos_url: String?
    @NSManaged public var organizations_url: String?
    @NSManaged public var subscriptions_url: String?
    @NSManaged public var starred_url: String?
    @NSManaged public var gists_url: String?
    @NSManaged public var following_url: String?
    @NSManaged public var followers_url: String?
    @NSManaged public var html_url: String?
    @NSManaged public var url: String?
    @NSManaged public var gravatar_id: String?
    @NSManaged public var avatar_url: String?
    @NSManaged public var node_id: String?
    @NSManaged public var public_gists: Int16
    @NSManaged public var public_repos: Int16
    @NSManaged public var bio: String?
    @NSManaged public var hireable: String?
    @NSManaged public var email: String?
    @NSManaged public var updated_at: NSDate?
    @NSManaged public var created_at: NSDate?
    @NSManaged public var following: Int16
    @NSManaged public var followers: Int16
    @NSManaged public var notes: String?
    @NSManaged public var relationship: UsersList?
    
    
    class func initWithAPIModel(entity: UserProfileModel, inContext context:NSManagedObjectContext) -> UserProfile {
        let profile = fetchProfileWithID(entity.user_id, inContext: context) ?? UserProfile(context: context)
        profile.updateProfile(entity, inContext: context)        
        return profile
    }
    
    func updateProfile(_ entity: UserProfileModel, inContext context: NSManagedObjectContext) {
        self.username = entity.username
        self.user_id = entity.user_id
        self.twitter_username = entity.twitter_username
        self.location = entity.location
        self.blog = entity.blog
        self.company = entity.company
        self.name = entity.name
        self.site_admin = entity.site_admin
        self.type = entity.type
        self.received_events_url = entity.received_events_url
        self.events_url = entity.events_url
        self.repos_url = entity.repos_url
        self.organizations_url = entity.organizations_url
        self.subscriptions_url = entity.subscriptions_url
        self.starred_url = entity.starred_url
        self.gists_url = entity.gists_url
        self.following_url = entity.following_url
        self.followers_url = entity.followers_url
        self.html_url = entity.html_url
        self.url = entity.url
        self.gravatar_id = entity.gravatar_id
        self.avatar_url = entity.avatar_url
        self.node_id = entity.node_id
        self.public_gists = entity.public_gists
        self.public_repos = entity.public_repos
        self.bio = entity.bio
        self.hireable = entity.hireable
        self.email = entity.email
        self.following = entity.following
        self.followers = entity.followers
    }
    
    func addNotes(notes: String, inContext context: NSManagedObjectContext) {
        self.notes = notes
    }
    
    func fetchNotes(inContext context: NSManagedObjectContext) {
        let profile = UserProfile.fetchProfileWithID(self.user_id, inContext: context)
        if profile != nil {
            self.notes = profile?.notes
        }
        
    }
    
    class func fetchProfileWithID(_ user_id: Int32, inContext context: NSManagedObjectContext) -> UserProfile? {
        let request: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
        request.predicate = NSPredicate(format: "user_id = %d", user_id)
        return (try? context.fetch(request))?.first
    }
}
