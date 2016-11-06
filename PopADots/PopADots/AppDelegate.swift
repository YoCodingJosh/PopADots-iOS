//
//  AppDelegate.swift
//  Pop a Dots
//
//  Created by Josh Kennedy on 6/11/15.
//  Copyright © 2015-2016 Sirkles LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    enum ShortcutIdentifier: String {
        case ClassicShortcut
        case ArcadeShortcut
        case VoidsShortcut
        case InsaneShortcut
        
        // MARK: - Initializers
        
        init?(fullType: String) {
            guard let last = fullType.characters.split(separator: ".").map(String.init).last else { return nil }
            
            self.init(rawValue: last)
        }
        
        // MARK: - Properties
        
        var type: String {
            return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }
    }
    
    /// Saved shortcut item used as a result of an app launch, used later when app is activated.
    var launchedShortcutItem: UIApplicationShortcutItem?
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        // Verify that the provided `shortcutItem`'s `type` is one handled by the application.
        guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else { return false }
        
        guard let shortCutType = shortcutItem.type as String? else { return false }
        
        switch (shortCutType) {
        case ShortcutIdentifier.ClassicShortcut.type:
            // Handle Classic shortcut (static).
            startedGameplay = GameState.Classic
            didStartViaShortcut = true
            print("Starting Classic mode (via shortcut)")
            
            handled = true
            break
        case ShortcutIdentifier.ArcadeShortcut.type:
            // Handle Arcade shortcut (static).
            startedGameplay = GameState.Arcade
            didStartViaShortcut = true
            print("Starting Arcade mode (via shortcut)")
            
            handled = true
            break
        case ShortcutIdentifier.VoidsShortcut.type:
            // Handle Voids shortcut (static).
            startedGameplay = GameState.Voids
            didStartViaShortcut = true
            print("Starting Voids mode (via shortcut)")
            
            handled = true
            break
        case ShortcutIdentifier.InsaneShortcut.type:
            // Handle Insane shortcut (static).
            startedGameplay = GameState.Insane
            didStartViaShortcut = true
            print("Starting Insane mode (via shortcut)")
            
            handled = true
            break
        default:
            break
        }
        
        return handled
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Override point for customization after application launch.
        var shouldPerformAdditionalDelegateHandling = true
        
        // If a shortcut was launched, display its information and take the appropriate action
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            
            launchedShortcutItem = shortcutItem
            
            // This will block "performActionForShortcutItem:completionHandler" from being called.
            shouldPerformAdditionalDelegateHandling = false
        }
        
        return shouldPerformAdditionalDelegateHandling
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem: shortcutItem)
        
        print("Shortcut tapped")
        
        completionHandler(handledShortCutItem)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //AdStateMachine.resume()
        
        guard let shortcut = launchedShortcutItem else { return }
        
        _ = handleShortCutItem(shortcutItem: shortcut)
        
        launchedShortcutItem = nil
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        //AdStateMachine.pause()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //AdStateMachine.pause()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        //AdStateMachine.resume()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        //AdStateMachine.stop()
        print("Bye! We'll miss you.")
    }
}
