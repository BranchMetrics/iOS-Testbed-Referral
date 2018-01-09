//
//  ShareLinkViewController.m
//  TestBed Referrals
//
//  Created by Parth Kalavadia on 10/24/17.
//  Copyright © 2017 Parth Kalavadia. All rights reserved.
//

#import "ShareLinkViewController.h"
#import "Branch.h"
#import "AlertHelper.h"
@interface ShareLinkViewController ()<BranchShareLinkDelegate>
@property (strong, nonatomic) IBOutlet UIButton *shareLinkBtn;

@end

@implementation ShareLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.shareLinkBtn.layer.cornerRadius = 5;
    self.shareLinkBtn.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)shareLinkBtnPressed:(UIButton *)sender {
    
    BranchUniversalObject* universalObject = [[BranchUniversalObject alloc] initWithTitle:@"Referral Test"];
    universalObject.metadata = @{@"deepLinked text":@"test referrals"};
    BranchLinkProperties* linkProperties   = [[BranchLinkProperties alloc] init];
    [linkProperties setFeature:@"referrals"];
    BranchShareLink* shareLink = [[BranchShareLink alloc] initWithUniversalObject:universalObject linkProperties:linkProperties];
    shareLink.shareText = @"Before testing referrals for referrer users, please follow the following steps:\n1) Uninstall Referral TestBed app\n2) Reset Adevertising Identifier from Setting -> Privacy -> Advertising\n3) Tap on the link below\n4) Run the app from xcode\n";
    [shareLink setDelegate:self];
    [shareLink presentActivityViewControllerFromViewController:self anchor:nil];
}

- (void) branchShareLink:(BranchShareLink*_Nonnull)shareLink
             didComplete:(BOOL)completed
               withError:(NSError*_Nullable)error{
    
    if (!error) {
        if (completed) {
            [self performSegueWithIdentifier:@"shareLinkCompleteSegue" sender:self];
        }
    }
    else {
        [AlertHelper showAlertMessageWithTitle:@"Link share error" withMessage:error.localizedDescription fromViewController:self];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
   
}

@end
