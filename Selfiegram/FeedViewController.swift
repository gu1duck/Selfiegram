//
//  FeedViewController.swift
//  Selfiegram
//
//  Created by Jeremy Petter on 2016-01-20.
//  Copyright © 2016 Jeremy Petter. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController {
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let me = User(username: "Jer", profilePicture: UIImage(named: "grumpy-cat")!)
        let post1 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Comment 1")
        let post2 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Comment 2")
        let post3 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Comment 3")
        let post4 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Comment 4")
        let post5 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Comment 5")

        posts = [post1, post2, post3, post4, post5]
       }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! SelfieCell

        let post = self.posts[indexPath.row]
        
        cell.selfieImageView.image = post.image
        cell.usernameLabel.text = post.user.username
        cell.commentLabel.text = post.comment

        return cell
    }
}