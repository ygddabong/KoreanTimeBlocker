//
//  AppDelegate.swift
//  KoreanTimeBlocker
//
//  Created by 송용규 on 06/04/2020.
//  Copyright © 2020 송용규. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("API KEY")
        GMSPlacesClient.provideAPIKey("API KEY")
        return true
    }

}

