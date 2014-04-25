//
//  viewEventViewController.m
//  TestGogu
//
//  Created by Ion Silviu on 5/20/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "viewEventViewController.h"
#import "httpRequests.h"
#import "viewEventOnMapViewController.h"

@interface viewEventViewController ()

@end

@implementation viewEventViewController

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
    self.titleLabel.text = self.titlu;
    self.descriptionLabel.text = self.description;
    self.dateLabel.text = self.data;
    self.distanceLabel.text = self.distance;
    NSLog(@"Username :%@", self.userName);
    self.authorLabel.text = self.userName;
    NSMutableArray *date = [[NSMutableArray alloc] init];
    [httpRequests getNumberOfParticipantsForEventWithEventID:self.eventID success:^(id data) {
        for (NSDictionary* messagesDict in data)
        {
            [date addObject:messagesDict];
        }
        int number = [[[date objectAtIndex:0] objectForKey:@"participants"] intValue];
        if(number != 1) {
            self.participantsLabel.text = [NSString stringWithFormat:@"%d people are going.",number];
        }
        else
        {
            self.participantsLabel.text = [NSString stringWithFormat:@"1 person is going."];
        }
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"A avut loc o eroare");
    }];
    
    __block BOOL userParticipa = NO;
    NSMutableArray *date2 = [[NSMutableArray alloc] init];
    [httpRequests getEventsforUserWithUserId:self.userID sucess:^(id data) {
        for (NSDictionary* messagesDict in data)
        {
            [date2 addObject:messagesDict];
        }
        int identifierEvent = [self.eventID intValue];
        for (int i=0; i<[date2 count]; i++) {
            int identifierEventServer = [[[date2 objectAtIndex:i] objectForKey:@"eventId"] intValue];
            NSLog(@"compara %d cu %d",identifierEvent, identifierEventServer);
            if (identifierEvent  == identifierEventServer) {
                self.userEventID = [[date2 objectAtIndex:i] objectForKey:@"id"];
                NSLog(@"userEvent id este: %@", self.userEventID);
                [self.joinEventButton setTitle:@"Leave Event" forState:UIControlStateNormal];
                userParticipa = YES;
                break;
            }
        }
        if (userParticipa == NO) {
            [self.joinEventButton setTitle:@"Join Event" forState:UIControlStateNormal];
        }
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"a avut loc o eroare!");
    }];
    [httpRequests getUserWithID:self.userID success:^(id data) {
        
        self.authorLabel.text = [data objectForKey:@"name"];
        /*
         for (NSDictionary *dict in data)
         {
         authorName = [NSString stringWithFormat:@"%@", [dict objectForKey:@"name"]];
         NSLog(@"%@", authorName);
         }
         */
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Nu s-a gasit userul cu idul cerut");
    }];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)joinEventPushed:(id)sender {
    if([[[self.joinEventButton titleLabel] text] isEqualToString:@"Leave Event"])
    {
        [httpRequests deleteUserJoinedEventWithRegisterId:self.userEventID sucess:^(id data) {
            NSLog(@"Userul nu mai participa la eveniment");
        } error:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"A avut loc o eroare");
        }];
        
        NSString *updateParticipants = [[self.participantsLabel.text componentsSeparatedByString:@" "] objectAtIndex:0];
        int number = [updateParticipants intValue];
        number--;
        self.participantsLabel.text = [NSString stringWithFormat:@"%d people are going",number];

        [self.joinEventButton setTitle:@"Join Event" forState:UIControlStateNormal];
    }
    else
    {
        [httpRequests createUserEventWithUserID:self.userID
                                        eventID:self.eventID
                                        success:^(id data)
        {
            NSLog(@"Userul %@ a dat join evenimentului %@",self.userID,self.eventID);
            self.userEventID = [data objectForKey:@"id"];
        } error:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"a avut loc o eroare!");
        }];
        
        NSString *updateParticipants = [[self.participantsLabel.text componentsSeparatedByString:@" "] objectAtIndex:0];
        int number = [updateParticipants intValue];
        number++;
        self.participantsLabel.text = [NSString stringWithFormat:@"%d people are going",number];
        
        [self.joinEventButton setTitle:@"Leave Event" forState:UIControlStateNormal];
    }
}

- (IBAction)viewOnMapPushed:(id)sender
{
    viewEventOnMapViewController *viewEventOnMapVC = [[viewEventOnMapViewController alloc] initWithNibName:@"viewEventOnMapViewController" bundle:nil];

    [viewEventOnMapVC setTitle:@"Event Location"];
    UINavigationController *VCNav = [[UINavigationController alloc] initWithRootViewController:viewEventOnMapVC];
    viewEventOnMapVC.coordonata = self.coordonataEveniment;
    [self presentViewController:VCNav
                       animated:YES
                     completion:^{}];
    
}


@end
