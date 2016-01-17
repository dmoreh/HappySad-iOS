//
//  ViewController.swift
//  HappySad
//
//  Created by Adam Reis on 1/16/16.
//  Copyright © 2016 Adam Reis. All rights reserved.
//

import UIKit

class MainPageViewController: UIPageViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    var posts: [Post]!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.dataSource = self
        
        let vc = UIViewController()
        let view = UIView(frame: CGRectMake(100,100,100,100))
        view.backgroundColor = UIColor.redColor()
        vc.view = view
        
        self.setViewControllers([vc], direction: .Forward, animated: false, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (PFUser.currentUser() == nil) {
            let loginViewController = PFLogInViewController()
            loginViewController.delegate = self
            loginViewController.fields = [.UsernameAndPassword, .LogInButton, .PasswordForgotten, .SignUpButton, .Facebook, .Twitter]
            loginViewController.emailAsUsername = true
            loginViewController.signUpController?.delegate = self
            self.presentViewController(loginViewController, animated: false, completion: nil)
        } else {
            // Get all Posts from Parse. Store them in an ivar. Order by date. Make sure there's one for today.
            // Show today. 
            let postsQuery = Post.query()!
            postsQuery.whereKey("user", equalTo: PFUser.currentUser()!)
            postsQuery.findObjectsInBackgroundWithBlock {(objects:[PFObject]?, error: NSError?) -> Void in
                self.posts = objects as? [Post] ?? []
                self.index = self.posts.count - 1
                
                let post = self.posts.last!
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let postViewController = storyboard.instantiateViewControllerWithIdentifier("PostViewController") as! PostViewController
                postViewController.post = post
                for post in self.posts {
                    print(post)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.setViewControllers([postViewController], direction: .Forward, animated: false, completion: nil)
                })
            }
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func presentLoggedInAlert() {
        let alertController = UIAlertController(title: "You're logged in", message: "Welcome to HAPPY?!?!SAD!?!", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        print("previous")
        
        // None left, don't scroll.
        if self.index == 0 {
            return nil
        }
        
        self.index = self.index - 1
        let post: Post = self.posts![self.index!]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let postViewController = storyboard.instantiateViewControllerWithIdentifier("PostViewController") as! PostViewController
        postViewController.post = post
        return postViewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        print("next")
        
        // None left, don't scroll.
        if self.index == self.posts.count - 1 {
            return nil
        }
        
        self.index = self.index + 1
        let post: Post = self.posts![self.index!]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let postViewController = storyboard.instantiateViewControllerWithIdentifier("PostViewController") as! PostViewController
        postViewController.post = post
        return postViewController
    }
}
