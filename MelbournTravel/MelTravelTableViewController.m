//
//  MelTravelTableViewController.m
//  MelbournTravel
//
//  Created by WangQionghua on 4/04/2014.
//  Copyright (c) 2014 WangQionghua. All rights reserved.
//

#import "MelTravelTableViewController.h"
#import "SceneDetailViewController.h"
#import <objc/message.h>
@interface MelTravelTableViewController ()

@end

@implementation MelTravelTableViewController
#pragma mark - Properties
- (void)setScene:(NSArray *)scenes
{
    _scenes = scenes;
    [self.tableView reloadData];
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.scenes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Scene Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *scene=self.scenes[indexPath.row];
    cell.textLabel.text = [scene valueForKey:SCENE_TITLE];
    cell.detailTextLabel.text = [scene valueForKey:SCENE_TAG];
    return cell;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([sender isKindOfClass:[UITableViewCell class]])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if(indexPath)
        {
            if([segue.identifier isEqualToString:@"Scene Cell Segue"])
            {
                if([segue.destinationViewController isKindOfClass:[SceneDetailViewController class]])
                {
                    if(UIDeviceOrientationIsLandscape(self.interfaceOrientation)){
                        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
                        {
                            objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortrait ); //if the table view is landscape, then set the device to portrait because SceneDetailView just support portrait. need to call a runtime library
                        }
                    }
                    [self prepareSceneDetailVC:segue.destinationViewController toScene:self.scenes[indexPath.row]];
                }
            }
        }
    }
    
}
//set data for the SceneDetailViewController
-(void)prepareSceneDetailVC:(SceneDetailViewController *)sdvc toScene:(NSDictionary *)scene
{
    sdvc.scene=scene;
    sdvc.title=[scene valueForKey:SCENE_TITLE];
}



@end
