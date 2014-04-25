//
//  CommentCustomTableCell.h
//  TestGogu
//
//  Created by Ion Silviu on 4/21/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCustomTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *details;

@end
