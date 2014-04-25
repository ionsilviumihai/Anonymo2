//
//  CreateEventViewController.m
//  TestGogu
//
//  Created by Ion Silviu on 5/19/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "CreateEventViewController.h"
#import "AppDelegate.h"
#import "httpRequests.h"

@interface CreateEventViewController ()

@end

@implementation CreateEventViewController

@synthesize navigationController, coordonataEveniment;

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
    // Do any additional setup after loading the view from its nib.
    
    self.picker.timeZone = [NSTimeZone localTimeZone];
    self.picker.date = [NSDate date];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(closeViewController:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                           target:self
                                                                                           action:@selector(saveEvent:)];
    
    
    
    NSDate *now = [NSDate date];
    [self.picker setDate:now animated:YES];
    self.dataEveniment = now;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm:00"];
    NSString *theDate = [dateFormat stringFromDate:now];
    NSString *theTime = [timeFormat stringFromDate:now];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",theDate,theTime];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)closeViewController:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveEvent:(id)sender
{
    if ([self.titleField.text isEqualToString:@""] || [self.descriptionField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"All fields requiered!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        NSString* descriere = self.descriptionField.text;
        NSString* titlu = self.titleField.text;
        NSString *messageText = [NSString stringWithFormat:@"%@ ; %@", titlu, descriere];
        NSLog(@"%@",messageText);
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSString *UserID = appDelegate.idUser;
        //NSNumber *UserID = [NSNumber ]
        //NSLog(@"Id-ul cautat este %@", appDelegate.idUser);
        //NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        //[f setNumberStyle:NSNumberFormatterCurrencyStyle];
        //NSNumber *UserID =[f numberFromString:appDelegate.idUser];
        //NSLog(@"Initial este %@", appDelegate.idUser);
        //long user_id = appDelegate.idUser;
        //NSNumber *UserID = [NSNumber numberWithLong: user_id];
        //NSLog(@"Iar apoi se schimba in %ld", user_id);
        //NSString *latitude = [[NSString alloc] initWithFormat:@"%f",coordonataMesaj.latitude ];
        NSString *latitude = [[NSString alloc] initWithFormat:@"%f", coordonataEveniment.latitude];
        NSString *longitiude = [[NSString alloc] initWithFormat:@"%f",coordonataEveniment.longitude];
        double interval = [self.dataEveniment timeIntervalSince1970];
        long interv = (long)interval;
        NSNumber *date = [NSNumber numberWithLong:interv];
        NSLog(@"User:%@ descriptionText:%@ latitude:%@ longitude:%@ interval:%ld",UserID,messageText,latitude,longitiude,interv);
        [httpRequests createEventWithUserID:UserID
                                       date:date
                                description:messageText
                                   latitude:latitude
                                  longitude:longitiude
                                    success:^(id data) {
                                        NSLog(@"S-a creat un eveniment nou");
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        NSLog(@"A avut loc o eroare");
                                    }];

    }
}


- (IBAction)displayDate:(id)sender {
    NSDate *selected = [self.picker date];
    self.dataEveniment = [selected dateByAddingTimeInterval:10800];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm:00"];
    NSString *theDate = [dateFormat stringFromDate:selected];
    NSString *theTime = [timeFormat stringFromDate:selected];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",theDate,theTime];

  

}
@end
