//
//  viewEventOnMapViewController.h
//  TestGogu
//
//  Created by Ion Silviu on 5/22/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface viewEventOnMapViewController : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) CLLocation *coordonata;

@end
