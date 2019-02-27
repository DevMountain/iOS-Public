# Task 1 Part 1

Students will build a simple task tracking app to practice project planning, progress tracking, MVC separation, intermediate table view features, and Core Data.

Students who complete this project independently are able to:

### Part One - Project Planning, Model Objects and Controllers, Persistence with Core Data

* follow a project planning framework to build a development plan
* follow a project planning framework to prioritize and manage project progress
* identify and build a simple navigation view hierarchy
* create a model object using Core Data
* add staged data to a model object controller
* implement a master-detail interface
* implement the UITableViewDataSource protocol
* implement a static UITableView
* create a custom UITableViewCell
* write a custom delegate protocol
* use a date picker as a custom input view
* wire up view controllers to model object controllers
* add a Core Data stack to a project
* implement basic data persistence with Core Data

### Part Two - NSFetchedResultsController

* use an NSFetchedResultsController to populate a UITableView with information from Core Data
* implement the NSFetchedResultsControllerDelegate to observe changes in Core Data information and update the display accordingly

### Set up
Add the complete and incomplete images to your Assets folder. Images can be found ~~~~~~~~~~~~~~here~~~~~~~~~~~~~

# Part One

1. Add a `UITableViewController` scene to your storyboard. This table view will be used to list tasks.
2. Embed the scene in a `UINavigationController`
3. Add an `Add` system bar button item to the navigation bar
4. Add a class file `TaskListTableViewController.swift` and assign the scene in the Storyboard
5. Add a `UITableViewController` scene that will be used to add and view tasks
    * note: We will use a static table view for our Task Detail view, static table views should be used sparingly, but they can be useful for a table view that will never change, such as a basic form.
6. Add a segue from the Add bar button item from the first scene to the second scene
7. Add a segue from the prototype cell in the first scene to the second scene
8. Add a class file `TaskDetailTableViewController.swift` and assign the scene in the Storyboard
    * note: We will finish building our views later on

### Add a Core Data Stack

You will add a `CoreDataStack` class that will initialize your persistent store, coordinator, and managed object context. Then you will build your Core Data data model.

1. Create a new file called `CoreDataStack.swift`.
2. Import `CoreData` and then add the following code to the file:

```
enum CoreDataStack {

    static let container: NSPersistentContainer = {

        let appName = Bundle.main.object(forInfoDictionaryKey: (kCFBundleNameKey as String)) as! String
        let container = NSPersistentContainer(name: appName)
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    static var context: NSManagedObjectContext { return container.viewContext }
}
```
* note: Be sure you understand what is going on in each line of code in your `CoreDataStack`

### Implement Core Data Model

1. Create a new Data Model template file (File -> New -> File -> Data Model) and be sure to use the app name for the name of the Data Model.
2. Add a New Entity called Task with attributes for name (String), notes (String), due (Date), and isComplete (Bool).
3. Use the Data Model inspector to set notes and due to optional values and give isComplete a default value of false.
4. At this point Xcode will automatically create your CoreDataClass and CoreDataProperties files for you; however, you won't actually see these files in your project file hierarchy.
    * note: Remember that when we create Core Data types they are `NSManagedObject` subclasses. Thus, `Task` is a subclass of `NSManagedObject`.

Now you need to add a convenience initializer for your `Task` objects that matches what would normally be a memberwise initializer. NSManagedObjects have a designated initializer called `init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?)` and a convenience initializer called `init(context moc: NSManagedObjectContext)`. You will write your own convenience initializer that uses the `NSManagedObject` convenience initializer and sets the properties on a `Task` object.

1. Create a new file called `Task+Convenience.swift`.
2. Add an extension to `Task` and create your convenience initializer inside of the extension
    * note: Make sure the initializer has parameters for `name`, `notes`, `due`, and `context` and that each parameter takes in the right type (`context` will be of type `NSManagedObjectContext`).
    * note: Remember that `notes` and `due` are optional, therefore, you can give them default values of `nil`. Also, give `context` a default value of `CoreDataStack.context`.
3. Inside the body of the initializer, call the `NSManagedObject` convenience initializer and pass in `context` from your own convenience initializer --> `self.init(context: context)`. Next, set your `Task` properties (self.name = name... etc.)

