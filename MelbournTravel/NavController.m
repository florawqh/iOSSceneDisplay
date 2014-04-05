//
//  NavController.m
//  MelbournTravel
//
//  Created by WangQionghua on 5/04/2014.
//  Copyright (c) 2014 WangQionghua. All rights reserved.
//

#import "NavController.h"
#import "SceneDetailViewController.h"

@implementation NavController

//- (BOOL)shouldAutorotate
//{
//    id currentViewController = self.topViewController;
//    
//    if ([currentViewController isKindOfClass:[SceneDetailViewController class]])
//        return NO;
//    
//    return YES;
//}
- (BOOL)shouldAutorotate {
    if (self.topViewController != nil)
        return [self.topViewController shouldAutorotate];
    else
        return [super shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations {
    if (self.topViewController != nil)
        return [self.topViewController supportedInterfaceOrientations];
    else
        return [super supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    if (self.topViewController != nil)
        return [self.topViewController preferredInterfaceOrientationForPresentation];
    else
        return [super preferredInterfaceOrientationForPresentation];
}

@end



