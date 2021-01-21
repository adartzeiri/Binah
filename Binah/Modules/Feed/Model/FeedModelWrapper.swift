//
//  FeedModel.swift
//  Binah
//
//  Created by Adar Tzeiri on 19/01/2021.
//

import Foundation

struct FeedModelWrapper : Codable {
    let feedModels : [FeedModel]?
    let has_more : Bool?
    let quota_max : Int?
    let quota_remaining : Int?

    enum CodingKeys: String, CodingKey {

        case feedModels = "items"
        case has_more = "has_more"
        case quota_max = "quota_max"
        case quota_remaining = "quota_remaining"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        feedModels = try values.decodeIfPresent([FeedModel].self, forKey: .feedModels)
        has_more = try values.decodeIfPresent(Bool.self, forKey: .has_more)
        quota_max = try values.decodeIfPresent(Int.self, forKey: .quota_max)
        quota_remaining = try values.decodeIfPresent(Int.self, forKey: .quota_remaining)
    }
}

struct FeedModel : Codable {
    let tags : [String]?
    let owner : Owner?
    let is_answered : Bool?
    let view_count : Int?
    let answer_count : Int?
    let score : Int?
    let last_activity_date : Int?
    let creation_date : Int?
    let question_id : Int?
    let content_license : String?
    let link : String?
    let title : String?

    enum CodingKeys: String, CodingKey {

        case tags = "tags"
        case owner = "owner"
        case is_answered = "is_answered"
        case view_count = "view_count"
        case answer_count = "answer_count"
        case score = "score"
        case last_activity_date = "last_activity_date"
        case creation_date = "creation_date"
        case question_id = "question_id"
        case content_license = "content_license"
        case link = "link"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tags = try values.decodeIfPresent([String].self, forKey: .tags)
        owner = try values.decodeIfPresent(Owner.self, forKey: .owner)
        is_answered = try values.decodeIfPresent(Bool.self, forKey: .is_answered)
        view_count = try values.decodeIfPresent(Int.self, forKey: .view_count)
        answer_count = try values.decodeIfPresent(Int.self, forKey: .answer_count)
        score = try values.decodeIfPresent(Int.self, forKey: .score)
        last_activity_date = try values.decodeIfPresent(Int.self, forKey: .last_activity_date)
        creation_date = try values.decodeIfPresent(Int.self, forKey: .creation_date)
        question_id = try values.decodeIfPresent(Int.self, forKey: .question_id)
        content_license = try values.decodeIfPresent(String.self, forKey: .content_license)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}

struct Owner : Codable {
    let reputation : Int?
    let user_id : Int?
    let user_type : String?
    let profile_image : String?
    let display_name : String?
    let link : String?

    enum CodingKeys: String, CodingKey {

        case reputation = "reputation"
        case user_id = "user_id"
        case user_type = "user_type"
        case profile_image = "profile_image"
        case display_name = "display_name"
        case link = "link"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reputation = try values.decodeIfPresent(Int.self, forKey: .reputation)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        user_type = try values.decodeIfPresent(String.self, forKey: .user_type)
        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
        display_name = try values.decodeIfPresent(String.self, forKey: .display_name)
        link = try values.decodeIfPresent(String.self, forKey: .link)
    }
}
