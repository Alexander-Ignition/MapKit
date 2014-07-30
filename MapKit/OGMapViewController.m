//
//  OGMapViewController.m
//  MapKit2
//
//  Created by Alexander Ignition on 15.07.14.
//  Copyright (c) 2014 Original Group. All rights reserved.
//

#import "OGMapViewController.h"
#import "OGCoreData.h"
#import "OGAddPinViewController.h"


@interface OGMapViewController () <NSFetchedResultsControllerDelegate, UIBarPositioningDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end


@implementation OGMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureAnnotations];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar.layer removeAllAnimations];
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"%s error = %@", __PRETTY_FUNCTION__, error);
    }
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //    [self.navigationController.navigationBar setTranslucent:NO];
//    [self.navigationController.navigationBar.layer removeAllAnimations];
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"MyPin";
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        pin.canShowCallout = YES;
        pin.animatesDrop   = YES;
        pin.draggable      = YES;
    } else {
        pin.annotation = annotation;
    }
    
    return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    
}

//- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
//{
//    NSLog(@"%s animated = %d", __PRETTY_FUNCTION__, animated);
//}
//
//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
//{
//    NSLog(@"%s animated = %d", __PRETTY_FUNCTION__, animated);
//}
//
//- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
//{
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//}
//
//- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
//{
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//}
//
//- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView
//{
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//}
//- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
//{
//    NSLog(@"%s fullyRendered = %d", __PRETTY_FUNCTION__, fullyRendered);
//}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self fetchedResultsChangeInsert:anObject];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self fetchedResultsChangeDelete:anObject];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self fetchedResultsChangeUpdate:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            // do nothing
            break;
            
        default:
            break;
    }
}

- (void)fetchedResultsChangeInsert:(OGPin *)pin
{
    [self.mapView addAnnotation:pin];
}

- (void)fetchedResultsChangeDelete:(OGPin *)pin
{
    [self.mapView removeAnnotation:pin];
}

- (void)fetchedResultsChangeUpdate:(OGPin *)pin
{
    [self fetchedResultsChangeDelete:pin];
    [self fetchedResultsChangeInsert:pin];
}


#pragma mark - Getters

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OGPin"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"namePin" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSManagedObjectContext *moc = [OGCoreData defaultStore].managedObjectContext;
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil  cacheName:nil];
    [frc setDelegate:self];
    
    _fetchedResultsController = frc;
    
    NSError *error = nil;
    [_fetchedResultsController performFetch:&error];
    
    [self configureAnnotations];
    
    return _fetchedResultsController;
}

- (void)configureAnnotations
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:[self.fetchedResultsController fetchedObjects]];
}


#pragma mark - Actions

- (IBAction)addAction:(UIBarButtonItem *)sender
{
    UIStoryboard *mainStoriboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OGAddPinViewController *addPinViewController = [mainStoriboard instantiateViewControllerWithIdentifier:@"addPinViewController"];
    addPinViewController.location = [[CLLocation alloc] initWithLatitude:self.mapView.region.center.latitude
                                                               longitude:self.mapView.region.center.longitude];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addPinViewController];
//    navController.modalPresentationStyle  = UIModalPresentationPageSheet;
//    navController.modalTransitionStyle    = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:navController animated:YES completion:nil];
}

@end
