//
//  OGMapViewController.h
//  MapKit2
//
//  Created by Alexander Ignition on 15.07.14.
//  Copyright (c) 2014 Original Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface OGMapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)addAction:(UIBarButtonItem *)sender;

@end
