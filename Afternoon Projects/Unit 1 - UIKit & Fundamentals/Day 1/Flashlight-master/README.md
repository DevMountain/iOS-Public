# FlashLight
---
Students will build a simple Flashlight app to practice working with IBOutlets, IBActions, and UIControlEvents.
Students who complete this project independently are able to:
* Use, understand, and describe different UIControls available in Cocoa Touch
* Use, understand, and describe UIControlEvents
* Create and use IBOutlets to get access to Storyboard elements in code
* Create and use IBActions to run code on a UIControlEvent
* Work  through the logic required for a flashlights functions


## Guide
---
### Storyboard Setup

Build the initial view a user will see. This view will have two states that we will control programmatically. The first state has a black background and an ‘Turn On’ button with white text. When the user taps ‘Turn On’ change the background to white, update the button’s title to ‘Turn Off’, and change the button text color to black. The button should toggle the two states.

### FlashlightViewController

1. Delete the initial ViewController.Swift file
2. Create a new Cocoa Touch Class File named `FlashlightViewController` and subclassed as a `UIViewController`
3. Subclass the curated ViewController on your Main.storyboard to a `FlashlightViewControler`
4. Change the background color of the view to Black
5. Build and Run your app and check for bugs. The app should display a black screen.
6. Navigate to the `Object Library` and drag out a `UIButton`
7. Control-Drag from the Button to your view. With your shift key held - select Center Horizontally in Container and Center Vertically in Container.
8. Tap the Add Constraints icon ( Tie Fighter) and set the `Width` to 200 and `Height`to 100
9. Navigate to the Attributes inspector and set your font size to `System 30`
10. Set your default title to `Turn On`
11. Set your text color to `White Color`
12. Build and Run your app and check for bugs. The app should display a black screen, with a button displaying `Turn On` in white text
  
### Outlets / Actions

1. Navigate to your Main.storyboard file and select your Flashlight ViewController 
2. Click on your assistant editor. It looks like two rings that slightly intersect.
   Alternatively you could Option + Click on your FlashlightViewController.swift file to open that file in your assistant editor.
3. Create an `Outlet` for your button by control-dragging from your `Button` to the `FlashlightViewControler.swift` file that your Assistant editor opened. Name your button `flashlightToggleButton`
** Remember: Outlets should be placed above your `ViewDidLoad`

5. Create a variable called `isOn` of type `Bool` that you will use to track the buttons state. Set the default value to `false`
6. Create an `Action` for your button by control-dragging from your `Button` to the `FlashlightViewControler.swift` file that your Assistant editor opened. Name your action `flashlightToggleButtonTapped`

** Remember: Actions should be placed beneath your `ViewDidLoad`

8. Use the  `flashlightToggleButtonTapped` IBAction to check the current state of the ViewController and toggle the appropriate parameters
* ex. If isOn is false, set background color, button title text, and button title color


## Black Diamonds
• Make the Status Bar visible in both Flashlight modes Documentation:  [https://developer.apple.com/documentation/uikit/uistatusbarstyle?language=objc](https://developer.apple.com/documentation/uikit/uistatusbarstyle?language=objc) 
* Toggle the device’s LED light when turning the Flashlight on Documentation:  [https://developer.apple.com/documentation/avfoundation/avcapturedevice?language=objc](https://developer.apple.com/documentation/avfoundation/avcapturedevice?language=objc)  * See Managing Torch Settings*
* Allow the Flashlight to toggle on and off using a swipe gesture anywhere on the screen. Documentation:  [https://developer.apple.com/documentation/uikit/uiswipegesturerecognizer?language=objc](https://developer.apple.com/documentation/uikit/uiswipegesturerecognizer?language=objc) 
# Contributions
• Please refer to CONTRIBUTING.md.
# Copyright© 
• DevMountain LLC, 2019. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.