Note: Make sure that you import `CoreData`.

```
extension Task {
    
    convenience init(name: String, notes: String? = nil, due: Date? = nil, context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.due = due
    }
}
```
This is the initializer you will use moving forward to create a new instance of a `Task`.

Now that we have implemented the Core Data model, let's build out our model controller.

### Create the Task model controller

Let's create our CRUD functions including saving and loading from Core Data.

Create a new Swift file and name it `TaskController`. This controller will have the sole responsibility of creating and updating the `Task` model objects in our app. First things first, declare a new class named `TaskController` and then add a shared instance. Finally, add our source of truth, which will be an empty array of `Task` objects. Your code should look something like the following:

```
class TaskController {
    
    // Shared instance
    static let shared = TaskController()
    
    // Soure of truth
    var tasks: [Task] = []  
}
```

##### Create
Let's start off by creating our create function. First, import `CoreData` at the top of the file. Now, create a function called `createTaskWith` that takes in the following parameters:

1. A `name` of type `String`
2. An optional `notes` of type `String`
3. An optiopnal `due` of type `Date`

Next, in the body of our function, initialize a new `Task` object by calling the convenience initializer we created earlier. Be sure to wildcard the name of your new instance since we aren't actually going directly use the object.

```
func createTaskWith(name: String, notes: String?, due: Date?) {
    
    // Initialize a new Task object
    let _ = Task(name: name, notes: notes, due: due)
    
    // TODO: - Save the managed object context
}

```

##### Update
Add an `update` function that takes in the following parameters:

1. The `Task` object to be updated
2. A `name` of type `String`
3. An optional `notes` of type `String`
4. An optiopnal `due` of type `Date`

In the body of our function, set the `task's` name, notes, and due to the parameters that were passed into the function.

```
func update(_ task: Task, _ name: String, notes: String?, due: Date?) {
    
    // Set the tasks's properties to the parameters that were passed in
    task.name = name
    task.notes = notes
    task.due = due
    
    // TODO: - Save the managed object context
}
```

##### Delete
Next, we are going to create our delete function. add a `delete` function that takes in a `Task` object. This function will be very simple. In the body of the function, call `delete` and on the `CoreDataStack's` `context`. Pass the `task` into the function.

```
func delete(_ task: Task) {
    
    // Remove the task from the Managed Object Context
    CoreDataStack.managedObjectContext.delete(task)
    
    // TODO: - Save the managed object context
}

``` 

Now that we are done with creating, updating, and deleting model objects, we need to add functionality so that our app acutally saves changes to the `Persistent Store`.

##### Save to the Persistent Store

Think of the Persistent Store as the user's iPhone hard drive. We've made changes to the Managed Object Context, but those changes have not been saved to the persisent store, yet; hence, the `TODO's` that are in our code.

Create a new function called `saveToPersistentStore` that takes in no parameters. In the body of the function. Add a `do-catch` block. Inside of the block, call `save` on your `CoreDataStack.context`. Make sure that you mark your call with `try` and catch/handle any possible errors that are thrown.

```
func saveToPersistentStore() {
    do {
        try CoreDataStack.context.save()
    } catch {
        print("There was an error saving to the persistent store. \(error)")
    }
}
```

Now that we are able to save to the Persistent Store, let's call our `save` function in `createTaskWith()`, `update`, and `delete`. Note that making changes to the managed object context does not actually mean they have been saved to the Persistent Store. Once we call the save functions, the current state of the managed object context is saved.

##### Load from persistent store

We are going to revisit the `TaskController's` source of truth. Instead of having `tasks` equal an empty array, let's turn it into a computed property. Inside the body of the property's definition, create a new constant of type `NSFetchRequest`. Make sure you specify the instance's generic as `Task`. Have your new constant equal a new instance of `NSFetchRequest` and pass in "Task" as the `entityName`. Next, in a `do-catch` block, return the results of calling `fetch` on your `CoreDataStack.context` and pass in the `fetchRequest`. This method returns all of the managed objects that you request in your fetch request in an array. Catch any errors and return an empty array in the `catch`.

