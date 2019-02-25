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

Create a new Swift file and name it `TaskController`. This controller will have the sole responsibility of making creating and updating the `Task` model objects in our app. First things first, declare a new class named `TaskController` and then add a shared instance. Finally, add our source of truth, which will be an empty array of `Task` objects. Your code should look something like the following:

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

Let's shift our focus to the UI of the app. Create a new subclass file of UITableViewCell named `SwitchTableViewCell`. Add one variable in the class named  `task` of type `Task`. This will be used as our landing pad. We will revisit the cell later.

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

Go into your `Main.storyboard` file and give an identifier to the segue from your cell to the TaskDetailViewController; it should be something to the effect of "toTaskDetail."

Let's handle when a user taps on an existing task. In your `TaskListTableViewController.swift` file, uncomment the `prepareForSegue` function. Check that the segue's identifier matches the one that you just set in storyboard; if it matches, unwrap the segue's destination view controller and the table view's selected index path. Index the `tasks` array on your `TaskController` and pass the correct `Task` object to your detail view controller. 




