//
//  DataParser.m
//  MelbournTravel
//
//  Created by WangQionghua on 4/04/2014.
//  Copyright (c) 2014 WangQionghua. All rights reserved.
//  This Class is used to process Data source from json file.

#import "DataParser.h"
//Sington instance
static DataParser *model=nil;

@implementation DataParser

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
