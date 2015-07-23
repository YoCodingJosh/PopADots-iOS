# Pop a Dots (iOS) #

***OHHH YEAH!!!*** The iOS version of the world famous Pop a Dots.

### Requirements ###

* A Mac running 10.10 (Yosemite) or later
* Latest Xcode 7 beta from Apple Developer Center (latest version 4)
* An iOS device running iOS 9 or later.
    * Why iOS 9?
        * It's mandatory to support the latest stable APIs like SpriteKit and GameCenter (to name a few).
        * It will support the same devices that run iOS 8.

### How do I get set up? ###

* Check out the latest master branch.
* Open the Xcode project and try to build and run (the Play button)
* There will be a few errors.
    * One of them will require you to login using your Apple ID associated with Sirkles.
    * Another one will be for you to provision your device (if you're going to debug on a device).
    * Just keep clicking on the Fix Issue button.
* If you're going to debug on a device, please note that Xcode will have to copy debug symbols for the Swift runtime, iOS runtime, and Pop a Dots, in order to actually debug. This may take upward of 10-20 minutes depending on the device. It took about 13 minutes for a iPhone 6 Plus.
* If you're going to debug on a device with an iOS version lower than 8.1, you'll need to manually change the Deployment Target in Xcode to be equal to your iOS version.

### Who do I talk to? ###

* Josh (of course)

### What's done? ###

* Random circles
* Popping circles
* Main Menu
	* Rainbow Background
	* Buttons with background
* Black Border Circle

### Features coming soon ###

* Classic Mode
* Game Center partial implementation
