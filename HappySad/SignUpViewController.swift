//
//  SignUpViewController.swift
//  HappySad
//
//  Created by Adam Reis on 1/17/16.
//  Copyright © 2016 Adam Reis. All rights reserved.
//

import UIKit

class SignUpViewController : PFSignUpViewController {
    
    var backgroundImage : UIImageView!;
    
    // Colors
    let seeThroughColor = UIColor(red: 255/255, green: 253/255, blue: 243/255, alpha: 0.9)
    let darkBlueColor   = UIColor(red: 14/255, green: 28/255, blue: 87/255, alpha: 1)
    let lightBlueColor  = UIColor(red: 97/255, green: 187/255, blue: 223/255, alpha: 1)
    let greyColor       = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set our custom background image
        backgroundImage = UIImageView(image: UIImage(named: "launch_background"))
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        signUpView!.insertSubview(backgroundImage, atIndex: 0)
        
        // remove the parse Logo
        let logo = UILabel()
        logo.text = "Day to Day"
        logo.textColor = darkBlueColor
        logo.font = UIFont(name: "HelveticaNeue-Thin", size: 60)
        signUpView?.logo = logo

        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        signUpView?.signUpButton?.setBackgroundImage(nil, forState: .Normal)
        signUpView?.signUpButton?.backgroundColor = lightBlueColor
        
        let emailStr = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName:greyColor])
        let passwordStr = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName:greyColor])
        signUpView?.usernameField?.attributedPlaceholder = emailStr
        signUpView?.passwordField?.attributedPlaceholder = passwordStr

        // make fields slightly see-through
        signUpView?.usernameField?.backgroundColor = seeThroughColor
        signUpView?.passwordField?.backgroundColor = seeThroughColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // stretch background image to fill screen
        backgroundImage.frame = CGRectMake( 0,  0,  signUpView!.frame.width,  signUpView!.frame.height)
        
        // position logo at top with larger frame
        signUpView!.logo!.sizeToFit()
        let logoFrame = signUpView!.logo!.frame
        signUpView!.logo!.frame = CGRectMake(logoFrame.origin.x, signUpView!.usernameField!.frame.origin.y - logoFrame.height - 140, signUpView!.frame.width,  logoFrame.height)
    }
    
}