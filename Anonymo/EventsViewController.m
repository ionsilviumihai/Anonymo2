//
//  EventsViewController.m
//  TestGogu
//
//  Created by Ion Silviu on 4/17/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "EventsViewController.h"
#import "httpRequests.h"
#import "AllEventsCustomTableCell.h"
#import "viewEventViewController.h"
#import "MBProgressHUD.h"
#import "MapViewController.h"
#import "AppDelegate.h"

@interface EventsViewController ()

@end

@implementation EventsViewController
{
    NSMutableArray *rowRequest;
    NSMutableString *authorName;
}

@synthesize table, date, date2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.counter = -1;
    date = [[NSMutableArray alloc] init];
    [httpRequests getAllEventssuccess:^(id data) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        for (NSDictionary* messagesDict in data)
        {
            if ([[messagesDict objectForKey:@"date"] doubleValue] > [[NSDate date] timeIntervalSince1970]) {
                [date addObject:messagesDict];
            }
            //[date addObject:messagesDict];

        }
        
        
        //sortare vector dupa distanta
        BOOL swapped = YES;
        int j = 0;
        while (swapped) {
            swapped = NO;
            j++;
            for(int i = 0; i < [date count] - j; i++)
            {
                //distana1
                CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:self.coordonataUser.latitude longitude:self.coordonataUser.longitude];
                CLLocation *eventLocation1 = [[CLLocation alloc] initWithLatitude:[[[date objectAtIndex:i] objectForKey:@"latitude"] doubleValue]  longitude:[[[date objectAtIndex:i] objectForKey:@"longitude"] doubleValue]];
                double distance1 = [userLocation distanceFromLocation:eventLocation1];
                //distanta2
                CLLocation *eventLocation2 = [[CLLocation alloc] initWithLatitude:[[[date objectAtIndex:i+1] objectForKey:@"latitude"] doubleValue]  longitude:[[[date objectAtIndex:i+1] objectForKey:@"longitude"] doubleValue]];
                double distance2 = [userLocation distanceFromLocation:eventLocation2];
                //NSLog(@"comparam %f cu %f",distance1,distance2);
                if (distance1 > distance2) {
                    [date exchangeObjectAtIndex:i withObjectAtIndex:i+1];
                    swapped = YES;
                }
            }
        }
        
        //NSLog(@"Numar de evenimente descarcate: %d", [date count]);
        [table reloadData];
        rowRequest = [[NSMutableArray alloc] initWithCapacity:[date count]];
        for(int i=0; i<[date count]; i++)
        {
            BOOL booleanValue = NO;
            [rowRequest addObject:[NSNumber numberWithBool:booleanValue]];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Eroare!");
    }];
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.coordonataUser = appDelegate.coordonataUser;
       
    authorName = [[NSMutableString alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"Count: %d", [date count]);
    return [date count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"A intrat in craere celula cu idex path.row = %d",indexPath.row);
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    //[tableView setSeparatorColor:[UIColor blueColor]];
    
    
    static NSString *simpleTableIdentifier = @"eventCell";
    AllEventsCustomTableCell *cell = (AllEventsCustomTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil) {
        NSLog(@"a intrat in if cell == nil");
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AllEventsCustomTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    //mesaj
    NSArray *eventDescription = [[NSArray alloc] init];
    eventDescription = [[[date objectAtIndex:indexPath.row] objectForKey:@"description"] componentsSeparatedByString:@";"];
    cell.titleLabel.text = [eventDescription objectAtIndex: 0];
    if([eventDescription count] == 2 )
    {
        cell.descriptionLabel.text = [eventDescription objectAtIndex:1];
    }
    
    cell.idEvent = [[date objectAtIndex:indexPath.row] objectForKey:@"id"];
    cell.idUser = [[date objectAtIndex:indexPath.row] objectForKey:@"userId"];
    NSString *data = [[date objectAtIndex:indexPath.row] objectForKey:@"date"];
    double timeInterval = [data doubleValue];
    NSTimeInterval intervalForTimer = timeInterval;
    NSDate* newDate = [ NSDate dateWithTimeIntervalSince1970: intervalForTimer];
    //NSLog(@"Data evenimentului este = %@", newDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *formattedDateString = [dateFormatter stringFromDate:newDate];
    //NSLog(@"formattedDateString: %@", formattedDateString);
    cell.dateLabel.text = formattedDateString;
    cell.data = formattedDateString;

    
    //aflam distanta dintre user location si event location
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:self.coordonataUser.latitude longitude:self.coordonataUser.longitude];
    //NSLog(@"Latitude1: %f, Longitude1: %f, Latitude2: %f, Longitude2: %f",self.coordonataUser.latitude, self.coordonataUser.longitude, [[[date objectAtIndex:indexPath.row] objectForKey:@"latitude"] doubleValue], [[[date objectAtIndex:indexPath.row] objectForKey:@"longitude"] doubleValue]);
    CLLocation *eventLocation = [[CLLocation alloc] initWithLatitude:[[[date objectAtIndex:indexPath.row] objectForKey:@"latitude"] doubleValue]  longitude:[[[date objectAtIndex:indexPath.row] objectForKey:@"longitude"] doubleValue]];
    float distance = [userLocation distanceFromLocation:eventLocation]/1000;
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.02f km", distance];
    cell.coordonata = eventLocation;
    
    NSString *userID = [[date objectAtIndex:indexPath.row] objectForKey:@"userId"];
    BOOL b = [[rowRequest objectAtIndex:indexPath.row] boolValue];
    if(!b)
    {
        [httpRequests getUserWithID:userID success:^(id data) {
            authorName = [data objectForKey:@"name"];
            cell.userName = authorName;
            //NSLog(@"Author: %@", authorName);
            /*
             for (NSDictionary *dict in data)
             {
             authorName = [NSString stringWithFormat:@"%@", [dict objectForKey:@"name"]];
             NSLog(@"%@", authorName);
             }
             */
            [table reloadData];
        } error:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Nu s-a gasit userul cu idul cerut");
        }];
        BOOL booleanValue = YES;
        [rowRequest replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:booleanValue]];
    }
    
    
    cell.dateLabel= [NSString stringWithFormat:@"%@ send by %@", formattedDateString, authorName];
    //[cell.messageLabel sizeToFit];
    // = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    //NSLog(@"%@", [preparationTime objectAtIndex:indexPath.row]);
    //cell.prepTimeLabel.text = [preparationTime objectAtIndex:indexPath.row];
    //if([cellsArray count] < [date count])
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([date count])
    {
        return 186;
    }
    else
    {
        //NSLog(@"A intrat in else");
        return 203;
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {

    //NSLog(@"S-a apasat celula cu numarul %d", indexPath.row);
    
    viewEventViewController*viewEventVC = [[viewEventViewController alloc] initWithNibName:@"viewEventViewController" bundle:nil];
        
//    cell = [cellsArray objectAtIndex:indexPath.row];
    

    
    
//    viewEventVC.titlu = cell.titleLabel.text;
//    viewEventVC.description = cell.descriptionLabel.text;
//    viewEventVC.data = cell.data;
//    viewEventVC.userName = cell.userName;
//    viewEventVC.coordonataEveniment = cell.coordonata;
//    viewEventVC.distance = cell.distanceLabel.text;
//    viewEventVC.userID = cell.idUser;
//    viewEventVC.eventID = cell.idEvent;
    
    NSArray *eventDescription = [[NSArray alloc] init];
    eventDescription = [[[date objectAtIndex:indexPath.row] objectForKey:@"description"] componentsSeparatedByString:@";"];
    viewEventVC.titlu = [eventDescription objectAtIndex: 0];
    if([eventDescription count] == 2 )
    {
        viewEventVC.description = [eventDescription objectAtIndex:1];
    }
    
    viewEventVC.eventID = [[date objectAtIndex:indexPath.row] objectForKey:@"id"];
    viewEventVC.userID = [[date objectAtIndex:indexPath.row] objectForKey:@"userId"];
    NSString *data = [[date objectAtIndex:indexPath.row] objectForKey:@"date"];
    double timeInterval = [data doubleValue];
    NSTimeInterval intervalForTimer = timeInterval;
    NSDate* newDate = [ NSDate dateWithTimeIntervalSince1970: intervalForTimer];
    //NSLog(@"Data evenimentului este = %@", newDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *formattedDateString = [dateFormatter stringFromDate:newDate];
    //NSLog(@"formattedDateString: %@", formattedDateString);
    viewEventVC.data = formattedDateString;
    
    //aflam distanta dintre user location si event location
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:self.coordonataUser.latitude longitude:self.coordonataUser.longitude];
    //NSLog(@"Latitude1: %f, Longitude1: %f, Latitude2: %f, Longitude2: %f",self.coordonataUser.latitude, self.coordonataUser.longitude, [[[date objectAtIndex:indexPath.row] objectForKey:@"latitude"] doubleValue], [[[date objectAtIndex:indexPath.row] objectForKey:@"longitude"] doubleValue]);
    CLLocation *eventLocation = [[CLLocation alloc] initWithLatitude:[[[date objectAtIndex:indexPath.row] objectForKey:@"latitude"] doubleValue]  longitude:[[[date objectAtIndex:indexPath.row] objectForKey:@"longitude"] doubleValue]];
    float distance = [userLocation distanceFromLocation:eventLocation]/1000;
    viewEventVC.distance = [NSString stringWithFormat:@"%.02f km", distance];
    viewEventVC.coordonataEveniment = eventLocation;
   // NSString *userID = [[date objectAtIndex:indexPath.row] objectForKey:@"userId"];

    [viewEventVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewEventVC animated:YES];
}




@end
