//
//  OGAddPinViewController.m
//  MapKit
//
//  Created by Александр Игнатьев on 19.07.14.
//  Copyright (c) 2014 Original Group. All rights reserved.
//

#import "OGAddPinViewController.h"


@interface OGAddPinViewController ()

@end


@implementation OGAddPinViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.navigationItem.title = @"New Pin";
    
    UIBarButtonItem *itemSave = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                target:self
                                                                                action:@selector(actionSave:)];
    [self.navigationItem setRightBarButtonItem:itemSave animated:NO];
    
    UIBarButtonItem *itemCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(actionCancel:)];
    [self.navigationItem setLeftBarButtonItem:itemCancel animated:NO];
}

- (void)dealloc
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


#pragma mark - Ations

- (void)actionSave:(UIBarButtonItem *)itemSave
{
    // TODO: save pin
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionCancel:(UIBarButtonItem *)itemCancel
{
    // TODO: cansel save pin
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
