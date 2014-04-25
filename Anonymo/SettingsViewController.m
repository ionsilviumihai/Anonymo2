//
//  SettingsViewController.m
//  TestGogu
//
//  Created by Ion Silviu on 4/17/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "httpRequests.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
{
    NSString *email;
    NSString *idUser;
    NSString *name;
    NSString *oldPassword;
    NSString *newPassword;
}

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
    self.oldPassField.delegate = self;
    self.passwordTextField.delegate = self;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(appDelegate.posteazaAnonim)
    {
        [self.switchControl setOn:NO];
    }
    else
    {
        [self.switchControl setOn:YES];
    }
        
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem* newMessage = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStyleBordered target:self action:@selector(logOut:)];
                                   

    self.navigationItem.rightBarButtonItem = newMessage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logOut:(id) sender
{
    AppDelegate* appdegate = (AppDelegate*)[[UIApplication sharedApplication]delegate]; //pentru a apela o functie din app delegate
    [appdegate logOutSession];
}

- (IBAction)saveButtonPushed:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    idUser = appDelegate.idUser;
    if ([self.switchControl isOn]) {
        [defaults setBool:NO forKey:@"posteazaAnonim"];
        appDelegate.posteazaAnonim = NO;
    }
    else
    {
        appDelegate.posteazaAnonim = YES;
        [defaults setBool:YES forKey:@"posteazaAnonim"];
    }
    if(![self.oldPassField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""])
    {
        [httpRequests getUserWithID:idUser success:^(id data) {
            email = [data objectForKey:@"email"];
            oldPassword = [data objectForKey:@"password"];
            newPassword = self.passwordTextField.text;
            name = [data objectForKey:@"name"];
            if ([self.oldPassField.text isEqualToString:oldPassword]) {
                NSLog(@"A intrat in schimbare parola");
                [httpRequests updateUserwithUserID:idUser Username:name password:newPassword email:email
                                           success:^(id data)
                 {
                     NSLog(@"Userul a fost actualiza");
                     self.oldPassField.text = @"";
                     self.passwordTextField.text = @"";
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Updated" message:@"You have succesfully updated your password!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                     [alert show];
                     
                 }
                                             error:^(AFHTTPRequestOperation *operation, NSError *error)
                 {
                     NSLog(@"A aparut eroare: %@", [error description]);
                 }];
            }
            else{
                NSLog(@"altceva");
            }
            
        } error:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"A avut loc o eroare: %@", [error description]);
        }];
        
    }
    }

- (IBAction)dismissKeyboard:(id)sender {
    [self.oldPassField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationBeginsFromCurrentState:YES];
    CGRect frame = self.view.frame;
    frame.origin.y = -125;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationBeginsFromCurrentState:YES];
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    
}



@end
