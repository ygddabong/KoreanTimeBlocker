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
        // The key comes from the GMS_API_KEY build setting via Info.plist (see README),
        // so it never has to be written into source code.
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "GMSApiKey") as? String ?? ""
        if apiKey.isEmpty {
            print("⚠️ GMSApiKey is empty — set the GMS_API_KEY build setting (see README).")
        }
        GMSServices.provideAPIKey(apiKey)
        GMSPlacesClient.provideAPIKey(apiKey)

        return true
    }

}

