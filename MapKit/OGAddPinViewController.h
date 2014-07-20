//
//  OGAddPinViewController.h
//  MapKit
//
//  Created by Александр Игнатьев on 19.07.14.
//  Copyright (c) 2014 Original Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OGPin.h"


@interface OGAddPinViewController : UITableViewController

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *subtitleField;
@property (weak, nonatomic) IBOutlet UITextField *latitudeField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeField;

@end
