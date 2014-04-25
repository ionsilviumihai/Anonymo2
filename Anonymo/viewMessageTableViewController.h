//
//  viewMessageTableViewController.h
//  TestGogu
//
//  Created by Cristian Olteanu on 4/20/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessagesCustomTableCell.h"


@interface viewMessageTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, commentCustomCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) NSString *idMesaj;
@property (strong, nonatomic) NSString *idUser;
@property (strong, nonatomic) NSString *data;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *mesaj;
@property (weak, nonatomic) IBOutlet UIImageView *imagineFundal;

@property (nonatomic, strong) NSMutableArray *date;
@property (nonatomic, strong) NSMutableArray *dateComments;

@property (nonatomic) NSString *upVotes;
@property (nonatomic) NSString *downVotes;

-(void) loadDataForSection1;
-(void) loadDataForSection2;
-(void) loadPhotoForSection1;


@end
