//
//  SceneTableViewController.m
//  MelbourneTravel
//
//  Created by WangQionghua on 4/04/2014.
//  Copyright (c) 2014 WangQionghua. All rights reserved.
//

#import "SceneTableViewController.h"
@interface SceneTableViewController ()

@end

@implementation SceneTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	[self refreshData];
}
//fetch scene data from model
-(void)parseScenes
{
//#warning:Simplified here. If need to fetch the data from internet or database, then add refreshControl, replace with other data fetch methods and use another quese to not block the main thread
    DataParser *model = [DataParser shareInstance];
    self.scenes = model.scenes;
}
- (IBAction)refreshData {
    [self.refreshControl beginRefreshing];
//Update the data from internet or database here
    DataParser *model = [DataParser shareInstance];
    self.scenes = model.scenes;
    [self.refreshControl endRefreshing];
}


@end
