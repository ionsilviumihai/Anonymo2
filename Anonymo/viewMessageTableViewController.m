//
//  viewMessageTableViewController.m
//  TestGogu
//
//  Created by Cristian Olteanu on 4/20/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "viewMessageTableViewController.h"
#import "AllMessagesCustomTableCell.h"
#import "CommentCustomTableCell.h"
#import "NewCommentViewController.h"
#import "httpRequests.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Base64.h"
#import "photoViewController.h"


@interface viewMessageTableViewController ()

@end

@implementation viewMessageTableViewController
{
    NSString *testVotare;
    BOOL existaPoza;
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
    existaPoza = NO;
    self.imagineFundal.hidden = true;
    
    
    [self loadDataForSection1];
    [self loadPhotoForSection1];

}
-(void)viewWillAppear:(BOOL)animated
{
    [self loadDataForSection2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        if([self.dateComments count] > 0)
            return [self.dateComments count];
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        //[tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        //[tableView setSeparatorColor:[UIColor blueColor]];
        static NSString *simpleTableIdentifier = @"messageCell";
        MessagesCustomTableCell *cell = (MessagesCustomTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if(cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MessageCustomTableCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //cell.messageLabel.text = [[date objectAtIndex:indexPath.row] objectForKey:@"text"];
        //[cell.messageLabel sizeToFit];
        // = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
        //NSLog(@"%@", [preparationTime objectAtIndex:indexPath.row]);
        //cell.prepTimeLabel.text = [preparationTime objectAtIndex:indexPath.row];
        //[cellsArray insertObject:cell atIndex:indexPath.row];
        cell.messageLabel.text = self.mesaj;
        cell.dateLabel.text = self.data;
        cell.idMesaj = self.idMesaj;
        [cell.upVotesButton setTitle:[NSString stringWithFormat:@"%@",self.upVotes] forState:UIControlStateNormal];
        [cell.downVotesButton setTitle:[NSString stringWithFormat:@"%@", self.downVotes] forState:UIControlStateNormal];
        cell.authorLabel.text = self.author;
        if ([testVotare isEqualToString:@"A votat up"]) {
            NSLog(@"Se va dezactiva butonul de like");
            cell.upVotesButton.enabled = false;
            cell.upVotesButton.alpha = 0.3;
        }
        if ([testVotare isEqualToString:@"A votat down"]) {
            NSLog(@"Se va dezactiva butonul de dislike");
            cell.downVotesButton.enabled = false;
            cell.downVotesButton.alpha = 0.3;
        }
        if(existaPoza == YES)
        {
            cell.clipButton.alpha = 1;
            cell.clipButton.enabled = YES;
        }
        else{
            cell.clipButton.alpha = 0.4;
            cell.clipButton.enabled = NO;
        }

        [cell setDelegate:self];
        return cell;
    }
    if(indexPath.section == 1)
    {
        static NSString *simpleTableIdentifier = @"commentCell";
        CommentCustomTableCell *cell = (CommentCustomTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if(cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentCustomTableCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        NSLog(@"Datecomment are dimensiunea : %d si indePath row = %d", [self.dateComments count], indexPath.row);
        if([self.dateComments count] > indexPath.row)
        {
        cell.textLabel.text = [[self.dateComments objectAtIndex:(indexPath.row )] objectForKey:@"text"];
        //cell.details =
        NSString *data = [[self.dateComments objectAtIndex:(indexPath.row)] objectForKey:@"date"];
        double timeInterval = [data doubleValue];
        NSTimeInterval intervalForTimer = timeInterval;
        NSDate* newDate = [ NSDate dateWithTimeIntervalSince1970: intervalForTimer];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        NSString *formattedDateString = [dateFormatter stringFromDate:newDate];
        cell.detailsLabel.text = formattedDateString;
        
        [httpRequests getUserWithID:[[self.dateComments objectAtIndex:(indexPath.row)] objectForKey:@"userId"] success:^(id data) {
            cell.detailsLabel.text = [NSString stringWithFormat:@"%@ sent by %@",cell.detailsLabel.text, [data objectForKey:@"name"]];
        } error:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"nu s-a gasit userul cu idul cerut");
        }];
        }
        
        //cell.messageLabel.text = [[date objectAtIndex:indexPath.row] objectForKey:@"text"];
        //[cell.messageLabel sizeToFit];
        // = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
        //NSLog(@"%@", [preparationTime objectAtIndex:indexPath.row]);
        //cell.prepTimeLabel.text = [preparationTime objectAtIndex:indexPath.row];
        //[cellsArray insertObject:cell atIndex:indexPath.row];
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 358;
    }
    
    else
        return 117;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(void)presentNewComment:(NSString *)idMesaj
{
    NewCommentViewController *newCommVC = [[NewCommentViewController alloc] initWithNibName:@"NewCommentViewController" bundle:nil];
    newCommVC.idMesaj = idMesaj;
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:newCommVC];
    [self presentViewController:navC animated:YES completion:nil];
}

-(void)upVotePressedwithMessageID:(NSString *)idMesaj UserID:(NSString *)idUser
{
    [httpRequests userGiveReviewToMessageID:idMesaj
                                     UserID:[NSString stringWithFormat:@"%@", idUser]
                                      value:@"up"
                                    success:^(id date)
    {
        NSLog(@"Like inregistrat!");
        testVotare = @"A votat up";
        [self loadDataForSection1];
    }
                                      error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"A avut loc eroarea %@", error);
    }];
}
-(void)downVotePressedwithMessageID:(NSString *)idMesaj UserID:(NSString *)idUser
{
    [httpRequests userGiveReviewToMessageID:idMesaj
                                     UserID:[NSString stringWithFormat:@"%@", idUser]
                                      value:@"down"
                                    success:^(id date)
     {
         NSLog(@"Like inregistrat!");
         testVotare = @"A votat down";
         [self loadDataForSection1];
         //[self.table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
     }
                                      error:^(AFHTTPRequestOperation *operation, NSError *error)
    {
                                          NSLog(@"A avut loc eroarea %@", error);
    }];
}

