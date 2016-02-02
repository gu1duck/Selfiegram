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

        let flickerAPICall = NSURL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=e33dc5502147cf3fd3515aa44224783f&tags=cat")
        if let APICall = flickerAPICall {
            let task = NSURLSession.sharedSession().dataTaskWithURL(APICall) {(data, response, error) -> Void in

                if let unformattedJSON = try? NSJSONSerialization.JSONObjectWithData(data!, options: []),
                    let jsonDictionary = unformattedJSON as? [String: AnyObject],
                    let photosDictionary = jsonDictionary["photos"] as? [String: AnyObject],
                    let photosArray = photosDictionary["photo"] as? [AnyObject] {
                        for photo in photosArray {
                            if let farmID = photo["farm"] as? Int,
                                let serverID = photo["server"] as? String,
                                let photoID = photo["id"] as? String,
                                let secret = photo["secret"] as? String {
                                    let photoString = "https://farm\(farmID).staticflickr.com/\(serverID)/\(photoID)_\(secret).jpg"
                                    let photoURL = NSURL(string: photoString)!

                                    let post = Post(imageURL: photoURL, user: me, comment: "COMMENT")
                                    self.posts.append(post)
                            }
                        }
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in

                            self.tableView.reloadData()
                        })

                } else {
                    print("ERROR")
                }
            }
            task.resume()
            print("END DATA")
        }

//        let post1 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Comment 1")
//        let post2 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Comment 2")
//        let post3 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Comment 3")
//        let post4 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Comment 4")
//        let post5 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Comment 5")

//        posts = [post1, post2, post3, post4, post5]
       }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! SelfieCell

        let post = self.posts[indexPath.row]
        
        let task = NSURLSession.sharedSession().downloadTaskWithURL(post.imageURL) { (URL, response, ErrorType) -> Void in

            if let imageURL = URL,
                let imageData = NSData(contentsOfURL: imageURL) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in

                        cell.selfieImageView.image = UIImage(data: imageData)
                    })
            }
        }
        task.resume()

        cell.usernameLabel.text = post.user.username
        cell.commentLabel.text = post.comment

        return cell
    }
}