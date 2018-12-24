# FancyCar

Sample features:

![Output sample](https://github.com/Venkata-Maniteja/FancyCar/blob/master/FancyCar/Resources/Fancy_infinite_scroll.gif)



Documentation:

This app used MVC pattern.

OnBoarding:
1. The app has a splash screen.
2.  After the splash screen , it performs the animation for 2 seconds and loss the main screen
3.  Download cars button is visible for the first time as there is no content.
4.  Click on the Download button
5.  App shows spinner of rotating wheel
6.  After the data is retrieved from  stored JSON, list view is shown.


Infinite Scrolling:
- [x] The list is infinite scrollable. Every time user reaches the end of the list, app makes the next request to download new JSON and reloads the list. 


Sort feature:
- [x] App has 4 sort options . Sort by : Name,  when this is selected, all the data is sorted based on the name key
- [x] When sort by is “In Dealership”, app shows only the results that has the available value as “In Dealership” , Remaining values are filtered out
- [x] Remove sorting, removes the sorting key, and populates the list  in  the order JSON data is processed.

UI for list :
- [x] When car available status is “In Dealership”, the green_checkmark icon is displayed.
- [x] For all other available options , not_available icon (red color) is displayed.
- [x] Shopping cart icon is displayed to show BUY option is available for that particular car.


Reachability:
- [x] Reachability is included to let user know about the network status.


Realm Database:
- [x] Realm db is used to store the cars data, so that app can be used offline. 
- [x] The download button will be disappeared after initial download. The app will directly show the list of cars data from second time.


Swift Codable:
- [x] App uses swift Codable to decode JSON response and to save the car model into the db.

Swift Equatable:
- [x] App uses swift Equatable to compare two car models . This could be useful during unit testing.


Delegates/Protocols :
- [x] UITableViewDelegate - Responsible for table delegate actions
- [x] UITableviewDatasource - Responsible to fill table data
- [x] SettingsDelegate - Responsible for User sort selection 
- [x] CarDelegate - Responsible to let user know about cars


API calls:
- [x] App uses two different JSON files. As the API info is not provided, app uses tow default JSON files to get the cars data. 
- [x] cars.json has the data for cars
- [x] available.json has the data related to car availability  

3rd party libraries:
- [x] Reachability
- [x] Realm DB


Unit Test:
- [x] App has a simple unit test case to test the green cars

