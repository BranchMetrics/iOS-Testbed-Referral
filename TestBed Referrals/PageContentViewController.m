//
//  PageContentViewController.m
//  TestBed Referrals
//
//  Created by Parth Kalavadia on 10/31/17.
//  Copyright © 2017 Parth Kalavadia. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()


@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ++self.viewTag;

    for (UIView *view in self.view.subviews) {
        view.hidden = view.tag==self.viewTag?NO:YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
