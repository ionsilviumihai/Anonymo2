//
//  NewMessageViewController.m
//  TestGogu
//
//  Created by Ion Silviu on 4/14/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "NewMessageViewController.h"
#import "httpRequests.h"
#import "AppDelegate.h"
#import "photoViewController.h"
#import "CommentsViewController.h"
#import "Base64.h"
//#import "SBJson.h"


@interface NewMessageViewController ()

@end

@implementation NewMessageViewController

@synthesize messageUITextView, charsLeftButton, coordonataMesaj;

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

    
    [messageUITextView becomeFirstResponder];
    
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    UIBarButtonItem* sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(send:)];
    self.navigationItem.rightBarButtonItem = sendButton;
    [charsLeftButton setEnabled:NO];
    NSLog(@"%f", coordonataMesaj.longitude);
    
//    [httpRequests getPhotoforMessageID:@"26" ssuccess:^(id data) {
//        NSLog(@"Afiseaza: %@", [[data objectAtIndex:0] objectForKey:@"image"]);
//        NSString* ceva = [[data objectAtIndex:0] objectForKey:@"image"];
//        
//        [Base64 initialize];
//        NSData *poz = [Base64 decode:ceva];
//        UIImage *image = [[UIImage alloc] initWithData:poz];
//        [self.imagineEcran setImage:image];
//        self.clipButton.hidden = false;
//        
//    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Eroare!");
//    }];
    
    
    
    //decode
//    [Base64 initialize];
//    NSData *data = [Base64 decode:strEncode];
//    image = [UIImage imageWithData:data];
}

-(void)viewWillAppear:(BOOL)animated
{
//    CGImageRef cgref = (__bridge CGImageRef)([[self.imagineEcran image] CIImage]);
//    CIImage *cim = [[self.imagineEcran image] CIImage];
    
//    if(cim == nil && cgref == NULL)
//    {
//        self.clipButton.hidden = YES;
//    }
//    else
//    {
//        self.clipButton.hidden = NO;
//    }
    if([self.imagineEcran image] == nil)
    {
        self.clipButton.hidden = YES;
    }
    else
    {
        self.clipButton.hidden = NO;
    }
}

-(void)textViewDidChange:(UITextView *)textView {
    int maxChars = 150;
    int charsLeft = maxChars - [textView.text length];
    [charsLeftButton setTitle:[NSString stringWithFormat:@"%d", charsLeft] forState:UIControlStateNormal];
    if(charsLeft == 0)
    {
        charsLeftButton.backgroundColor = [UIColor redColor];
    }
    else
        charsLeftButton.backgroundColor = [UIColor whiteColor];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSUInteger oldLength = [textView.text length];
    NSUInteger replacementLength = [text length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [text rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= 150 || returnKey;
    
    /*
    if ([textField.text length] > MAXLENGTH) {
        textField.text = [textField.text substringToIndex:MAXLENGTH-1];
        return NO;
    }
    return YES;
    */
}


-(void)send:(id) sender{
    NSString* mesaj = messageUITextView.text;
    NSLog(@"%@",mesaj);
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *UserID;
    if (appDelegate.posteazaAnonim) {
        UserID = @"47";
    }
    else
    {
        UserID = appDelegate.idUser;
    }
    //NSNumber *UserID = [NSNumber ]
    //NSLog(@"Id-ul cautat este %@", appDelegate.idUser);
    //NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    //[f setNumberStyle:NSNumberFormatterCurrencyStyle];
    //NSNumber *UserID =[f numberFromString:appDelegate.idUser];
    //NSLog(@"Initial este %@", appDelegate.idUser);
    //long user_id = appDelegate.idUser;
    //NSNumber *UserID = [NSNumber numberWithLong: user_id];
    //NSLog(@"Iar apoi se schimba in %ld", user_id);
    NSString *messageText = mesaj;
    NSString *latitude = [[NSString alloc] initWithFormat:@"%f",coordonataMesaj.latitude ];
    NSString *longitiude = [[NSString alloc] initWithFormat:@"%f", coordonataMesaj.longitude];
    double interval = [[NSDate date] timeIntervalSince1970];
    long interv = (long)interval;
    NSNumber *date = [NSNumber numberWithLong:interv];
    NSLog(@"User:%@ messageText:%@ latitude:%@ longitude:%@ interval:%ld",UserID,messageText,latitude,longitiude,interv);
    [httpRequests createMessageWithUserID:UserID
                              messageText:messageText
                                 latitude:latitude  
                                longitude:longitiude
                                     date:date
                                  success:^(id data)
     {
         NSLog(@"S-a creat un mesaj nou");
         if ([self.imagineEcran image] != nil)
         {
             NSString *idMesaj = [data objectForKey:@"id"];
             NSLog(@"IDUL MESAJULUI CREAT ESTE: %@", idMesaj);
             NSData* poz = UIImageJPEGRepresentation([self.imagineEcran image], 1.0f);
             
             [Base64 initialize];
             NSString* strEncode = [Base64 encode:poz];
             [httpRequests storePhotoForMessageID:idMesaj photo:strEncode success:^(id data) {
                 NSLog(@"S-a creat");
             } error:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Eroare: %@", [error description]);
             }];
         }
         [self dismissViewControllerAnimated:YES completion:nil];
     }
                                    error:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"A avut loc o eroare!");
         
     }];
}

-(void) cancel:(id) sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveCoordinates: (CLLocationCoordinate2D) coordonata {
    NSLog(@"A intrat");
}

- (IBAction)buttonTakeAPhoto:(id)sender {
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Select source:" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera", @"Photo Library", nil];
    [alerta show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        return;
    }
    UIImagePickerController* camera =[[UIImagePickerController alloc]init];
    if(buttonIndex == 1)
    {
        [camera setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else{
        [camera setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [camera setDelegate:self];
    
    [self presentViewController:camera animated:NO completion:^{}];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [self.imagineEcran setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
}



- (IBAction)clipButtonPressed:(id)sender {
    photoViewController *pVC = [[photoViewController alloc] initWithNibName:@"photoViewController" bundle:nil];
    pVC.poza = [self.imagineEcran image];

    //[self.navigationController pushViewController:pVC animated:YES];
    
    [self presentViewController:pVC animated:YES completion:nil];
   //CommentsViewController *vc = [[CommentsViewController alloc] initWithNibName:@"CommentsViewController" bundle:nil];
    //[self presentViewController:vc animated:YES completion:nil];

}
@end
