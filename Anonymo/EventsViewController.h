//
//  EventsViewController.h
//  TestGogu
//
//  Created by Ion Silviu on 4/17/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface EventsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) NSMutableArray *date;
@property (nonatomic, strong) NSMutableArray *date2;
@property (nonatomic) CLLocationCoordinate2D coordonataUser;
@property (nonatomic) int counter;
@end
