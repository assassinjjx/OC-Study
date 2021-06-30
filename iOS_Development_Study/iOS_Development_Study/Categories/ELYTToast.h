//
//  ELYTToast.h
//  Cip
//
//  Created by elyt on 14-10-20.
//  Copyright (c) 2014年 elyt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WToast;

@interface ELYTToast : NSObject

+ (WToast *)showWithText:(NSString *)text;

+ (void)showWarnWithText:(NSString *)text;

+ (void)showErrorWithText:(NSString *)text;

+ (void)showTopWithText:(NSString *)text;
@end
