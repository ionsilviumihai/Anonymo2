//
//  MapViewController.m
//  TestGogu
//
//  Created by Meeshoo on 3/2/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "MapViewController.h"
#import "Annotation.h"
#import "MBProgressHUD.h"
#import "CommentsViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

#pragma mark - UIViewControllerMethods


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
    
    [self.mapView setDelegate:self];
    
    [self.mapView setShowsUserLocation:YES];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    CLLocationCoordinate2D coordonate = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude);
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion regiune =  MKCoordinateRegionMake(coordonate, zoom);
    [self.mapView setRegion:regiune animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MapViewDelegateMethods


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D coordonate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.01, 0.01);	
    MKCoordinateRegion regiune =  MKCoordinateRegionMake(coordonate, zoom);
    [self.mapView setRegion:regiune animated:YES];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if(![annotation isMemberOfClass:[MKUserLocation class]])
    {
        MKPinAnnotationView *returnedAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"anotatie"];
        [returnedAnnotation setImage:[UIImage imageNamed:@"Romania-icon"]];
        [returnedAnnotation setCanShowCallout:YES];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        [imageView setImage: [UIImage imageNamed: @"Romania-icon"]];
        [returnedAnnotation setLeftCalloutAccessoryView:imageView];
        UIButton *butonMesaj = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [returnedAnnotation setRightCalloutAccessoryView: butonMesaj];
        return returnedAnnotation;
    }
    else return nil;
}


-(void)                 mapView:(MKMapView *)mapView
                 annotationView:(MKAnnotationView *)view
  calloutAccessoryControlTapped:(UIControl *)control
{
    
//alert example
//    [[[UIAlertView alloc]initWithTitle:@"Alerta"
//                               message:@"Ati apasat pe buton"
//                              delegate:nil
//                     cancelButtonTitle:@"Cancel"
//                     otherButtonTitles:nil] show];
    
    CommentsViewController* cVC=[[CommentsViewController alloc] initWithNibName:@"CommentsViewController" bundle:nil];
    Annotation* selectedAnnotation = (Annotation*)view.annotation;
    
    cVC.titlu = selectedAnnotation.title;
    cVC.subtitlu = selectedAnnotation.subtitle;
    
    [self presentViewController:cVC
                       animated:YES
                     completion:^{}];
    
}

#pragma mark - Actions

-(IBAction)buttonPressed:(UIButton *)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableArray *vectorCoordonate = [[NSMutableArray alloc] init];
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:self.mapView.userLocation.coordinate.latitude longitude:self.mapView.userLocation.coordinate.longitude];
    for(int i = 0;i<10;i++)
    {

        Annotation *anotatie = [[Annotation alloc] init];
        anotatie.subiect = @"Aici sunt eu!";
        anotatie.coment = @"Da, da, aici sunt eu!";
        anotatie.coordonata = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude + i/10.0, self.mapView.userLocation.coordinate.longitude - i/10.0);
        CLLocation *secondUserLocation = [[CLLocation alloc] initWithLatitude:anotatie.coordonata.latitude longitude:anotatie.coordonata.longitude];
        float distance = [userLocation distanceFromLocation:secondUserLocation];
        NSLog(@"Distanta dintre punctul pus si user este %f km",distance/1000);
        [vectorCoordonate addObject:anotatie];
    }

    [self.mapView performSelectorInBackground:@selector(addAnnotations:) withObject:vectorCoordonate]; //implementare thread
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}


@end
