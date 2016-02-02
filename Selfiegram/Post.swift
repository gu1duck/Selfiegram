//
//  Post.swift
//  Selfiegram
//
//  Created by Jeremy Petter on 2016-01-13.
//  Copyright © 2016 Jeremy Petter. All rights reserved.
//

import UIKit

class Post {
    let imageURL:NSURL
    let user:User
    let comment:String

    init(imageURL:NSURL, user:User, comment:String) {
        self.imageURL = imageURL
        self.user = user
        self.comment = comment
    }

}
