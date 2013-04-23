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
@end
