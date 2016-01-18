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

        let submitButtonCenter = submitButton.center
        submitButton.frame.size.width = 100
        submitButton.center = submitButtonCenter
        submitButton.layer.cornerRadius = 15
    }
    
    func stringFromDate(date: NSDate) -> String {
        if NSCalendar.currentCalendar().isDateInToday(date) {
            return "Today"
        } else if NSCalendar.currentCalendar().isDateInToday(date.dateByAddingTimeInterval(60*60*24)) {
            return "Yesterday"
        }
        
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
