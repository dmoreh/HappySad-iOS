//
//  ColorScheme.swift
//  HappySad
//
//  Created by Daniel Moreh on 1/17/16.
//  Copyright © 2016 Adam Reis. All rights reserved.
//

class ColorScheme: NSObject {
    var backgroundColor: UIColor!
    var textColor: UIColor!
    var tintColor: UIColor!
    var placeholderColor: UIColor!
    var buttonTextColor: UIColor!
    
    convenience init(backgroundColor: UIColor, textColor: UIColor, tintColor: UIColor, placeholderColor: UIColor, buttonTextColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.tintColor = tintColor
        self.placeholderColor = placeholderColor
        self.buttonTextColor = buttonTextColor
    }

    class func blackColorScheme() -> ColorScheme {
        return ColorScheme(
            backgroundColor: self.blackColor(),
            textColor: UIColor.whiteColor(),
            tintColor: self.blueColor(),
            placeholderColor: UIColor.grayColor(),
            buttonTextColor: UIColor.whiteColor()
        )
    }
    
    class func randomColorScheme() -> ColorScheme {
        let schemes = [blackColorScheme()]
        let randomIndex = Int(arc4random_uniform(UInt32(schemes.count)))
        return schemes[randomIndex]
    }
    
    private class func blackColor() -> UIColor {
        return UIColor(colorLiteralRed: 32/255, green: 32/255, blue: 32/255, alpha: 1)
    }
    
    private class func blueColor() -> UIColor {
        return UIColor(colorLiteralRed: 74/255, green: 144/255, blue: 226/255, alpha: 1)
    }

}
