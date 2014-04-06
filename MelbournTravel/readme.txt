//  MelbournTravel
//
//  Created by WangQionghua on 5/04/2014.
//  Copyright (c) 2014 WangQionghua. All rights reserved.
//

MelbournTravel is a travel application demo based a China travel application that I developed for a previous project.

This application can:
1.Read Json files and parse Json data.
2.Display a list of tourist attractions in a table view.
3.Display detailed information about one attraction.
4.Download and display an image from the internet.
5.Edit the information by selecting words and clicking the "Mark" botton.
6.The font in textView will automaticlly change while the default font setting is changed by user.
7.Adjust device orientation setting which allowed table view to rotate and SceneDetailView maintain portrait.

Knowledge and Classes used in this project:
1.Storyboard: autolayout (constraints), segue
2.Multi-thread (while downloading images from internet)
3.Subclass, override, category (subclassed UINavigationController and MelTravelTableViewController)
4.Rotation and orientation setting
5.Singleton (DataParser's class method: shareInstance)
6.Notification Center
7.Json Deserialisation
8.NSAttributedString, UITextView, UIImageView, UITableView, etc.

Files in the project:
1.NavController.h & m:
    Subclass of UINavigationController, override methods: -shouldAutorotate, -supportedInterfaceOrientations and -preferredInterfaceOrientationForPresentation.
    It will be called when the device rotates.
2.MelScene.json:
    Data structure is defined from previous projects, but simplified it to "Scene", which was the bottom list level in previous projects (Which also have "Route", "City", etc. ). Replaced some data for test purposes, and image links from the server are replaced by my temporary facebook image links.
3.DataParser.h & m:
    Defined the data structure and deserialises the data from a local Json file.
4.MelTravelTableViewController.h & m:
    UITableViewController. Displays a list of scenes. When a cell is clicked, it will segue to SceneDetailView.
5.SceneTableViewController.h & m
    Subclass of MelTravelTableViewController. Implemented a method to parse and set data for the SceneListTableView.
6.SceneDetailViewController.h & m
    Contains UIImageView, UITextView and UIActivityIndicatorView. Uses constraints for each subview so it can autolayout for 3.5-inch and 4-inch screens. The orientation of this view is constrained to portrait so that the image and text can both be shown on one page.
    Uses AttributedString and UITextView to display "Scene" information (a new method that is different from previouse projects which use table view).
    Allows users to highlight some selected text for possible further uses. If no text is selected then it highlights the whole area. If the selected text is already highlighted then it will return to the non-highlighted state.


This was a two day project. Learned new ways to control the rotation setting for each ViewController.
