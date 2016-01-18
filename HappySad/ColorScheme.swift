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
            buttonTextColor: self.blackColor()
        )
    }
    
    class func blackYellowColorScheme() -> ColorScheme {
        return ColorScheme(
            backgroundColor: self.blackColor(),
            textColor: UIColor.whiteColor(),
            tintColor: UIColor.yellowColor(),
            placeholderColor: UIColor.grayColor(),
            buttonTextColor: self.blackColor()
        )
    }
    
    class func blackOrangeColorScheme() -> ColorScheme {
        return ColorScheme(
            backgroundColor: self.blackColor(),
            textColor: UIColor.whiteColor(),
            tintColor: UIColor.orangeColor(),
            placeholderColor: UIColor.grayColor(),
            buttonTextColor: self.blackColor()
        )
    }
    
    class func blackPurpleColorScheme() -> ColorScheme {
        return ColorScheme(
            backgroundColor: self.blackColor(),
            textColor: UIColor.whiteColor(),
            tintColor: UIColor.purpleColor(),
            placeholderColor: UIColor.grayColor(),
            buttonTextColor: self.blackColor()
        )
    }
    
    class func blackGreenColorScheme() -> ColorScheme {
        return ColorScheme(
            backgroundColor: self.blackColor(),
            textColor: UIColor.whiteColor(),
            tintColor: UIColor.greenColor(),
            placeholderColor: UIColor.grayColor(),
            buttonTextColor: self.blackColor()
        )
    }
    
    class func randomColorScheme() -> ColorScheme {
        let schemes = [
            blackYellowColorScheme(),
            blackOrangeColorScheme(),
            blackPurpleColorScheme(),
            blackGreenColorScheme(),
        ]
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
