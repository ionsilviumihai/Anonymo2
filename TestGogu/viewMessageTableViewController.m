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


@interface viewMessageTableViewController ()

@end

@implementation viewMessageTableViewController

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
    return 4;
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
        //cell.messageLabel.text = [[date objectAtIndex:indexPath.row] objectForKey:@"text"];
        //[cell.messageLabel sizeToFit];
        // = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
        //NSLog(@"%@", [preparationTime objectAtIndex:indexPath.row]);
        //cell.prepTimeLabel.text = [preparationTime objectAtIndex:indexPath.row];
        //[cellsArray insertObject:cell atIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        [cell setDelegate:self];
        return cell;
    }
    else
    {
        //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        //[tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        //[tableView setSeparatorColor:[UIColor blueColor]];
        static NSString *simpleTableIdentifier = @"SimpleTableItem";
        CommentCustomTableCell *cell = (CommentCustomTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if(cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentCustomTableCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
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
        return 346;
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


@end
