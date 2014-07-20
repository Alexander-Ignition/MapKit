//
//  OGAddPinViewController.m
//  MapKit
//
//  Created by Александр Игнатьев on 19.07.14.
//  Copyright (c) 2014 Original Group. All rights reserved.
//

#import "OGAddPinViewController.h"


typedef enum {
    titleFieldType,
    subtitleFieldType,
    latitudeFieldType,
    longitudeFieldType
} textFieldType;


@interface OGAddPinViewController () <UITextFieldDelegate>

@end


@implementation OGAddPinViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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


#pragma mark - UITextFieldDelegate

// called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 0) {
        [[self.textFields objectAtIndex:(textField.tag + 1)] becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

// return NO to not change text
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSString *resaultStrinng = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
//    NSCharacterSet *numberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet]; // создаем масив символов за исключением цифр
//    NSArray *words = [resaultStrinng componentsSeparatedByCharactersInSet:numberSet]; // разбиваем строку на элементы массива с помощью ранее созданново сета символов
//    NSString *phoneStrinng = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    switch (textField.tag) {
        case titleFieldType:
            return YES;
            break;
        
        case subtitleFieldType:
            return YES;
            break;
        
        case latitudeFieldType:
            return NO;
            break;
        
        case longitudeFieldType:
            return NO;
            break;
        
        default:
            return NO;
            break;
    }
    
    //NSString *resaultStrinng = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //return [resaultStrinng length] <= 9;
}

@end
