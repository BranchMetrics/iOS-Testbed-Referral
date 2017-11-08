//
//  SetIdentityViewController.h
//  TestBed Referrals
//
//  Created by Parth Kalavadia on 10/24/17.
//  Copyright © 2017 Parth Kalavadia. All rights reserved.
//

#import "ViewController.h"
#import "Branch.h"

@interface SetIdentityViewController : ViewController <BranchDeepLinkingController>
@property (assign,nonatomic) BOOL isReferrer;
@end
