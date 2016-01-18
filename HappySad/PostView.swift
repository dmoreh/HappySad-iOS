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
