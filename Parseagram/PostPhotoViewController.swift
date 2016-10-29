//
//  PostPhotoViewController.swift
//  Parseagram
//
//  Created by Andrew Szot on 10/29/16.
//  Copyright © 2016 AndrewSzot. All rights reserved.
//

import UIKit

class PostPhotoViewController: UIViewController {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPost(sender: AnyObject) {
        PostModel.postUserImage(postImageView.image, withCaption: captionView.text) { (success, error) in
            self.dismissViewControllerAnimated(true, completion: {})
        }
        
    }
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
