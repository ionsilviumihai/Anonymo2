//
//  viewEventViewController.h
//  TestGogu
//
//  Created by Ion Silviu on 5/20/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface viewEventViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *participantsLabel;
@property (weak, nonatomic) IBOutlet UIButton *joinEventButton;





@property (strong, nonatomic) NSString *titlu;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *data;
@property (strong, nonatomic) NSString *userName;
@property (nonatomic, strong) CLLocation *coordonataEveniment;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *eventID;
@property (nonatomic, strong) NSString *userEventID;

- (IBAction)joinEventPushed:(id)sender;
- (IBAction)viewOnMapPushed:(id)sender;




@end
