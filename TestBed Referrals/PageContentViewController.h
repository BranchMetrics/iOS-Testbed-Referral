//
//  PageContentViewController.h
//  TestBed Referrals
//
//  Created by Parth Kalavadia on 10/31/17.
//  Copyright © 2017 Parth Kalavadia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property  NSUInteger pageIndex;
@property (strong,nonatomic) NSString *imageName;
@property (weak, nonatomic) IBOutlet UIImageView *ivScreenImage;
@end
