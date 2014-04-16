//
//  Scene.h
//  MelbourneTravel
//
//  Created by WangQionghua on 16/04/2014.
//  Copyright (c) 2014 WangQionghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Route;

@interface Scene : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) NSString * imagelink;
@property (nonatomic, retain) NSString * openhour;
@property (nonatomic, retain) NSString * ticket;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * traffic;
@property (nonatomic, retain) Route *whichRoute;

@end
