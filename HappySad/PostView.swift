//
//  PostView.swift
//  HappySad
//
//  Created by Adam Reis on 1/16/16.
//  Copyright © 2016 Adam Reis. All rights reserved.
//

import UIKit

protocol PostViewDelegateProtocol {
    func savePost(post: Post)
}

class PostView: UIView {
    var delegate: PostViewDelegateProtocol?
    var post: Post? {
        didSet {
            if let post = post {
                dayLabel.text = stringFromDate(post.day!)
                happyTextField.text = post.goodThing
                sadTextField.text = post.badThing
            }
        }
    }
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var happyTextField: UITextField!
    @IBOutlet var sadTextField: UITextField!
    
    func stringFromDate(date: NSDate) -> String {
        let dayTimePeriodFormatter = NSDateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEEE, M/d/YY"
        return dayTimePeriodFormatter.stringFromDate(date)
    }
    
    @IBAction func saveButtonTapped(sender: UIButton) {
        post?.goodThing = happyTextField.text
        post?.badThing = sadTextField.text
        delegate?.savePost(post!)
    }
}
