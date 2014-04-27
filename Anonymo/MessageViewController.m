//
//  MessageViewController.m
//  TestGogu
//
//  Created by Meeshoo on 3/2/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "MessageViewController.h"
#import "httpRequests.h"
#import "AllMessagesCustomTableCell.h"
#import "viewMessageViewController.h"
#import "AppDelegate.h"
#import "viewMessageTableViewController.h"

#import "CustomCellBackground.h"

@interface MessageViewController ()

@end

@implementation MessageViewController
{
    NSMutableArray *cellsArray;
    NSMutableArray *rowRequest;
    NSMutableString *authorName;
}

@synthesize date, table, chooseAllOrSome, mesajeSelectate;

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
    
    //setare SegmentBar
    NSArray *itemArray = [NSArray arrayWithObjects:@"My Messages", @"All Messages", nil];
    chooseAllOrSome = [[UISegmentedControl alloc] initWithItems: itemArray];
    [chooseAllOrSome setFrame:CGRectMake(0, 0, 150, 32)];
    chooseAllOrSome.segmentedControlStyle = UISegmentedControlStyleBar;
    chooseAllOrSome.selectedSegmentIndex = 0;
    [chooseAllOrSome addTarget:self action:@selector(pickOne:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:chooseAllOrSome];
    self.navigationItem.titleView = segmentBarItem.customView;
    cellsArray = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mesajeSelectate count];
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

    cell.messageLabel.text = [[mesajeSelectate objectAtIndex:indexPath.row] objectForKey:@"text"];
    [cell.messageLabel sizeToFit];
    // = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    //NSLog(@"%@", [preparationTime objectAtIndex:indexPath.row]);
    //cell.prepTimeLabel.text = [preparationTime objectAtIndex:indexPath.row];
    [cellsArray insertObject:cell atIndex:indexPath.row];
    
    NSString *data = [[mesajeSelectate objectAtIndex:indexPath.row] objectForKey:@"date"];
    double timeInterval = [data doubleValue];
    NSTimeInterval intervalForTimer = timeInterval;
    NSDate* newDate = [ NSDate dateWithTimeIntervalSince1970: intervalForTimer];
    NSLog(@"Date mesajului este = %@", newDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *formattedDateString = [dateFormatter stringFromDate:newDate];
    cell.detailsLabel.text = formattedDateString;

    [httpRequests getUserWithID:[[mesajeSelectate objectAtIndex:indexPath.row] objectForKey:@"userId"] success:^(id data) {
        cell.detailsLabel.text = [NSString stringWithFormat:@"%@ sent by %@",cell.detailsLabel.text, [data objectForKey:@"name"]];
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"nu s-a gasit userul cu idul cerut");
    }];

    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([mesajeSelectate count])
    {
        if([[[mesajeSelectate objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 33)
        {
            return 85;
        }
        else
        {
            if([[[mesajeSelectate objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 65)
            {
                return 93;
            }
            else
            {
                if([[[mesajeSelectate objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 97)
                {
                    return 126;
                }
                else
                {
                    if([[[mesajeSelectate objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 129)
                    {
                        return 148;
                    }
                    else
                    {
                        if([[[mesajeSelectate objectAtIndex:indexPath.row] objectForKey:@"text"] length] <= 203)
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
    /*
    viewMessageViewController *viewMessageVC = [[viewMessageViewController alloc] initWithNibName:@"viewMessageViewController" bundle:nil];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AllMessagesCustomTableCell" owner:self options:nil];
    AllMessagesCustomTableCell *cell = [nib objectAtIndex:0];
    cell = [cellsArray objectAtIndex:indexPath.row];
    viewMessageVC.mesaj = cell.messageLabel.text;
    viewMessageVC.idMesaj = [[mesajeSelectate objectAtIndex:indexPath.row] objectForKey:@"id"];
    [viewMessageVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewMessageVC animated:YES];
    */
    
    viewMessageTableViewController *viewMessageVC = [[viewMessageTableViewController alloc] initWithNibName:@"viewMessageTableViewController" bundle:nil];
    viewMessageVC.mesaj = [[mesajeSelectate objectAtIndex:indexPath.row] objectForKey:@"text"];
    viewMessageVC.idMesaj = [[mesajeSelectate objectAtIndex:indexPath.row] objectForKey:@"id"];
    viewMessageVC.idUser = [[mesajeSelectate objectAtIndex:indexPath.row] objectForKey:@"userId"];
    
    NSString *data = [[mesajeSelectate objectAtIndex:indexPath.row] objectForKey:@"date"];
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

-(void)pickOne: (id)sender
{
    mesajeSelectate=[[NSMutableArray alloc] init];
    if (chooseAllOrSome.selectedSegmentIndex == 0)
    {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSString *UserID = appDelegate.idUser;
        for (NSDictionary* dictionar in date)
        {
            if ([[NSString stringWithFormat:@"%@",[dictionar objectForKey:@"userId"]] isEqualToString:UserID])
            {
                [mesajeSelectate addObject:dictionar];
            }
        }

    }
    else
    {
        for (NSDictionary* dictionar in date)
        {
            [mesajeSelectate addObject:dictionar];
        }

    }
    [table reloadData];
}

-(void) GetMessagesVotes: (id)sender
{
    
}

-(void)getData
{
    //Luam date de pe server
    date = [[NSMutableArray alloc] init];
    mesajeSelectate = [[NSMutableArray alloc] init];
    [httpRequests getAllMessagessuccess:^(id data) {
        for (NSDictionary* messagesDict in data)
        {
            [date addObject:messagesDict];
        }
        NSLog(@"Marime: %d", [date count]);
        
        //facem vectorul care contine doar mesajele userului
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSString *UserID = appDelegate.idUser;
        mesajeSelectate = [[NSMutableArray alloc] init];
        for (NSDictionary* dictionar in date)
        {
            NSString *userServer = [NSString stringWithFormat:@"%@",[dictionar objectForKey:@"userId"]];
            if ([userServer isEqualToString:UserID])
            {
                [self.mesajeSelectate addObject:dictionar];
            }
        }
        //
        
        NSLog(@"Marime mesajeSelectate: %d", [self.mesajeSelectate count]);
        [table reloadData];
        
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Mare Eroare!");
    }];

}



@end
