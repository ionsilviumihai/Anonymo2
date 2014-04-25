//
//  SettingsViewController.h
//  TestGogu
//
//  Created by Ion Silviu on 4/17/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UITextFieldDelegate>
- (IBAction)saveButtonPushed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *oldPassField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UISwitch *switchControl;


- (IBAction)dismissKeyboard:(id)sender;

@end
