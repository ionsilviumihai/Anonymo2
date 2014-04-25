//
//  MessagesCustomTableCell.m
//  TestGogu
//
//  Created by Cristian Olteanu on 4/20/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "MessagesCustomTableCell.h"
#import "NewCommentViewController.h"
#import "AppDelegate.h"
#import "httpRequests.h"

@implementation MessagesCustomTableCell

@synthesize messageLabel, dateLabel, authorLabel, mesaj, details, idMesaj;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"a intrat in style");
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)writeComment:(id)sender {
//    NewCommentViewController *newCommVC = [[NewCommentViewController alloc] initWithNibName:@"NewCommentViewController" bundle:nil];
//    newCommVC.idMesaj = idMesaj;
//    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:newCommVC];
//    [self presentViewController:navC animated:YES completion:nil];
    [self.delegate presentNewComment:idMesaj];
}

- (IBAction)clipButtonPushed:(id)sender {
    [self.delegate showPhoto];
}

- (IBAction)likeButton:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *UserID = appDelegate.idUser;

    [self.delegate upVotePressedwithMessageID:self.idMesaj UserID:UserID];
}
- (IBAction)dislikeButton:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *UserID = appDelegate.idUser;
    
    [self.delegate downVotePressedwithMessageID:self.idMesaj UserID:UserID];
}



@end
