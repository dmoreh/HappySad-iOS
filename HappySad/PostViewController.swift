//
//  PostViewController.swift
//  HappySad
//
//  Created by Daniel Moreh on 1/16/16.
//  Copyright © 2016 Adam Reis. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITextViewDelegate {

    let textColor = UIColor.redColor()
    let backgroundColor = UIColor.blueColor()
    let underlineColor = UIColor.greenColor()
    
    var post: Post? {
        didSet {
            postView?.post = post
        }
    }
    @IBOutlet var postView: PostView?
    var pageIndex: Int?
    var timer: NSTimer?
    var maxWords: Int = NSUserDefaults.standardUserDefaults().integerForKey("maxWords")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postView?.delegate = self
        postView?.post = post
        
        self.postView!.happyTextView.delegate = self
        self.postView!.sadTextView.delegate = self
        
        // UI
        self.postView!.backgroundColor = UIColor.clearColor()
        self.postView!.happyTextView.backgroundColor = UIColor.clearColor()
        self.postView!.sadTextView.backgroundColor = UIColor.clearColor()

        self.view.backgroundColor = self.backgroundColor
        self.postView!.happyTextView.textColor = self.textColor
        self.postView!.sadTextView.textColor = self.textColor

        // For autosaving. Lost during the textField -> textView refactor.
//        happyTextView.addTarget(self, action: "resetTimer", forControlEvents: UIControlEvents.EditingChanged)
//        sadTextView.addTarget(self, action: "resetTimer", forControlEvents: UIControlEvents.EditingChanged)
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
 
    // MARK - UITextViewDelegate
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newString: String = (textView.text! as NSString).stringByReplacingCharactersInRange(range, withString: text)
        let wordCount = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).count
        
        return wordCount <= self.maxWords
    }
}

extension PostViewController: PostViewDelegateProtocol {
    func savePost(post: Post) {
        post.uploadPost()
    }
}

