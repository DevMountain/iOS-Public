<img src="https://s3.amazonaws.com/devmountain/readme-logo.png" width="250" align="right">

# Project Summary

Delegates can be used to solve many different problems. In this project, you will create and implement a custom delegate in order to communicate information from one view controller to another.

Remember that there are six steps to creating and implementing a delegate:    
  
In the child:  
1) Declare/define the delegate protocol outside of the class   
2) Declare an optional, weak property in your class with the type being your custom delegate created in Step 1  
3) Call the your delegate's function(s) at the appropriate time; e.g. when a button is tapped  
  
In the parent:  
4) Adopt the delegate   te
5) Conform to the protocol  
6) Set the adopting class as the delegate     

## Setup

Open the WizardSchool starter project in your iOS-Student folder. Familiarize yourself with the existing code. See summaries below.

### Wizard.swift

This is the model class for your project. You'll notice that this file contains two enums: 1) a wand type and 2) a trait.  

We have a computed property called `houseImage`, which is computed based on the trait that is selected. For example, if you pick 'cunning,' the house symbol for Slytherin will be returned.
   
### WizardController.swift

This is the model controller for our `Wizard` class. It is solely responsible of for creating, updating, reading, and deleting the model. In this project, it will only create new `Wizard` objects.  

### HomeViewController.swift

The subclass file for the `HomeViewController` in the storyboard. Notice in the storyboard that there are hidden UI elements. We will eventually unhide these elements after a new wizard is created.  

### EnrollViewController.swift

The subclass file for the `EnrollViewController`. This is where a person will sign up to become a wizard. 

In the `wandButtonTapped` function, we are switching on the `UIButton's` `restorationIdentifier`. A `restorationIdentifier` is just what it sounds like, it provides a way to identify a UI element in our code. We use the `restorationIdentifier` to identify which button was tapped, then set the `selectedWand` property on our view controller class so that we can later use that variable in another scope. 
   
A similar pattern occurs in the `traitButtonTapped`. We switch on the `restorationIdentifier` to find out which trait button was tapped, and we set the `selectedTrait`accordingly.

Both buttons call `inverseColor(for:)` which simply swaps the button's background/font colors to show that the button is selected.

The `formatButtons(:)` function loops through the `buttons` collection outlet, which is an array outlets for our buttons in storyboard. In the loop, the corners of the button are rounded and a border width/color is set.

## Step 1 - Declare/define the delegate protocol

### Summary

We will declare and define our delegate in this section. The `EnrollViewController` is considered the child in the parent-child relationship of the delegate. Think about how a child would report to a parent in real life. The `EnrollViewController` will be reporting to the `HomeViewController`.

### Instructions

* Open the `EnrollViewController.swift` file
* Declare and define your delegate protocol. At the top of the file and outside of the class, add the following:
	<details>
      <summary> <code> Delegate protocol declaration</code> </summary>

      ```swift
      protocol EnrollViewControllerDelegate: class  {
      		func wizardCreated(wizard: Wizard)
      }
      ``` 
   </details>
      
Let's consider the 'why' behind the code above. When the user taps on the 'Sign up' button on the `HomeViewController`, we present the `EnrollViewController`. Once the user signs up, we need a way to communicate our new `Wizard` object back to the `HomeViewController`
so that it can populate its views; otherwise, the `HomeViewController` would have no way to access the newly created `Wizard`. Although there are a few different ways to provide access to the `Wizard` object in this scenario, a delegate method works perfectly.

## Step 2 - Declare a delegate property

### Summary

We've declared a delegate protocol at this point; however, we haven't provided a way for another class to set itself as the `EnrollViewController's` delegate. So, let's declare a delegate reference. This will allow another class to set itself as the child's boss (aka the parent).  

### Instructions
* In the `EnrollViewController` class, do the following:
	<details>
		<summary> <code> Declare a delegate property</code></summary>
		```
		weak var delegate: EnrollViewControllerDelegate?
		```
		</details>

## Step 3 - Call your delegate's function

### Summary
The last action that we need to take is to create a `Wizard` object from the user's input and to call our delegate function.  

