//
//  PostView.swift
//  HappySad
//
//  Created by Adam Reis on 1/16/16.
//  Copyright © 2016 Adam Reis. All rights reserved.
//

import UIKit

protocol PostViewDelegateProtocol {
    var post: Post? { get }
    func savePost(post: Post)
}

class PostView: UIView {
    var textColor = UIColor(colorLiteralRed: 207/255, green: 207/255, blue: 207/255, alpha: 1) // Light gray
    var placeholderColor = UIColor(colorLiteralRed: 100/255, green: 100/255, blue: 100/255, alpha: 0.5) // Gray
    var buttonTextColor = UIColor.whiteColor()
    var highlightColor = UIColor(colorLiteralRed: 74/255, green: 144/255, blue: 226/255, alpha: 1) // Blue

    var delegate: PostViewDelegateProtocol?
    var post: Post? {
        didSet {
            if let post = post {
                dayLabel.text = stringFromDate(post.day!)
                happyTextView.text = post.goodThing
                sadTextView.text = post.badThing
            }
        }
    }
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var happyTextView: UITextView!
    @IBOutlet var sadTextView: UITextView!
    @IBOutlet var submitButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.clearColor()
        happyTextView.backgroundColor = UIColor.clearColor()
        sadTextView.backgroundColor = UIColor.clearColor()

        dayLabel.textColor = highlightColor
        
        happyTextView.tintColor = highlightColor
        happyTextView.textColor = textColor
        happyTextView.placeholder = "What was the best moment of your day?"
        happyTextView.placeholderColor = placeholderColor
        
        sadTextView.textColor = textColor
        sadTextView.tintColor = highlightColor
        sadTextView.placeholder = "What was the worst moment of your day?"
        sadTextView.placeholderColor = placeholderColor
        
        submitButton.tintColor = buttonTextColor
        submitButton.backgroundColor = highlightColor
        
        let submitButtonCenter = submitButton.center
        submitButton.frame.size.width = 100
        submitButton.center = submitButtonCenter
        submitButton.layer.cornerRadius = 15
    }
    
    func stringFromDate(date: NSDate) -> String {
        let dayTimePeriodFormatter = NSDateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEEE, M/d/YY"
        return dayTimePeriodFormatter.stringFromDate(date)
    }
    
    func copyOverStrings() {
        post?.goodThing = happyTextView.text
        post?.badThing = sadTextView.text
    }
    
    @IBAction func saveButtonTapped(sender: UIButton) {
        copyOverStrings()
        delegate?.savePost(post!)
    }
}
