//
//  ViewController.h
//  TestBed Referrals
//
//  Created by Parth Kalavadia on 10/23/17.
//  Copyright © 2017 Parth Kalavadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
@interface ViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (nonatomic,strong) UIPageViewController *PageViewController;

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index;

@end

