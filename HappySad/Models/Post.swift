//
//  Post.swift
//  HappySad
//
//  Created by Adam Reis on 1/16/16.
//  Copyright © 2016 Adam Reis. All rights reserved.
//

import Foundation

class Post : PFObject, PFSubclassing {
    
    @NSManaged var goodThing: String?
    @NSManaged var badThing: String?
    @NSManaged var day: NSDate?
    @NSManaged var user: PFUser?
    
    
    //MARK: PFSubclassing Protocol
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    override init () {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    func uploadPost() {
        user = PFUser.currentUser()
        saveInBackgroundWithBlock(nil)
    }
}