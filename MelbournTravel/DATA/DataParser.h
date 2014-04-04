//
//  DataParser.h
//  MelbournTravel
//
//  Created by WangQionghua on 4/04/2014.
//  Copyright (c) 2014 WangQionghua. All rights reserved.
//

#import <Foundation/Foundation.h>

// key (paths) to attractions at scene list
#define SIMPLE_SCENE_LIST @"Scene list"

// keys (paths) to values in a scene dictionary
#define SCENE_ID @"id"
#define SCENE_TITLE @"name"
#define SCENE_DESCRIPTION @"brief"
#define SCENE_TAG @"tag"
#define SCENE_LINK @"360link" // Storaged some sample photos on Flickr

//Define Data Source type--from internet:DS_NETWORK or from local json file:DS_LOCAL_FILE
// The data Source of the app for initialization.
enum {
    DS_LOCAL_FILE  = 1,
    DS_NETWORK     = 2,
    DS_AUTO        = 3
};
typedef NSUInteger AppInitDataSource;
//#define APP_INIT_DATASOURCE   DS_NETWORK
#define APP_INIT_DATASOURCE   DS_LOCAL_FILE

@interface DataParser : NSObject

@property (strong, nonatomic) NSArray *scenes;
//Just need to parse the data one time
+(id)shareInstance;

@end
