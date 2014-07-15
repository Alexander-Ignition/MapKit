//
//  OGMapViewController.m
//  MapKit2
//
//  Created by Alexander Ignition on 15.07.14.
//  Copyright (c) 2014 Original Group. All rights reserved.
//

#import "OGMapViewController.h"
#import "OGCoreData.h"
#import "OGPin.h"


@interface OGMapViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end


@implementation OGMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.mapView.delegate = self;
    [self configureAnnotations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation
{
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"MyPin"];
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MyPin"];
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
    }
    
    annotationView.annotation = annotation;
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"%s animated = %d", __PRETTY_FUNCTION__, animated);
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"%s animated = %d", __PRETTY_FUNCTION__, animated);
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    NSLog(@"%s fullyRendered = %d", __PRETTY_FUNCTION__, fullyRendered);
}


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

// called from AppDelegate, to set the UIMD, and set up the NSFRC
//- (void)setManagedDocument:(UIManagedDocument *)managedDocument
//{
//    _managedDocument = managedDocument;
//    [self fetchedResultsController];
//}

@end
