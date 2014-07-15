//
//  OGPin.m
//  MapKit2
//
//  Created by Alexander Ignition on 15.07.14.
//  Copyright (c) 2014 Original Group. All rights reserved.
//

#import "OGPin.h"


@implementation OGPin

@dynamic timeStamp;
@dynamic namePin;
@dynamic lat;
@dynamic addressPin;
@dynamic lon;


- (NSString *)title
{
    return self.namePin;
}
- (NSString *)subtitle
{
    return self.addressPin;
}
- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coord;
    coord.latitude = [self.lat doubleValue];
    coord.longitude = [self.lon doubleValue];
    return coord;
}

@end
