//
//  Post.swift
//  Selfiegram
//
//  Created by Jeremy Petter on 2016-01-13.
//  Copyright © 2016 Jeremy Petter. All rights reserved.
//

import UIKit

class Post {
    let image:UIImage
    let user:User
    let comment:String

    init(image:UIImage, user:User, comment:String) {
        self.image = image
        self.user = user
        self.comment = comment
    }

}
