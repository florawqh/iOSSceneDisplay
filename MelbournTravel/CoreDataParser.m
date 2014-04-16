//
//  CoreDataParser.m
//  MelbourneTravel
//
//  Created by WangQionghua on 15/04/2014.
//  Copyright (c) 2014 WangQionghua. All rights reserved.
//

#import "CoreDataParser.h"

@implementation CoreDataParser
-(void)readFile
{
    NSString *documentName = @"sceneList";
    NSURL *url = [self generateDefautlURLforFile:documentName];
    UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:url];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[url path]];
    if(fileExists)
    {
        //open file
        [document openWithCompletionHandler:^(BOOL success){
            if(!success) NSLog(@"couldn't open document at %@",url);
            else
                [self documentIsReady:document];
        }];
    }
    else
    {
        //create file
        [document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (!success) NSLog(@"couldn't create document at %@",url);
            else
                [self documentIsReady:document];
        }];
    }
}
-(void)documentIsReady:(UIManagedDocument *)document
{
    if(document.documentState == UIDocumentStateNormal)
    {
        //NSManagedObjectContext *context = document.managedObjectContext;
      //  NSManagedObject *scene = [NSEntityDescription insertNewObjectForEntityForName:@"Scene" inManagedObjectContext:context];
        //scene.title=@"test";
        
    }
}
/*//Fetch context from document
-(void)documentFetch:(UIManagedDocument *)document
{
    NSSortDescriptor *sortDescriptorTitle = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedStandardCompare:)];
    NSSortDescriptor *sortDescriptorDetail = [NSSortDescriptor sortDescriptorWithKey:@"detail" ascending:YES selector:@selector(localizedStandardCompare:)];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Route"];
    request.fetchBatchSize = 20;
    request.fetchLimit=100;
    request.sortDescriptors = @[sortDescriptorTitle,sortDescriptorDetail];//define the sort method
    NSString *routeName = @"test";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains %@",routeName];
    //@"uniqueID = %@", [dic objectForKey:@"id"]
    //@"title contains[c] %@", routeName //matches title case insensitively
    //@"whichRoute.title = %@", routeName //get the scenes by the route name
    //@"any scenes.title contains %@", routeName //route search
    //@"scenes.@count >5" //key value coding e.g. valueForKeyPath:@"scenes.scene.@avg.latitude"]
   // NSArray *array = @[predicate1,predicate2];
   // NSPredicate *predicate3 = [NSCompoundPredicate andPredicateWithSubpredicates:array];
    
    request.predicate =predicate;
   // NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-24*60*60];
    
    //NSExpression
    [request setResultType:NSDictionaryResultType];//return array of dicts instead of NSMO
    //[request setPropertiesToFetch:@[@"title", expression, ]];
    
    NSManagedObjectContext *context = document.managedObjectContext;
    NSError *error;
    NSArray *routes = [context executeFetchRequest:request error:&error];
    
}
 */
-(void)closeDocument:(UIManagedDocument *)document
{
    [document closeWithCompletionHandler:^(BOOL success) {
        if(!success) NSLog(@"failed to close document %@",document.localizedName);
    }];
}
//generate default url for document
-(NSURL *)generateDefautlURLforFile:(NSString *)documentName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentationDirectory inDomains:NSUserDomainMask] firstObject];
    NSURL *url = [documentsDirectory URLByAppendingPathComponent:documentName];
    return url;
}

@end
