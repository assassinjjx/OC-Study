//
//  ELYTToast.m
//  Cip
//
//  Created by elyt on 14-10-20.
//  Copyright (c) 2014年 elyt. All rights reserved.
//

#import "ELYTToast.h"
#import "WToast.h"

@implementation ELYTToast

+ (WToast *)showWithText:(NSString *)text {
    WToast *toast = [WToast showWithText:text duration:kWTLong];
    return toast;
}

+ (void)showWarnWithText:(NSString *)text {
//    UVILog(@"%@", text);
    [WToast showWithText:text duration:kWTLong];
}

+ (void)showErrorWithText:(NSString *)text {
//    UVILog(@"%@", text);
    [WToast showWithText:text duration:kWTLong];
}

//提示语置于键盘上层
+ (void)showTopWithText:(NSString *)text {
//    UVILog(@"%@", text);
    [WToast showTopWithText:text duration:kWTLong];
}

@end
