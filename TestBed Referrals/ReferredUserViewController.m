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

@property (weak, nonatomic) IBOutlet UITextField *redeemCreditTF;
@property (weak, nonatomic) IBOutlet UILabel *creditBalanceLbl;
@property (strong, nonatomic) IBOutlet UIButton *checkBalanceBtn;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *balanceCheckIndicator;
@property (strong, nonatomic) IBOutlet UIButton *redeemBtn;
@property (strong, nonatomic) IBOutlet UIButton *referralHistoryBtn;

@end

@implementation ReferredUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redeemBtn.layer.cornerRadius = 5;
    self.redeemBtn.clipsToBounds = YES;
    
    self.referralHistoryBtn.layer.cornerRadius = 5;
    self.referralHistoryBtn.layer.borderColor = [[UIColor colorWithRed:0.0 green:115/257.0 blue:204/257.0 alpha:1] CGColor];
    self.referralHistoryBtn.layer.borderWidth = 1.0f;
    self.referralHistoryBtn.clipsToBounds = YES;
    
    [self checkCreditBalance:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)checkCreditBalance: (UIButton *)sender {
    //This function would fetch the latest rewards
    [self.balanceCheckIndicator startAnimating];
    self.checkBalanceBtn.hidden = YES;
    [[Branch getInstance] loadRewardsWithCallback:^(BOOL changed, NSError *error) {
        [self.balanceCheckIndicator stopAnimating];
        self.checkBalanceBtn.hidden = NO;
        if (!error) {
            self.creditBalanceLbl.text = [NSString stringWithFormat:@"%ld",[[Branch getInstance] getCredits]];
        }
    }];
}

- (IBAction)redeemCreditPressed:(UIButton *)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    [[Branch getInstance] redeemRewards:[self.redeemCreditTF.text integerValue] callback:^(BOOL success, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (success) {
            [AlertHelper showAlertMessageWithTitle:@"Redeem Rewards" withMessage:@"Credits sucessfully redeemed" fromViewController:self];
            [self checkCreditBalance:nil];
        }
        else {
            [AlertHelper showAlertMessageWithTitle:@"Redeem Rewards error" withMessage:error.localizedDescription fromViewController:self];
        }
    }];
}

- (IBAction)resignKeyboard:(UITapGestureRecognizer *)sender {
    
    [self.redeemCreditTF resignFirstResponder];
}
@end
