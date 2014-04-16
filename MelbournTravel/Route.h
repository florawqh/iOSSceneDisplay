//
//  Route.h
//  MelbourneTravel
//
//  Created by WangQionghua on 16/04/2014.
//  Copyright (c) 2014 WangQionghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Scene;

@interface Route : NSManagedObject

@property (nonatomic, retain) NSDate * sceneList;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) NSSet *scenes;
@end

@interface Route (CoreDataGeneratedAccessors)

- (void)addScenesObject:(Scene *)value;
- (void)removeScenesObject:(Scene *)value;
- (void)addScenes:(NSSet *)values;
- (void)removeScenes:(NSSet *)values;

@end
