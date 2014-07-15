//
//  OGCoreData.h
//  MapKit2
//
//  Created by Alexander Ignition on 15.07.14.
//  Copyright (c) 2014 Original Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OGCoreData : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (OGCoreData *)defaultStore;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
