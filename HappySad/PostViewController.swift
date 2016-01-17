//
//  PostViewController.swift
//  HappySad
//
//  Created by Daniel Moreh on 1/16/16.
//  Copyright © 2016 Adam Reis. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITextFieldDelegate {

    var post: Post? {
        didSet {
            postView?.post = post
        }
    }
    @IBOutlet var postView: PostView?
    var pageIndex: Int?
    var timer: NSTimer?
    
    @IBOutlet var happyTextField: UITextField!
    @IBOutlet var sadTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postView?.delegate = self
        postView?.post = post

        happyTextField.delegate = self
        sadTextField.delegate = self
        
        happyTextField.addTarget(self, action: "resetTimer", forControlEvents: UIControlEvents.EditingChanged)
        sadTextField.addTarget(self, action: "resetTimer", forControlEvents: UIControlEvents.EditingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        savePost()
    }
    
    func savePost() {
        print("savePost called")
//        if let myPost = post,
//            postView = postView,
//            otherPost = postView.post{
//                postView.copyOverStrings()
//                otherPost.uploadPost()
//        }
    }

    func resetTimer() {
        print("resetting timer")
        if let timer = timer {
            if timer.valid {
                timer.invalidate()
            }
        }
        timer = NSTimer(timeInterval: 5, target: self, selector: Selector("savePost"), userInfo: nil, repeats: false)
        
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSDefaultRunLoopMode)
    }
}

extension PostViewController: PostViewDelegateProtocol {
    func savePost(post: Post) {
        post.uploadPost()
    }
}
