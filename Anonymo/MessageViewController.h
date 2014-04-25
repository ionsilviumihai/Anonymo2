//
//  MessageViewController.h
//  TestGogu
//
//  Created by Meeshoo on 3/2/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const MY_MESSAGES;
FOUNDATION_EXPORT NSString *const ALL_MESSAGES;

@interface MessageViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *date;

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) UISegmentedControl *chooseAllOrSome;
@property (strong , nonatomic) NSMutableArray *mesajeSelectate;

-(void)getData;


@end
