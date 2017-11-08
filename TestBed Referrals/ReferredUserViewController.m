//
//  ReferredUserViewController.m
//  TestBed Referrals
//
//  Created by Parth Kalavadia on 10/24/17.
//  Copyright © 2017 Parth Kalavadia. All rights reserved.
//

#import "ReferredUserViewController.h"
#import "AlertHelper.h"
#import "Branch.h"

@interface ReferredUserViewController ()
@property (weak, nonatomic) IBOutlet UITextField *customEventTF;
@property (weak, nonatomic) IBOutlet UILabel *creditBalanceTF;
@property (weak, nonatomic) IBOutlet UITextField *redeemCreditTF;
@property (weak, nonatomic) IBOutlet UILabel *creditBalanceLbl;

@end

@implementation ReferredUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setHidesBackButton:YES];
    
    [self checkCreditBalance];
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
- (IBAction)dissmissKeyboard:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (IBAction)triggerCustomEvent:(UIButton *)sender {
    
    if (self.customEventTF.text.length != 0) {
        Branch *branch = [Branch getInstance];
        [branch userCompletedAction:self.customEventTF.text];
        [branch userCompletedAction:self.customEventTF.text withState:nil withDelegate:self];
        
    }
    else {
        [AlertHelper showAlertMessageWithTitle:@"Custom event error" withMessage:@"Please enter custom event name" fromViewController:self];
    }
}

-(void)checkCreditBalance {
    //This function would fetch the latest rewards 
    [[Branch getInstance] loadRewardsWithCallback:^(BOOL changed, NSError *error) {
        if (!error) {
            self.creditBalanceLbl.text = [NSString stringWithFormat:@"Credit balance: %ld",[[Branch getInstance] getCredits]];
        }
    }];
}

- (IBAction)checkBalanceBtnPressed:(UIButton *)sender {
    [self checkCreditBalance];
}

- (IBAction)redeemCreditPressed:(UIButton *)sender {
    [[Branch getInstance] redeemRewards:[self.redeemCreditTF.text integerValue] callback:^(BOOL success, NSError *error) {
        if (success) {
            [AlertHelper showAlertMessageWithTitle:@"Redeem Rewards" withMessage:@"Credits sucessfully redeemed" fromViewController:self];
            [self checkCreditBalance];
        }
        else {
            [AlertHelper showAlertMessageWithTitle:@"Redeem Rewards error" withMessage:error.localizedDescription fromViewController:self];
        }
    }];
}
@end
