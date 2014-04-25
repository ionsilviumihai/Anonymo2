//
//  viewEventOnMapViewController.m
//  TestGogu
//
//  Created by Ion Silviu on 5/22/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "viewEventOnMapViewController.h"
#import "Annotation.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface viewEventOnMapViewController ()

@end

@implementation viewEventOnMapViewController

{
    BOOL updateRegion;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                          target:self
                                                                                          action:@selector(closeViewController:)];
    
    updateRegion = YES;
    
    [self.mapView setDelegate:self];
    
    [self.mapView setShowsUserLocation:YES];
    
    //CLLocationCoordinate2D coordonate = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude);
    
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.015, 0.015);
    MKCoordinateRegion regiune =  MKCoordinateRegionMake(self.coordonata.coordinate, zoom);
    [self.mapView setRegion:regiune animated:YES];
    
    Annotation *anotatie = [[Annotation alloc] init];
    anotatie.subiect = @"Event Location!";
    anotatie.coordonata = self.coordonata.coordinate;
    [self.mapView addAnnotation:anotatie];

}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MapViewDelegateMethods


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if(![annotation isMemberOfClass:[MKUserLocation class]])
    {
        MKPinAnnotationView *returnedAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"anotatie"];
        [returnedAnnotation setPinColor:MKPinAnnotationColorGreen];
        //[returnedAnnotation setImage:[UIImage imageNamed:@"pin_black"]];
        [returnedAnnotation setCanShowCallout:YES];
        return returnedAnnotation;
    }
    else return nil;
}





-(void)closeViewController:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
