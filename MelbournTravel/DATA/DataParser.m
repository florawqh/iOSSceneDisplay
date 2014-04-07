//
//  DataParser.m
//  MelbourneTravel
//
//  Created by WangQionghua on 4/04/2014.
//  Copyright (c) 2014 WangQionghua. All rights reserved.
//  This Class is used to process Data source from json file.

#import "DataParser.h"
//A static variable guarantees there is only one instance for this class
static DataParser *model;

@implementation DataParser

//create a new instance if there isn't one yet, otherwise return the existing instance
+(id)shareInstance
{
    @synchronized([DataParser class])
    {
        if (!model) {
            model = [[DataParser alloc] init];
            [model initData];
        }
        return model;
    }
    return nil;
}
#pragma mark - Data initialization.
-(void) initData
{
    [self initAllDestinationData:APP_INIT_DATASOURCE];
}
-(void) initAllDestinationDataAsync:(AppInitDataSource)source
{
    
    if ((source == DS_LOCAL_FILE) || (source == DS_AUTO))
    {
        NSError *error = nil;
        NSString *textFileContents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MelScene" ofType:@"json"] encoding:NSUTF8StringEncoding error:&error];
        dispatch_queue_t parseQ= dispatch_queue_create("data parser", NULL);
        dispatch_async(parseQ, ^{
            
            NSData *jsonData = [textFileContents dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *fileDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:NULL];
            if (!fileDict)
            {
                NSLog(@"JSON parser failed");
                return;
            }
            // Data file dictionary (top-level)
            if (![fileDict isKindOfClass:[NSDictionary class]]) {
                NSLog(@"JSON parser hasn't returned a NSDictionary.");
                return;
            }
            NSArray *scenes = [fileDict valueForKeyPath:SIMPLE_SCENE_LIST];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.scenes = scenes;
            });
        });
    }
}
-(void) initAllDestinationData:(AppInitDataSource)source
{
    NSError *error;
    if ((source == DS_LOCAL_FILE) || (source == DS_AUTO))
    {
        NSString *textFileContents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MelScene" ofType:@"json"] encoding:NSUTF8StringEncoding error:&error];
        NSData *jsonData = [textFileContents dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *fileDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        if (!fileDict) {
            NSLog(@"JSON parser failed");
            return;
        }
        // Data file dictionary (top-level)
        if (![fileDict isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON parser hasn't returned a NSDictionary.");
            return;
        }
        NSArray *scenes = [fileDict valueForKeyPath:SIMPLE_SCENE_LIST];
        self.scenes = scenes;
        
    }
}

@end
