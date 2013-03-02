//
//  CommentsViewController.h
//  TestGogu
//
//  Created by Meeshoo on 3/2/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UITextField *myComment;


@property (nonatomic, strong) NSString* titlu;
@property (nonatomic, strong) NSString* subtitlu;


@end
