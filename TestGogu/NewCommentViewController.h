//
//  NewCommentViewController.h
//  TestGogu
//
//  Created by Ion Silviu on 4/20/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewCommentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *messageUITextView;
@property (weak, nonatomic) IBOutlet UIButton *charsLeftButton;
@property (strong, nonatomic) NSString *idMesaj;

@end
