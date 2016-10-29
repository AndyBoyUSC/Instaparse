//
//  TimelineViewController.swift
//  Parseagram
//
//  Created by Andrew Szot on 10/29/16.
//  Copyright © 2016 AndrewSzot. All rights reserved.
//

import UIKit
import Parse

class TimelineViewController: UIViewController {

    @IBOutlet weak var timelineTableView: UITableView!
    var posts:[AnyObject]? = nil
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loadQueryData()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        timelineTableView.addSubview(refreshControl)
    }
    
    func refresh(sender:AnyObject) {
        self.loadQueryData()
        
        refreshControl.endRefreshing()
    }
    
    func loadQueryData() {
        let query = PFQuery(className: "Post")
        query.whereKey("author", equalTo: PFUser.currentUser()!)
        
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                self.posts = posts
            }
            else {
                print("Some error")
            }
        }
        
        self.timelineTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.timelineTableView.dequeueReusableCellWithIdentifier("TimelineCellId") as! TimelineTableViewCell
        let post = self.posts![indexPath.row]
        let postImage = post.objectForKey("media") as! PFFile
        postImage.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
            if (error == nil) {
                let image = UIImage(data:imageData!)
                cell.cellImageView.image = image
            }
        }
        
        cell.cellLblView.text = post["caption"] as! String
        
        return cell
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
