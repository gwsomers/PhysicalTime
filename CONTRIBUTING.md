# PhysicalTime `CONTRIBUTING`

Pull requests & contributing
---
All pull requests of any sort are welcome! Any problems will help with bugs, as well as any potential features to be implemented to the application.

Please have a look at the [GitHub Swift Style Guide](https://github.com/github/swift-style-guide) for more niche topics on Swift styling. For the more general case, simply follow the general formatting and constructs of the current codebase.

All contributions are welcome, simply make a pull request [here](https://github.com/gwsomers/PhysicalTime/issues). :sunny::sunglasses:


Contributor guidelines for developers
---
* Author headers at the beginning of each class file. For example,
```
/*
 * Author: Charlie Sheen
 * Created for Physical Time, 2018
 */
```
* CamelCase variables only (e.g. `int randomFlag = False;`)
* Descriptive variable names **PLEASE**
* One class per file, and no functions left outside of a given class
* Block comments at the beginning of each class, describing its purpose 
* Block comments/docstrings at the beginning of each function. For example,
```
/* The purpose of this function is to blah blah blah...
 * @param num: The number that does this
 * @param name: The name that does that
 * @return variableName, an integer that serves some random purpose...
 */
 func abc(int num, str name)
 {
     [...]
 }
```
* An interface class for each class file where appropriate, to hide the abstraction from other developers on the project. See more [here](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html) and [here](https://stackoverflow.com/questions/24071525/what-is-the-equivalent-for-java-interfaces-or-objective-c-protocols-in-swift) (the equivalent of interfaces in Swift are called "protocols")
* Comment *heavily* (preferrably every three lines)
* Make your code modular
* Unit tests with at least 80% code coverage at any given time!
* Use logging statements instead of print statements for debugging purposes (see this framework as a starting point: https://github.com/SwiftyBeaver/SwiftyBeaver)
* No single method should be longer than a screen's length (simply put, your methods should be short and sweet)
* Convention for naming *all* files: `PhysicalTime[...].swift`. For example, `PhysicalTimeClockCounting.swift`, or `PhysicalTimeDataVizualization.swift`. The name of the actual class should correspond with the name of the file itself.
