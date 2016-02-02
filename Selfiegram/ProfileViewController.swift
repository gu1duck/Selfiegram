//
//  ProfileViewController.swift
//  Selfiegram
//
//  Created by Jeremy Petter on 2016-01-13.
//  Copyright © 2016 Jeremy Petter. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        self.userNameLabel.text = PFUser.currentUser()?.username
        if let imageFile = PFUser.currentUser()?["avatarImage"] as? PFFile {
            imageFile.getDataInBackgroundWithBlock({ (data, error) -> Void in

                if let imageData = data {
                    self.profileImageView.image = UIImage(data: imageData)
                }
            })
        }
    }

    @IBAction func cameraButtonPressed(sender: AnyObject) {
        print("camera button pressed")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if TARGET_OS_SIMULATOR == 1 {
            imagePicker.sourceType = .PhotoLibrary
        } else {
            imagePicker.sourceType = .Camera
            imagePicker.cameraDevice = .Front
            imagePicker.cameraCaptureMode = .Photo
        }
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {

            if let imageData = UIImageJPEGRepresentation(image, 0.9),
                let imageFile = PFFile(data: imageData),
                let user = PFUser.currentUser() {
                    user["avatarImage"] = imageFile
                    user.saveInBackgroundWithBlock({ (success, error) -> Void in
                        if success == true {
                            self.profileImageView.image = UIImage(data: imageData)

                        }
                    })
            }
        }
        dismissViewControllerAnimated(true, completion: nil)

    }
}