```
// Source of truth
var tasks: [Task] {
    
    // Create the fetch request
    let fetchRequest: NSFetchRequest<Task> = NSFetchRequest(entityName: "Task")
    do {
        // Return the results of the fetch request.
       return try CoreDataStack.context.fetch(fetchRequest)
    } catch {
        print("There was an error fetching the Tasks: \(error)")
        return []
    }
}

```

### Wire up storyboard to code

Let's shift our focus to the UI of the app. Create a new subclass file of UITableViewCell named `SwitchTableViewCell`. Add one variable in the class named  `task` of type `Task`. This will be used as our landing pad. We will revisit this cell later.

##### Task List Table View Controller

First, add the table view's data source. In `numberOfRows`, return the count of the `TaskController's` `tasks` array.

In `cellForRowAt`, populate each cell with the appropriate task. First, let's wrap the cell initialization in a `guard` statement, and optionally downcast the cell as a `SwitchTableViewCell`. In your `else` statement, return an instance of `UITableViewCell`. Give the cell a reuse identifier both in code and in your storyboard.
Now, index the source of truth using the `indexPath` passed into the function. Once you have the task for that particular cell, pass it to the cell's landing pad.

```
guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? SwitchTableViewCell  else { return UITableViewCell() }

let task = TaskController.shared.tasks[indexPath.row]
        cell.task = task
        
return cell
```

###### Passing data
Let's handle when a user taps on an existing task. First, go into your `Main.storyboard` file and give an identifier to the segue from your cell to the TaskDetailViewController; it should be something to the effect of "toTaskDetail." Next, in your `TaskListTableViewController.swift` file, uncomment the `prepareForSegue` function.  Check that the segue's identifier matches the one that you just set in storyboard; if it matches, unwrap the segue's destination view controller and the table view's selected index path. Add an optional `Task` landing pad on your `TaskDetailViewController`. Index the `tasks` array on your `TaskController` and pass the correct `Task` object to your detail view controller. 

```
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	
	// Check that we are firing the code for the correct segue
	if segue.identifier == "toTaskDetail" {
	
	    // Cast the destination view controller as our custom detail vc
	    guard let destinationVC = segue.destination as? TaskDetailTableViewController,
	    
	        // Grab the indexPath of the row that was selected
	        let indexPath = tableView.indexPathForSelectedRow
	        else { return }
	    
	    // Index the source of truth
	    let task = TaskController.shared.tasks[indexPath.row]
	    
	    // Pass the task to the detail vc
	    destinationVC.task = task
	}
}
    
```

###### Deleting a task

Uncomment the `tableView(commit editingStyle:)` function. We will use this to delete an existing task. In the `if` statement where editing style is 'delete,' index the shared truth and find the correct task to delete and call the `TaskController's` `delete` function. Pass the task to the `delete` function. Remember, always modify your data source (in this case it's our `tasks` array) before actually calling `tableView.deleteRows` or you will get a crash.

```
override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        
        let task = TaskController.shared.tasks[indexPath.row]
        
        // Delete the row from the data source
        TaskController.shared.delete(task)
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
    
```
##### Task Detail Table View Controller

###### Storyboard

Let's jump back into our storyboard and put the finishing touches on the detail view controller before jumping into code. Complete the following: 

1. Click on the table view in the view hierarchy. 
2. In the Attributes Inspector, increase the sections to three. Each section should only have one row. Give section one a title of 'Name.', section two 'Due', and section three 'Notes.' Because we are using a static table view controller, we can add UI elements straight to our table view cell. 
3. Drag out a `UITextField` for both section one and two, and add a `UITextView` to section three. Constrain each element to be 4 points away from the leading, top, trailing, and bottom edges of the respective cell's content view.
4. Drag a `UIDatePicker` into the view hierarchy under First Responder. We will use this date picker later to set the optional `due` property.
5. Add a navigation item and a Save' `UIBarButtonItem` to the right side of the navigation bar.

###### TaskDetailTableViewController.swift

1. Drag outlets from your storyboard's view controller into your swift file. Make sure you include an outlet for the date picker.
2. Drag out an `IBAction` for your `saveBarButtonItem`.
3. In `viewDidLoad`, assign the `dueTextField's` `inputView` to your date picker.
4. In your `saveButtonTapped` function, safely unwrap the `nameTextField's` text and either a) create a new instance of `Task`, or b) update an existing task. Remember that `due` and `notes` are both optional. Also note that the data for `due` should come from your date picker, not the `dueTextField` itself. Finally, pop the view controller off the navigation stack. This should happen regardless of whether an update or creation is occuring.

