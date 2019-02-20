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
