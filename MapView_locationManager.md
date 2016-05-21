This practice is about the MapView and LocationManager.

1.Let's set up the storyboard and the view is like this!

![image](https://raw.githubusercontent.com/chen-chien-lung/MapView_LocationManager/master/pics/storeboard.png)

2.Click the root folder(HelloMyMap) and click the target(HelloMyMap).
  At the bottom of the "General" section ,you can find the "Linked Frameworks and libraries"
  It is where we have to add the framework for CoreLocation and MapKit.
  CoreLocation: the framework for locating function.
  MapKit : the framework for map function.
  ![image](https://raw.githubusercontent.com/chen-chien-lung/MapView_LocationManager/master/pics/framework.png)
3.Let's talk about the codes

  In "ViewController" ,Don't forget to implement the delegate for mapView and LocationManager -<MKMapViewDelegate,CLLocationManagerDelegate>
  
  In "viewDidLoad" , we have to judge the IOS version whether it support the authorization for users to determine to turn on and off the locating function or not.
 ![image](https://raw.githubusercontent.com/chen-chien-lung/MapView_LocationManager/master/pics/judge1.png)
 then we prepare for the locationManager and start to update the location information.
 
 I know you remember that we implement two IBActions for the two Segmented Controler.
 Let's add some codes that make them work.
 I do the similiar thing in the two IBActions.
 one is to determine mapType and the other is to determine the trackingMode
 
 In "didUpdateLocations",I add a NSLog ,and you can find that the system update the location information about once a second.
 
 The codes Inside the dispatch_once method is to make the view focus on where the coordinate is the will resize the view.
 
 The "dispatch_once" method will run once no matter the didUpdateLocations run how many times.
 
 I also add a regionDidChangeAnimated method that to detect whether users move or zoom in/out the map.
