//
//  LoginViewController.swift
//  HappySad
//
//  Created by Adam Reis on 1/17/16.
//  Copyright © 2016 Adam Reis. All rights reserved.
//

import UIKit

class LoginViewController : PFLogInViewController {
    
    var backgroundImage : UIImageView!;
    var viewsToAnimate: [UIView!]!;
    var viewsFinalYPosition : [CGFloat]!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set our logo
        let logo = UILabel()
        logo.text = "Day to Day"
        logo.textColor = UIColor(red: 14/255, green: 28/255, blue: 87/255, alpha: 1)
        logo.font = UIFont(name: "HelveticaNeue-Thin", size: 60)
        
        logInView?.logo = logo
        
        // set our custom background image
        backgroundImage = UIImageView(image: UIImage(named: "launch_background"))
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.logInView!.insertSubview(backgroundImage, atIndex: 0)
        
        // login button
        logInView?.logInButton?.setBackgroundImage(nil, forState: .Normal)
        logInView?.logInButton?.backgroundColor = UIColor(red: 97/255, green: 187/255, blue: 223/255, alpha: 1)
        
        // forgot password
        logInView?.passwordForgottenButton?.setTitleColor(UIColor(red: 14/255, green: 28/255, blue: 87/255, alpha: 1), forState: .Normal)
        
        // make the buttons classier
        customizeButton(logInView?.facebookButton!)
        customizeButton(logInView?.twitterButton!)
        customizeButton(logInView?.signUpButton!)
        
        // make fields slightly see-through
        logInView?.usernameField?.backgroundColor = UIColor(red: 255/255, green: 253/255, blue: 243/255, alpha: 0.9)
        logInView?.passwordField?.backgroundColor = UIColor(red: 255/255, green: 253/255, blue: 243/255, alpha: 0.9)
        
        let emailStr = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName:UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)])
        let passwordStr = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName:UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)])
        logInView?.usernameField?.attributedPlaceholder = emailStr
        logInView?.passwordField?.attributedPlaceholder = passwordStr
        
        // animate that shit
        viewsToAnimate = [self.logInView?.usernameField, self.logInView?.passwordField, self.logInView?.logInButton, self.logInView?.passwordForgottenButton, self.logInView?.facebookButton, self.logInView?.twitterButton, self.logInView?.signUpButton, self.logInView?.logo]

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // stretch background image to fill screen
        backgroundImage.frame = CGRectMake( 0,  0,  self.logInView!.frame.width,  self.logInView!.frame.height)
        
        // position logo at top with larger frame
        logInView!.logo!.sizeToFit()
        let logoFrame = logInView!.logo!.frame
        logInView!.logo!.frame = CGRectMake(logoFrame.origin.x, logInView!.usernameField!.frame.origin.y - logoFrame.height - 140, logInView!.frame.width,  logoFrame.height)
        
        // animate things
        viewsFinalYPosition = [CGFloat]();
        for viewToAnimate in viewsToAnimate {
            let currentFrame = viewToAnimate.frame
            viewsFinalYPosition.append(currentFrame.origin.y)
            viewToAnimate.frame = CGRectMake(currentFrame.origin.x, self.view.frame.height + currentFrame.origin.y, currentFrame.width, currentFrame.height)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Now we'll animate all our views back into view
        // and, using the final position we stored, we'll
        // reset them to where they should be
        if viewsFinalYPosition.count == self.viewsToAnimate.count {
            UIView.animateWithDuration(1, delay: 0.0, options: .CurveEaseInOut,  animations: { () -> Void in
                for viewToAnimate in self.viewsToAnimate {
                    let currentFrame = viewToAnimate.frame
                    viewToAnimate.frame = CGRectMake(currentFrame.origin.x, self.viewsFinalYPosition.removeAtIndex(0), currentFrame.width, currentFrame.height)
                }
                }, completion: nil)
        }
    }
    
    func customizeButton(button: UIButton!) {
        button.setBackgroundImage(nil, forState: .Normal)
        button.backgroundColor = UIColor(red: 14/255, green: 28/255, blue: 87/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 14/255, green: 28/255, blue: 87/255, alpha: 1).CGColor
        
        
    }
    
}