//
//  PostViewController.swift
//  HappySad
//
//  Created by Daniel Moreh on 1/16/16.
//  Copyright © 2016 Adam Reis. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITextViewDelegate {
    var post: Post? {
        didSet {
            postView?.post = post
        }
    }
    @IBOutlet var postView: PostView?
    var colorScheme: ColorScheme = ColorScheme.randomColorScheme()
    var pageIndex: Int?
    var timer: NSTimer?
    var maxWords: Int = NSUserDefaults.standardUserDefaults().integerForKey("maxWords")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postView?.delegate = self
        postView?.post = post
        
        postView!.happyTextView.delegate = self
        postView!.sadTextView.delegate = self
        
        view.backgroundColor = colorScheme.backgroundColor
        
        postView!.dayLabel.textColor = colorScheme.tintColor
        postView!.happyTextView.tintColor = colorScheme.tintColor
        postView!.happyTextView.textColor = colorScheme.textColor
        postView!.happyTextView.placeholder = "What was the best moment of your day?"
        postView!.happyTextView.placeholderColor = colorScheme.placeholderColor
        postView!.happyUnderlineView.backgroundColor = colorScheme.tintColor
        
        postView!.sadTextView.textColor = colorScheme.textColor
        postView!.sadTextView.tintColor = colorScheme.tintColor
        postView!.sadTextView.placeholder = "What was the worst moment of your day?"
        postView!.sadTextView.placeholderColor = colorScheme.placeholderColor
        postView!.sadUnderlineView.backgroundColor = colorScheme.tintColor
        
        postView!.submitButton.tintColor = colorScheme.buttonTextColor
        postView!.submitButton.backgroundColor = colorScheme.tintColor
        
        postView!.happyCounter.textColor = colorScheme.textColor
        postView!.sadCounter.textColor = colorScheme.textColor
        
        postView!.submitButton.backgroundColor = colorScheme.backgroundColor
        postView!.submitButton.tintColor = colorScheme.tintColor

        // Hack for first one to start dirty.
        if colorScheme.tintColor == ColorScheme.blackColorScheme().tintColor {
            postView!.submitButton.tintColor = colorScheme.buttonTextColor
            postView!.submitButton.backgroundColor = colorScheme.tintColor
        }

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
        
        if wordCount <= self.maxWords {
            if textView == postView?.happyTextView {
                postView?.happyCounter.text = "\(11 - wordCount)"
            } else if textView == postView?.sadTextView {
                postView?.sadCounter.text = "\(11 - wordCount)"
            }
            return true
        }
        
        return false
    }
    
    func textViewDidChange(textView: UITextView) {
        postView!.submitButton.tintColor = colorScheme.buttonTextColor
        postView!.submitButton.backgroundColor = colorScheme.tintColor
    }
}

extension PostViewController: PostViewDelegateProtocol {
    func savePost(post: Post) {
        post.uploadPost()
        
        postView!.submitButton.backgroundColor = colorScheme.backgroundColor
        postView!.submitButton.tintColor = colorScheme.tintColor
    }
}

