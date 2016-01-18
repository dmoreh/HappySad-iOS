//
//  PostViewController.swift
//  HappySad
//
//  Created by Daniel Moreh on 1/16/16.
//  Copyright © 2016 Adam Reis. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITextViewDelegate {

    
    var textColor = UIColor(colorLiteralRed: 207/255, green: 207/255, blue: 207/255, alpha: 1) // Light gray
    var backgroundColor = UIColor(colorLiteralRed: 32/255, green: 32/255, blue: 32/255, alpha: 1) // Black
    var underlineColor = UIColor(colorLiteralRed: 74/255, green: 144/255, blue: 226/255, alpha: 1) // Blue
    var placeholderColor = UIColor(colorLiteralRed: 100/255, green: 100/255, blue: 100/255, alpha: 0.5) // Gray

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
        
        postView!.happyTextView.delegate = self
        postView!.sadTextView.delegate = self
        
        // UI
        postView!.backgroundColor = UIColor.clearColor()
        postView!.happyTextView.backgroundColor = UIColor.clearColor()
        postView!.sadTextView.backgroundColor = UIColor.clearColor()

        view.backgroundColor = backgroundColor
        
        postView!.dayLabel.textColor = textColor

        postView!.happyTextView.textColor = textColor
        postView!.happyTextView.placeholder = "What was the best moment of your day?"
        postView!.happyTextView.placeholderColor = placeholderColor
        
        postView!.sadTextView.textColor = textColor
        postView!.sadTextView.placeholder = "What was the worst moment of your day?"
        postView!.sadTextView.placeholderColor = placeholderColor

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

