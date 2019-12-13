//
//  MBProgressHUD.h
//  ZJSLReplayScreen
//
//  Created by 朱大安 on 2019/12/13.
//  Copyright © 2019 zhu.daan. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Message)
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;
@end
