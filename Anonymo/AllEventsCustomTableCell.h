//
//  AllEventsCustomTableCell.h
//  TestGogu
//
//  Created by Ion Silviu on 5/21/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface AllEventsCustomTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;


@property (nonatomic, strong) NSString *titlu;
@property (nonatomic, strong) NSString *descriere;
@property (nonatomic, strong) NSString *data;
@property (nonatomic, strong) NSString *idUser;
@property (nonatomic, strong) NSString *idEvent;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) CLLocation *coordonata;

@end
