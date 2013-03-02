//
//  CommentsViewController.m
//  TestGogu
//
//  Created by Meeshoo on 3/2/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "CommentsViewController.h"

@interface CommentsViewController ()

@end

@implementation CommentsViewController

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
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];//
    if([userDefault objectForKey:@"Comentariu"])
    {
        [self.myComment setText:[userDefault objectForKey:@"Comentariu"]];
    }
    
    [self.myComment setDelegate:self];
    
    [self.titleLabel setText:self.titlu];
    [self.subtitleLabel setText:self.subtitlu];
    
    
    UIGestureRecognizer* tappedScreen=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedScreen:)];
    [self.view addGestureRecognizer:tappedScreen];
    
// cum iei inaltimea la text    
//    [@"textCommetatiu" sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]
//                  constrainedToSize:CGSizeMake(100,20 )
//                      lineBreakMode:NSLineBreakByWordWrapping].height;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeVC:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)postCommnet:(id)sender
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];//
    [userDefault setValue:self.myComment.text forKey:@"Comentariu"];
    [userDefault synchronize];
    //send comment to server
    [self.myComment setText:@""];
    [self.myComment resignFirstResponder];

}

-(void)tappedScreen:(id)sender
{
    
    UIView* selectedView = [(UIGestureRecognizer*)sender view];
    
    if(selectedView != self.myComment)
    {
        [self.myComment resignFirstResponder];
    }
        
}

#pragma mark textField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
