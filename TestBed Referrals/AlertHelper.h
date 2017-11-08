//
//  IMAlertHelper.h
//  Imago
//
//  Created by Parth Kalavadia on 9/28/17.
//  Copyright © 2017 Parth Kalavadia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AlertHelper: NSObject

+ (void)showAlertMessageWithTitle:(NSString *)Title withMessage:(NSString *)message fromViewController:(UIViewController *)viewController;

@end
