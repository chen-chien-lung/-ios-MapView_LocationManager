This practice is about the MapView and LocationManager.

1.Let's set up the storyboard and the view is like this!

![image](https://raw.githubusercontent.com/chen-chien-lung/MapView_LocationManager/master/pics/storeboard.png)

2.Click the root folder(HelloMyMap) and click the target(HelloMyMap).
  At the bottom of the "General" section ,you can find the "Linked Frameworks and libraries"
  It is where we have to add the framework for CoreLocation and MapKit.
  CoreLocation: the framework for locating function.
  MapKit : the framework for map function.
  
3.Let's talk about the codes

  In "ViewController" ,Don't forget to implement the delegate for mapView and LocationManager -<MKMapViewDelegate,CLLocationManagerDelegate>
  
  In "viewDidLoad" , we have to judge the IOS version whether it support the authorization for users to determine to turn on and off the locating function or not.
 
 then we prepare for the locationManager and start to update the location information.
 
 I know you remember that we implement two IBActions for the two Segmented Controler.
 Let's add some codes that make them work.
 I do the similiar thing in the two IBActions.
 one is to determine mapType and the other is to determine the trackingMode
