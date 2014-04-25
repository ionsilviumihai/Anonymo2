//
//  viewMessageViewController.m
//  TestGogu
//
//  Created by Ion Silviu on 4/14/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "viewMessageViewController.h"
#import "NewCommentViewController.h"

@interface viewMessageViewController ()

@end

@implementation viewMessageViewController
@synthesize messageLabel, dateLabel, authorLabel, mesaj, details, idMesaj;

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)likeButton:(id)sender {
}

- (IBAction)dislikeButton:(id)sender {
}
- (IBAction)shareButton:(id)sender {
}

- (IBAction)commentButton:(id)sender {
}

- (IBAction)writeComment:(id)sender {
    NewCommentViewController *newCommVC = [[NewCommentViewController alloc] initWithNibName:@"NewCommentViewController" bundle:nil];
    newCommVC.idMesaj = idMesaj;
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:newCommVC];
    [self presentViewController:navC animated:YES completion:nil];

}
@end
