//
//  DataParser.h
//  MelbourneTravel
//
//  Created by WangQionghua on 4/04/2014.
//  Copyright (c) 2014 WangQionghua. All rights reserved.
//
//https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-prn1/t1.0-9/p417x417/534099_10152076227342054_812945626_n.jpg
#import <Foundation/Foundation.h>

// key (paths) to attractions/scenes in a data dictionary
#define SIMPLE_SCENE_LIST @"Scene list"

// keys to values in a scene dictionary
#define SCENE_ID @"id"
#define SCENE_TITLE @"name"
#define SCENE_DESCRIPTION @"brief"
#define SCENE_TAG @"tag"
#define SCENE_LINK @"360link" // Storaged some sample photos on Flickr
#define SCENE_OPEN_HOUR @"open_hour"
#define SCENE_TICKET @"ticket"
#define SCENE_PHONE @"phone"
//The data Source for initialization.
//Define Data Source type--1.from internet:DS_NETWORK or 2.from local json file:DS_LOCAL_FILE

enum {
    DS_LOCAL_FILE  = 1,
    DS_NETWORK     = 2,
    DS_AUTO        = 3
};
typedef NSUInteger AppInitDataSource;

#define APP_INIT_DATASOURCE   DS_LOCAL_FILE

@interface DataParser : NSObject

@property (strong, nonatomic) NSArray *scenes;
//create only a single instance
+(id)shareInstance;

@end
