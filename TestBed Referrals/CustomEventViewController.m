//
//  CustomEventViewController.m
//  TestBed Referrals
//
//  Created by Parth Kalavadia on 12/29/17.
//  Copyright © 2017 Parth Kalavadia. All rights reserved.
//

#import "CustomEventViewController.h"
#import "AlertHelper.h"
#import "Branch.h"

@interface CustomEventViewController ()
@property (strong, nonatomic) IBOutlet UITextField *customEventTF;
@property (strong, nonatomic) IBOutlet UIButton *triggerEventBtn;

@end

@implementation CustomEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.triggerEventBtn.layer.cornerRadius = 5;
    self.triggerEventBtn.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)triggerCustomEvent:(UIButton *)sender {

    if (self.customEventTF.text.length != 0) {        
        [[BranchEvent customEventWithName:self.customEventTF.text] logEvent];
        [self performSegueWithIdentifier:@"redeemCreditsSegue" sender:self];
    }
    else {
        [AlertHelper showAlertMessageWithTitle:@"Custom event error" withMessage:@"Please enter custom event name" fromViewController:self];
    }
}

- (IBAction)logout:(UIBarButtonItem *)sender {
    
    Branch *branch = [Branch getInstance];
    
    [branch logoutWithCallback:^(BOOL changed, NSError * _Nullable error) {
        if (changed) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [AlertHelper showAlertMessageWithTitle:@"Logout error" withMessage:error.localizedDescription fromViewController:self];
        }
        
    }];
}

- (IBAction)resignKeyboard:(UITapGestureRecognizer *)sender {
    
    [self.customEventTF resignFirstResponder];
}

@end