```
// Unwrap the name text field and ensure that the string is not empty
    guard let name = nameTextField.text, !name.isEmpty else { return }
    
    // If we are in the detail view for an existing task, unwrap it
    if let task = task {
        
        // Update the task
        TaskController.shared.update(task, name: name, notes: notesTextView.text, due: datePicker.date)
        
    } else {
        
        // Create a new task
        TaskController.shared.createTaskWith(name, notesTextView.text, datePicker.date)
    }
    
    // Pop the detail vc off the navigation stack
    self.navigationController?.popViewController(animated: true)
}
```

We have to complete a couple of steps in order to get our `dateTextField` to show the date picker's date. Complete the following:
 
1. In storyboard, drag out an action from your date picker named `datePickerChanged`. This action will fire any time that your date picker selects a date.
2. In the body of your action, set the `dueTextField's` text to the `datePicker's` date. Hint: use the `sender` that is passed into your action. If the sender isn't already of type `UIDatePicker`, change it now.

##### Switch Table View Cell

We can successfully create and update new tasks; however, we still need to be able to display them in the our table view, and provide the functionality for the tasks to be completed.

In storyboard, navigate to your `TaskListTableViewController`. Add the following:

1. A label for the task's name.
2. A label for the due date.
3. A button for our complete/incomplete image. Make sure you erase the "Button" placeholder text. You can assign one of the images as a placeholder, make sure you add it to the button's background.
4. Constraints to all of the elements. Set up the cell how you'd like.

Assign the table view cell's subclass file in the Identity Inspector. Drag outlets into your `SwitchTableViewCell` subclass file. Drag out an action for the `isComplete` button.

Now that our setup is complete, add logic to your cell.

1. On our `task` landing pad, add a `didSet`.
2. Add a function named `updateViews` that will update each UI element for the task passed to the cell. Call `updateViews` in your `didSet`.

```
public func updateViews() {
    guard let task = task else { return }
    nameLabel.text = task.name
    dueLabel.text = String(describing: task.due)
    let image: UIImage? = task.isComplete ? UIImage(named: "complete") : UIImage(named: "incomplete")
    isCompleteButton.setBackgroundImage(image, for: .normal)
}

```
###### Cell Delegate
When the user taps the `isComplete` button, our table view cell should not be making any changes to the model; i.e. the `isComplete` property should not be changed by the cell. In order to maintain proper separation of concerns, we need to implement a delegate. 

1. Declare a new delegate protocol outside of the class. Name it `SwitchTableViewCellDelegate`. This protocol will only require one function `isCompleteToggled` that will take in a `SwitchTableViewCell`
2. Add a `weak var delegate` of type `SwitchTableViewCellDelegate?`
3. In the `isCompleteButtonTapped` function, call `isCompleteToggled` on your `delegate`.

Switch back to the `TaskListTableViewController` and adopt/conform to the delegate that you just created.

```
extension TaskListTableViewController: SwitchTableViewCellDelegate {
    
    func isCompleteToggled(on cell: SwitchTableViewCell) {
        
    }
}
```
Next, in `cellForRowAt` make sure you are setting yourself as the cell's delegate.

In the body of the `isCompleteToggled`, we need to have the `TaskController` toggle the `isComplete` property on our task. 

In the `TaskController` add a function that takes in a `Task` and toggles its `isComplete` property, then have it save to Core Data.

```
func toggleIsComplete(for task: Task) {
    task.isComplete = !task.isComplete
    saveToPersistentStore()
}
```

In the `TaskListTableViewController` implementation of `isCompleteToggled`, use the cell that is passed into the function to get a reference to the task to be toggled. You will need to unwrap this task. Once you have the task, call the `toggleIsComplete` function that you just created in the `TaskController` and pass it the task. Finally, call `updateViews` on the cell that was passed into the `isCompleteToggled` function. 

```
func isCompleteToggled(on cell: SwitchTableViewCell) {
        guard let task = cell.task else { return }
        TaskController.shared.toggleIsComplete(for: task)
        cell.updateViews()
    }
```

