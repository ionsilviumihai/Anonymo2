//
//  MessagesCustomTableCell.h
//  TestGogu
//
//  Created by Cristian Olteanu on 4/20/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol commentCustomCellDelegate <NSObject>

-(void)presentNewComment: (NSString *)idMesaj;
-(void)upVotePressedwithMessageID:(NSString *)idMesaj
                           UserID:(NSString *)idUser;
-(void)downVotePressedwithMessageID:(NSString *)idMesaj
                             UserID:(NSString *)idUser;
-(void)showPhoto;
@end


@interface MessagesCustomTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIButton *upVotesButton;
@property (weak, nonatomic) IBOutlet UIButton *downVotesButton;
@property (weak, nonatomic) IBOutlet UIButton *clipButton;

@property (nonatomic, strong) NSString* mesaj;
@property (nonatomic, strong) NSString* details;
@property (nonatomic, strong) NSString* idMesaj;
@property (nonatomic, strong) NSString* idUser;

@property (strong, nonatomic) id<commentCustomCellDelegate> delegate;


- (IBAction)likeButton:(id)sender;
- (IBAction)dislikeButton:(id)sender;
- (IBAction)shareButton:(id)sender;
- (IBAction)writeComment:(id)sender;
- (IBAction)clipButtonPushed:(id)sender;


@end
