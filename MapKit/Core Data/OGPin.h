//
//  OGPin.h
//  MapKit2
//
//  Created by Alexander Ignition on 15.07.14.
//  Copyright (c) 2014 Original Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>


@interface OGPin : NSManagedObject <MKAnnotation>

@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * namePin;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSString * addressPin;
@property (nonatomic, retain) NSNumber * lon;


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

@end
