//
//  UserProfileModel.swift
//  Git App
//
//  Created by Sergey Galagan on 19.03.2021.
//

import Foundation


struct UserProfileModel: Codable {
    let username: String!
    let user_id: Int32!
    let node_id: String!
    let avatar_url: String!
    let gravatar_id: String!
    let url: String!
    let html_url: String!
    let followers_url: String!
    let following_url: String!
    let gists_url: String!
    let starred_url: String!
    let subscriptions_url: String!
    let organizations_url: String!
    let repos_url: String!
    let events_url: String!
    let received_events_url: String!
    let type: String!
    let site_admin: Bool
    let name: String!
    let company: String!
    let blog: String!
    let location: String!
    let email: String!
    let hireable: String!
    let bio: String!
    let twitter_username: String!
    let public_repos: Int16!
    let public_gists: Int16!
    let followers: Int16!
    let following: Int16!
    
    
    enum itemKeys: String, CodingKey {
        case username = "login",
             user_id = "id",
             node_id,
             avatar_url,
             gravatar_id,
             url,
             html_url,
             followers_url,
             following_url,
             gists_url,
             starred_url,
             subscriptions_url,
             organizations_url,
             repos_url,
             events_url,
             received_events_url,
             type,
             site_admin,
             name,
             company,
             blog,
             location,
             email,
             hireable,
             bio,
             twitter_username,
             public_repos,
             public_gists,
             followers,
             following
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: itemKeys.self)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.user_id = try container.decodeIfPresent(Int32.self, forKey: .user_id)
        self.node_id = try container.decodeIfPresent(String.self, forKey: .node_id)
        self.avatar_url = try container.decodeIfPresent(String.self, forKey: .avatar_url) ?? ""
        self.gravatar_id = try container.decodeIfPresent(String.self, forKey: .gravatar_id) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.html_url = try container.decodeIfPresent(String.self, forKey: .html_url) ?? ""
        self.following_url = try container.decodeIfPresent(String.self, forKey: .following_url) ?? ""
        self.followers_url = try container.decodeIfPresent(String.self, forKey: .followers_url) ?? ""
        self.gists_url = try container.decodeIfPresent(String.self, forKey: .gists_url) ?? ""
        self.starred_url = try container.decodeIfPresent(String.self, forKey: .starred_url) ?? ""
        self.subscriptions_url = try container.decodeIfPresent(String.self, forKey: .subscriptions_url) ?? ""
        self.organizations_url = try container.decodeIfPresent(String.self, forKey: .organizations_url) ?? ""
        self.repos_url = try container.decodeIfPresent(String.self, forKey: .repos_url) ?? ""
        self.events_url = try container.decodeIfPresent(String.self, forKey: .events_url) ?? ""
        self.received_events_url = try container.decodeIfPresent(String.self, forKey: .received_events_url) ?? ""
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.site_admin = try container.decodeIfPresent(Bool.self, forKey: .site_admin)!
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.company = try container.decodeIfPresent(String.self, forKey: .company) ?? ""
        self.blog = try container.decodeIfPresent(String.self, forKey: .blog) ?? ""
        self.location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.hireable = try container.decodeIfPresent(String.self, forKey: .hireable) ?? ""
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio) ?? ""
        self.twitter_username = try container.decodeIfPresent(String.self, forKey: .twitter_username) ?? ""
        self.public_repos = try container.decodeIfPresent(Int16.self, forKey: .public_repos)
        self.public_gists = try container.decodeIfPresent(Int16.self, forKey: .public_gists)
        self.followers = try container.decodeIfPresent(Int16.self, forKey: .followers)
        self.following = try container.decodeIfPresent(Int16.self, forKey: .following)
    }
}