### Instructions
* Enter the following in the `saveButtonTapped(sender:)` function:
	* Unwrap the input from the user (the text field, selectedTrait, and selectedWand)
	* Initialize a new `Wizard` object using the objects that you unwrapped
	* Inform your delegate of the wizard creation by calling `wizardCreated(wizard:)` on `delegate`
	* Dismiss the `EnrollViewController`
	
	<details>
		<summary> <code> Call your delegate's function</code></summary>
		
		 // Unwrap the input from the user.
        guard let wizardName = wizardNameTextField.text, 
        	  !wizardName.isEmpty,
            let trait = selectedTrait,
            let wand = selectedWand
            else { return }
        
        // Initialize a new Wizard
        let wizard = WizardController.enroll(name: wizardName, wand: wand, trait: trait)
        
        // Call our delegate function to inform the parent that a wizard was created
        delegate?.wizardCreated(wizard: wizard)
        dismiss(animated: true, completion: nil)
        
Informing the parent that a `Wizard` object was created gives the parent an opportunity to react. In our case, we want the `HomeViewController` to update its views to reflect the properties of the wizard.

## Step 4 - Adopt the delegate protocol

### Summary

Now that the child portion of delegate protocol has been implemented, we're ready to utilize it in our parent class.  

### Instructions

* Open the `HomeViewController.swift` file
* Adopt the delegate protocol by adding the following code outside of the `HomeViewController` class:
	<details>
		<summary> <code> Adopt the delegate protocol</code></summary>
		
	```  
	extension HomeViewController: EnrollViewControllerDelegate {
		
	}
	```
	</details>
	
Note: Good code organization is very important. Adopting and conforming to delegates in an extension of the conforming class is a best practice.   

Notice that you are receiving an error from the compiler telling you that the `HomeViewController` does not conform to the `EnrollViewControllerDelegate` protocol. What's happening here is that the we have declared our `HomeViewController` as an `EnrollViewControllerDelegate`; however, in order to actually be an `EnrollViewControllerDelegate`, the adopting class must conform to the delegate. 

See Step 5 to silence the compiler.

## Step 5 - Conform to the delegate protocol

### Summary

In general, conforming to a delegate protocol means implementing any required functions or adding any required properties. Our delegate has one required function that must be implemented in order for a class to conform to our delegate protocol.

### Instructions

* Click the error and the click 'Fix.' This will add the stubs for the required function. We have now successfully conformed to the delegate protocol; however, we have more to do 
* Let's think back to our child. This method is going to get fired when the user taps the 'Save' button on the `EnrollViewController`. This is, in essence, the `EnrollViewController` reporting to the `HomeViewController`. Once the `HomeViewController` has been informed that a new wizard has been created, we need to actually update the views in the `HomeViewController`.
	* In the `wizardCreationed(wizard:)` function, call the existing `updateViews(for:)` function, and pass in the `Wizard` object that was passed into the delegate function.
	* `updateViews` should do the following:
		* Set the `welcomeLabel` text to "Welcome WizardName!"
		* Set the `yourWandLabel` text to "Your wand is WandName" Note: you will have to use the rawValue of the wand enum.
		* Set the `houseImageView` image to your wizard instance's `houseImage` property.
		* Unhide the 	`yourWandLabel`, `yourHouseLabel`, and the`houseImageView`.
		* Hide the `enrollButton`.


## Step 6 - Set the adopting class as the delegate  

### Summary

The final step in implementing the delegate is by setting the `HomeViewController` as the delegate of the `EnrollViewController`. Remember the `weak var delegate` we created on the `EnrollViewController`? We're going to use that now.

### Instructions

* First, we need an instance of the `EnrollViewController` in order to set its delegate, so we're going to have to start in `prepareForSegue(segue:sender:)`.
* In the extension (not the extension that adopted the delegate) on `HomeViewController`, start typing 'prepare.' This should autopopulate the `prepareForSegue(segue:sender)` function
* Set a segue identifier in `Main.storyboard`. In `prepareForSegue, ` check the segue's identifier.
* Unwrap the segue's destination and cast it as an `EnrollViewController`
* Set the instance's delegate to `self`.


## Black Diamond



## Contributions

If you see a problem or a typo, please fork, make the necessary changes, and create a pull request so we can review your changes and merge them into the master repo and branch.

## Copyright

© DevMountain LLC, 2017. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.

<p align="center">
<img src="https://s3.amazonaws.com/devmountain/readme-logo.png" width="250">
</p>
