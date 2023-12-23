//
//  Constants.swift
//  MusicAPPDemo
//
//  Created by Mahesh babu on 22/12/23.
//

import Foundation
import UIKit

class Constants{
    
    struct Storyboards {
        static let main = UIStoryboard(name: "Main", bundle: nil)
    }
    
    struct API {
        static let apiUrl = URL(string: "http://demo0713550.mockable.io/getOrderList")
    }
    
    struct TextStrings {
        static let showMore =     "Show More"
        static let welcome  =     "Welcome"
        static let apiErrorMessage  =     "Unable to convert data to string"
    }
    
    struct Fonts {
        static let textHeaderFont  = UIFont.systemFont(ofSize: 20, weight: .semibold)
        static let btnTextFont      = UIFont.systemFont(ofSize: 14, weight: .bold)
        static let headerLabelFont = UIFont.systemFont(ofSize: 30, weight: .semibold)
    }
    
    struct CellRegister{
        static let MusicCollectionViewCell = "MusicCollectionViewCell"
        static let MusicHomeTableCell = "MusicHomeTableCell"
    }
    
}

extension UIColor{
    
    static let textColor = UIColor(named: "textColor")
    static let pineGreen   = UIColor(named: "pineColor")
    static let darkBlue   = UIColor(named: "newBlue")
    static let pineBlueClr   = UIColor(named: "pineBlue")
    static let limeGreenClr   = UIColor(named: "limeGreen")
    
}
