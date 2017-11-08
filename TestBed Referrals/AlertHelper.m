//
//  IMAlertHelper.m
//  Imago
//
//  Created by Parth Kalavadia on 9/28/17.
//  Copyright © 2017 Parth Kalavadia. All rights reserved.
//

#import "AlertHelper.h"

@implementation AlertHelper

+ (void)showAlertMessageWithTitle:(NSString *)title withMessage:(NSString *)message fromViewController:(UIViewController *)viewController {
    
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:title
                                                                  message:message
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* dismiss = [UIAlertAction actionWithTitle:@"Dismiss"
                                                      style:UIAlertActionStyleDefault
                                                    handler:nil];
    [alert addAction:dismiss];
    
    [viewController presentViewController:alert animated:YES completion:nil];
}

@end
