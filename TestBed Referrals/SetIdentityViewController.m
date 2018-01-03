//
//  SetIdentityViewController.m
//  TestBed Referrals
//
//  Created by Parth Kalavadia on 10/24/17.
//  Copyright © 2017 Parth Kalavadia. All rights reserved.
//

#import "SetIdentityViewController.h"
#import "Branch.h"
#import "AlertHelper.h"
@interface SetIdentityViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userIdTF;
@property (weak, nonatomic) IBOutlet UIButton *userIdBtn;
@property (weak, nonatomic) IBOutlet UITextView *infoTextField;
@property (strong, nonatomic) IBOutlet UIView *deepLinkBanner;
@property (strong, nonatomic) IBOutlet UIImageView *guideBannerImageView;

@end

@implementation SetIdentityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.isReferrer) {
        self.deepLinkBanner.hidden = YES;
    }
    else {
        self.deepLinkBanner.hidden = NO;
        self.infoTextField.text = [NSString stringWithFormat:@"Before we go ahead and redeem the credits, we need to set unique identifier which could be an email id, phone number, UUID etc.\n\nThis identifier would uniquely identify the referred user."];
        self.guideBannerImageView.image = [UIImage imageNamed:@"setId_referred"];
    }
    self.userIdBtn.layer.cornerRadius = 5;
    self.userIdBtn.clipsToBounds = YES;
    self.userIdTF.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resignKeyboard:(UITapGestureRecognizer *)sender {
    
    [self.userIdTF resignFirstResponder];
}

- (IBAction)setUserBtnPressed:(UIButton *)sender {
    
    if (self.userIdTF.text.length == 0) {
        [AlertHelper showAlertMessageWithTitle:@"User Id error" withMessage:@"User id field cannot be empty" fromViewController:self];
    }
    else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [[Branch getInstance] setIdentity:self.userIdTF.text withCallback:^(NSDictionary * _Nullable params, NSError * _Nullable error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (!error) {
                if (self.isReferrer) {
                    [self performSegueWithIdentifier:@"shareLinkSegue" sender:self];
                }
                else {
                    [self performSegueWithIdentifier:@"referrerUserSegue" sender:self];
                }
            }
            else {
                //Alert Couldn't set identity
                [AlertHelper showAlertMessageWithTitle:@"Couldn't set Identifier" withMessage:error.localizedDescription fromViewController:self];
            }
                
        }];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return YES;
}

@synthesize deepLinkingCompletionDelegate;

- (void)configureControlWithData:(NSDictionary *)data {
    self.isReferrer = NO;
}

@end
