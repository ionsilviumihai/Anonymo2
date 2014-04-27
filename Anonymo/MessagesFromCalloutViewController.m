//
//  MessagesFromCalloutViewController.m
//  TestGogu
//
//  Created by Ion Silviu on 4/18/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "MessagesFromCalloutViewController.h"
#import "AllMessagesCustomTableCell.h"
#import "httpRequests.h"
#import "viewMessageTableViewController.h"
#import "MBProgressHUD.h"

#import "CustomCellBackground.h"

@interface MessagesFromCalloutViewController ()

@end

@implementation MessagesFromCalloutViewController
{
    NSMutableArray *cellsArray;
    NSMutableArray *rowRequest;
    NSMutableString *authorName;
}

@synthesize date, latitudine, longitudine, table;

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
    date = [[NSMutableArray alloc] init];
    [httpRequests getAllMessagessuccess:^(id data) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        for (NSDictionary* messagesDict in data)
        {
            if(([[messagesDict objectForKey:@"latitude"] isEqualToString:latitudine]) && ([[messagesDict objectForKey:@"longitude"] isEqualToString:longitudine]))
            {
                [date addObject:messagesDict];
            }
        }
        NSLog(@"Marime: %d", [date count]);
        [table reloadData];
        rowRequest = [[NSMutableArray alloc] initWithCapacity:[date count]];
        for(int i=0; i<[date count]; i++)
        {
            BOOL booleanValue = NO;
            [rowRequest addObject:[NSNumber numberWithBool:booleanValue]];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Mare Eroare!");
    }];
    
    cellsArray = [[NSMutableArray alloc] init];
    authorName = [[NSMutableString alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Count: %d", [date count]);
    return [date count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    //[tableView setSeparatorColor:[UIColor blueColor]];
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    AllMessagesCustomTableCell *cell = (AllMessagesCustomTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AllMessagesCustomTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //set color of cells
    if (![cell.backgroundView isKindOfClass:[CustomCellBackground class]]) {
        cell.backgroundView = [[CustomCellBackground alloc] init];
    }
    if (![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]]) {
        cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
    }
    //end setting color of cells
    
    
    //mesaj
    cell.messageLabel.text = [[date objectAtIndex:indexPath.row] objectForKey:@"text"];
    //data
    NSString *data = [[date objectAtIndex:indexPath.row] objectForKey:@"date"];
    double timeInterval = [data doubleValue];
    NSTimeInterval intervalForTimer = timeInterval;
    NSDate* newDate = [ NSDate dateWithTimeIntervalSince1970: intervalForTimer];
    NSLog(@"Date mesajului este = %@", newDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *formattedDateString = [dateFormatter stringFromDate:newDate];
    NSLog(@"formattedDateString: %@", formattedDateString);
    
    //author name
    NSString *userID = [[date objectAtIndex:indexPath.row] objectForKey:@"userId"];
    [httpRequests getUserWithID:userID success:^(id data) {
        cell.detailsLabel.text = [NSString stringWithFormat:@"%@ sent by %@",formattedDateString, [data objectForKey:@"name"]];

    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"nu s-a gasit userul cu idul cerut");
    }];
    [cell.messageLabel sizeToFit];
    // = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    //NSLog(@"%@", [preparationTime objectAtIndex:indexPath.row]);
    //cell.prepTimeLabel.text = [preparationTime objectAtIndex:indexPath.row];
    [cellsArray insertObject:cell atIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*if([cellsArray count] != 0 )
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AllMessagesCustomTableCell" owner:self options:nil];
        AllMessagesCustomTableCell *cell = [nib objectAtIndex:0];
        cell = [cellsArray objectAtIndex:indexPath.row];
        if ([cell.textLabel.text length] <25)
        {
            return 150;
        }
        else
            return 203;
    }
    else
        return 203;
     */
    if([date count])
    {
        if([[[date objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 33)
        {
            return 85;
        }
        else
        {
            if([[[date objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 65)
            {
                return 93;
            }
            else
            {
                if([[[date objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 97)
                {
                    return 126;
                }
                else
                {
                    if([[[date objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 129)
                    {
                        return 148;
                    }
                    else
                    {
                        if([[[date objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 203)
                        {
                            return 151;
                        }
                    }
                }
            }
        }
    }
    else
    {
        NSLog(@"A intrat in else");
        return 203;
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
//    viewMessageTableViewController *viewMessageVC = [[viewMessageTableViewController alloc] initWithNibName:@"viewMessageTableViewController" bundle:nil];
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AllMessagesCustomTableCell" owner:self options:nil];
//    AllMessagesCustomTableCell *cell = [nib objectAtIndex:0];
//    cell = [cellsArray objectAtIndex:indexPath.row];
//    //viewMessageVC.mesaj = cell.messageLabel.text;
//    //viewMessageVC.idMesaj = [[date objectAtIndex:indexPath.row] objectForKey:@"id"];
//    [viewMessageVC setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:viewMessageVC animated:YES];
    
    viewMessageTableViewController *viewMessageVC = [[viewMessageTableViewController alloc] initWithNibName:@"viewMessageTableViewController" bundle:nil];
    viewMessageVC.mesaj = [[date objectAtIndex:indexPath.row] objectForKey:@"text"];
    viewMessageVC.idMesaj = [[date objectAtIndex:indexPath.row] objectForKey:@"id"];
    viewMessageVC.idUser = [[date objectAtIndex:indexPath.row] objectForKey:@"userId"];
    
    NSString *data = [[date objectAtIndex:indexPath.row] objectForKey:@"date"];
    double timeInterval = [data doubleValue];
    NSTimeInterval intervalForTimer = timeInterval;
    NSDate* newDate = [ NSDate dateWithTimeIntervalSince1970: intervalForTimer];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *formattedDateString = [dateFormatter stringFromDate:newDate];
    viewMessageVC.data = formattedDateString;
    //viewMessageVC.mesaj = cell.messageLabel.text;
    //viewMessageVC.idMesaj = [[date objectAtIndex:indexPath.row] objectForKey:@"id"];
    [viewMessageVC setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:viewMessageVC animated:YES];
    
    
}


-(void)getMessagesVotes:(NSString *)idMesaj
{
    
}



@end
