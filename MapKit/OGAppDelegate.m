//
//  OGAppDelegate.m
//  MapKit
//
//  Created by Alexander Ignition on 15.07.14.
//  Copyright (c) 2014 Original Group. All rights reserved.
//

#import "OGAppDelegate.h"
#import "OGMapViewController.h"
#import "OGCoreData.h"
#import "OGPin.h"


@implementation OGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    //OGMapViewController *controller = (OGMapViewController *)navigationController.topViewController;
    
//    [self insertPin:@"1"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [[OGCoreData defaultStore] saveContext];
}


- (void)insertPin:(NSString *)pin
{
    NSManagedObjectContext *context = [OGCoreData defaultStore].managedObjectContext;
    OGPin *newPin = [NSEntityDescription insertNewObjectForEntityForName:@"OGPin"
                                                  inManagedObjectContext:context];
    newPin.timeStamp  = [NSDate date];
    newPin.namePin    = [NSString stringWithFormat:@"name = %@", pin];
    newPin.addressPin = [NSString stringWithFormat:@"address = %@", pin];
    newPin.lat        = @37.315581;
    newPin.lon        = @-122.010394;
    
    [[OGCoreData defaultStore] saveContext];
}

// 37.315581,-122.010394

@end
