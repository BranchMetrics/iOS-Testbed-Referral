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

@end

@implementation SetIdentityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *info;
    if (self.isReferrer) {
        info = @"Why do we need to set Identifier for referred user?\n\n-Identifier would help uniquely identify the user who creates the and shares the referral link. \n\nIt could be an email, phone number, username etc which would uniquely identify this referrer user.\n\nIf you don't set an Identifier, you would get anonymous as the user on Dashboard";
    }
    else {
        info = [NSString stringWithFormat:@"You have been successfully deep linked.\n\nBefore we go ahead and redeem the credits, we need to set unique identifier which could be an email id, phone number, UUID etc.\n\nThis identifier would uniquely identify the referred user"];
    }
    self.infoTextField.text = info;
    [self setViewBasedOnReferrer];
    self.userIdTF.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)resignKeyboard:(UITapGestureRecognizer *)sender {
    
    [self.userIdTF resignFirstResponder];
}

-(void)setViewBasedOnReferrer {
    
    if (self.isReferrer) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self.userIdBtn setBackgroundColor:[UIColor lightGrayColor]];
    }

}

- (IBAction)setUserBtnPressed:(UIButton *)sender {
    
    if (self.userIdTF.text.length == 0) {
        [AlertHelper showAlertMessageWithTitle:@"User Id error" withMessage:@"User id field cannot be empty" fromViewController:self];
    }
    else {
        [[Branch getInstance] setIdentity:self.userIdTF.text withCallback:^(NSDictionary * _Nullable params, NSError * _Nullable error) {
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

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}

@synthesize deepLinkingCompletionDelegate;

- (void)configureControlWithData:(NSDictionary *)data {
    self.isReferrer = NO;
}

@end
