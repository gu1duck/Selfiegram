//
//  ProfileViewController.swift
//  Selfiegram
//
//  Created by Jeremy Petter on 2016-01-13.
//  Copyright © 2016 Jeremy Petter. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        userNameLabel.text = "yourName"
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
            profileImageView.image = image
        }
        dismissViewControllerAnimated(true, completion: nil)

    }
}