//  MelbournTravel
//
//  Created by WangQionghua on 5/04/2014.
//  Copyright (c) 2014 WangQionghua. All rights reserved.
//
This APP can:
1.Read Json file and parse Json data.
2.Display a list of tourism attractions or scenes in a table view.
3.Display detailed information about one attraction (or scene).
4.Download and display an image from internet.
5.Edit the information by selecting words and click "Mark" botton.
6.The font in textView will automaticlly change while the defaul font setting is changed by user.
7.Adjust device orientation setting which allowed tableView to rotate and SceneDetailView maintain portrait.

Knowledge and Classes that used in this project:
1.Storyboard: autolayout(restrains),segue
2.Multi-thread(while downloading image from internet)
3.Subclass, override(Subclassed UINavigationController and MelTravelTableViewController)
4.Rotation and orientation setting
5.Singleton (DataParser's class method: shareInstance
6.Notification Center
5.Json Parser
4.NSAttributedString, UITextView, etc.

Files in the project:
1.NavController.h & m:
    Subclass of UINavigationController, override methods: -shouldAutorotate, -supportedInterfaceOrientations and -preferredInterfaceOrientationForPresentation.
    It will be called while the device rotates.
2.MelScene.json:
    Data structure is defined from previous projects, but simplified it to "Scene" which is the bottom list level in previous projects (Which also have "Route", "City", etc. ). Replaced some data for test purpose and image links from server are replaced by my temporary facebook photos links.
3.DataParser.h & m:
    Defined the data structure and analysis the data from local Json file.
4.MelTravelTableViewController.h & m:
    UITableViewController. Displays a list of scenes. While click a cell, it will segue to SceneDetailView.
5.SceneTableViewController.h & m
    Subclass of MelTravelTableViewController. Implemented method to parse and set data for the scene list tableview.
6.SceneDetailViewController.h & m
    Contains UIImageView, UITextView and UIActivityIndicatorView. Uses restrains for each subview so it can autolayout for 3.5-inch and 4-inch screen. The orientation of this view is restrained to portrait so that image and text can both be shown on one page.
    Uses AttributedString and UITextView to display "Scene" information (a new method that different from previouse projects which use tableView).
    Allows user to highlight some selected text for further use. if not select any text then highlight the whole area. and if the selected text is already highlighted then recover it to normal setting.


This is an about two day project. Learned some new way to control the rotation setting for each ViewController.
