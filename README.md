# San Diego Zoo Sample iOS App  
  
This app displays a sample format for an app to use at the San Diego Zoo. It includes a tab bar controller with home, map, and search tabs.  
  
## Install and use  
  
In order to use this, first clone or download the repository. You'll then have to create a Podfile and add this line for the Cocoapod [DropDown](https://github.com/AssistoLab/DropDown):
  
```
pod 'DropDown'
```

After saving your podfile, install the pod using this line in terminal:

```
pod install
```

## Features

This sample includes the following features:

**Map Tab**

* MKMapView with location tracking
* Custom UIGestureRecognizer to prevent user from zooming in or out too much
* Method to adjust mapView region if user tries to move outside zoo bounds
* MKOverlay rendering (tiles, MKPolylines, custom MKAnnotationViews for each type of zoo object)
* UIPickerView to filter map points by area
* DropDown table to filter map points by type

**Home Tab**

* Custom Experience class and subclasses separated by headers in tableView
* Browser url link for ticket purchase
* App-specific social media url links for Facebook, Instagram, Twitter, and Youtube

**Search Tab**

* UIPickerView to filter search results by area
* UICollectionView to filter search results by type
* UISearchController to filter tableView data by search text

**Misc**

* Custom UITabBarController with button to navigate to detached MapViewController to prevent memory allocation buildup with MKMapView object
* UITableViewCell subclass with Programmatic UI 
* ObjectDetailViewController with Programmatic UI
