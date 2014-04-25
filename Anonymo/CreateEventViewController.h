//
//  CreateEventViewController.h
//  TestGogu
//
//  Created by Ion Silviu on 5/19/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CreateEventViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIDatePicker *picker;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (weak, nonatomic) IBOutlet UITextView *descriptionField;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (nonatomic) CLLocationCoordinate2D coordonataEveniment;
@property (nonatomic, strong) NSDate *dataEveniment;

- (IBAction)displayDate:(id)sender;


@end
