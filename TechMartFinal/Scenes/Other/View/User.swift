//
//  User.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/28/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//
import ObjectMapper

class User: BaseModel {
    var id: Int = 0
    var name: String = ""
    var email: String = ""
    var imageProfileURLString: String?
    var imageCoverURLString: String?
    var gender: UserGender = .male
    var userId: String = ""

    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["id"]
        email <- map["id"]
        imageProfileURLString <- map["id"]
        imageCoverURLString <- map["id"]
        gender <- map["id"]
        userId <- map["id"]
    }
    
    init(id: Int, name: String, email: String, imageProfileUrl: String?, imageCoverUrl: String?, gender: UserGender, userId: String) {
        self.id = id
        self.name = name
        self.email = email
        self.imageProfileURLString = imageProfileUrl
        self.imageCoverURLString = imageCoverUrl
        self.gender = gender
        self.userId = userId
    }
}

struct UserModel {
    let user: User
}

extension User {
    var circleAvatar: UIImage {
        return gender == .male ? #imageLiteral(resourceName: "group1") : #imageLiteral(resourceName: "ic_icon_female")
    }
    
    var defaultAvatar: UIImage {
        return gender == .male ? #imageLiteral(resourceName: "group1") : #imageLiteral(resourceName: "ic_icon_female")
    }
}

enum UserGender: String {
    case male
    case female
}


