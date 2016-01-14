//
//  User.swift
//  Selfiegram
//
//  Created by Jeremy Petter on 2016-01-13.
//  Copyright © 2016 Jeremy Petter. All rights reserved.
//

import UIKit

class User {
    var username: String?
    var profilePicture: UIImage?

    init(username: String, profilePicture: UIImage) {
        self.username = username
        self.profilePicture = profilePicture
    }

}