-(void)showPhoto
{
    photoViewController *pVC = [[photoViewController alloc] initWithNibName:@"photoViewController" bundle:nil];
    pVC.poza = [self.imagineFundal image];
    
    //[self.navigationController pushViewController:pVC animated:YES];
    
    [self presentViewController:pVC animated:YES completion:nil];
}

-(void) loadDataForSection1
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *CurrentUserID = appDelegate.idUser;
    
    // Do any additional setup after loading the view from its nib.
    
    [httpRequests getUserWithID:self.idUser success:^(id data) {
        self.author = [NSString stringWithFormat:@"Author: %@",[data objectForKey:@"name"]];
        [self.table reloadData];
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"nu s-a gasit userul cu idul cerut");
    }];
    
    [httpRequests getVotesForMessageID:self.idMesaj success:^(id data) {
        self.downVotes = [NSString stringWithFormat:@"%@", [[data objectAtIndex:0] objectForKey:@"downVotes"]];
        self.upVotes = [NSString stringWithFormat:@"%@", [[data objectAtIndex:0] objectForKey:@"upVotes"]];
        [self.table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"a avut loc e eroare. Incercati mai tarziu");
    }];
    self.date = [[NSMutableArray alloc] init];
    testVotare = @"Nu a votat inca";
    [httpRequests getVotessuccess:^(id data) {
        for (NSDictionary* messagesDict in data)
        {
            [self.date addObject:messagesDict];
        }
        for (int i=0; i<[self.date count]; i++)
        {
            int x = [[[self.date objectAtIndex:i] objectForKey:@"userId"] intValue];
            int y = [[[self.date objectAtIndex:i] objectForKey:@"messageId"] intValue];
            int z = [self.idMesaj intValue];
            int t = [CurrentUserID intValue];
            NSString *vote = [NSString stringWithFormat:@"%@",[[self.date objectAtIndex:i] objectForKey:@"value"]];
            
            NSLog(@"compara %d cu %d si %d cu %d",x,t,y,z);
            if (x == t && y == z) {
                if([vote isEqualToString:@"up"])
                {
                    testVotare = @"A votat up";
                }
                if([vote isEqualToString:@"down"])
                {
                    testVotare = @"A votat down";
                }
                break;
            }
        }
        [self.table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"a aparut o eroare.");
    }];
}

-(void)loadDataForSection2
{
    self.dateComments = [[NSMutableArray alloc] init];
    NSLog(@"Id mesaj este: %@", self.idMesaj);
    [httpRequests getCommentsForMessageID:self.idMesaj
                                  success:^(id data)
    {
        for (NSDictionary* messagesDict in data)
        {
            [self.dateComments addObject:messagesDict];
        }
        //[self.table reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.table reloadData];
    }
                                    error:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"A avut loc eroarea: %@", [error description]);  
    }];
}

-(void)loadPhotoForSection1
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [httpRequests getPhotoforMessageID:self.idMesaj
                              ssuccess:^(id data)
     {
         if([data count])
         {
             existaPoza = YES;
             NSLog(@"Afiseaza: %@", [[data objectAtIndex:0] objectForKey:@"image"]);
             NSString* ceva = [[data objectAtIndex:0] objectForKey:@"image"];
             
             [Base64 initialize];
             NSData *poz = [Base64 decode:ceva];
             UIImage *image = [[UIImage alloc] initWithData:poz];
             [self.imagineFundal setImage:image];
             [self.table reloadData];
         }
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     } error:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Eroare!");
     }];

}

@end
