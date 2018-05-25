//
//  UIViewController+STKeybordAdjust.m
//  HarborCity
//
//  Created by Mac on 2018/5/22.
//  Copyright © 2018年 stoneobs@icloud.com. All rights reserved.
//

#import "UIView+STKeybordAdjust.h"

@implementation UIView (STKeybordAdjust)
- (void)st_autoAdjustAllResponder{
    if (self.frame.size.height != [UIScreen mainScreen].bounds.size.height) {
        NSLog(@"UIView+STKeybordAdjust 不是全屏 不处理适配");
        return;
    }else{
        [self st_addNotifacations];
    }
}
#pragma mark --Notifacation
- (void)st_addNotifacations{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(st_keyboardWillChangeFrameNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(st_keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
- (void)st_keyboardWillChangeFrameNotification:(NSNotification*)notify{
    
    // 动画的持续时间
    NSDictionary *userInfo = notify.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIView * responderView = [self st_findResbonderWithView:self];
    //获取在window 上的位置
    CGRect windowRect = [responderView convertRect:responderView.bounds toView:responderView.window];
    CGFloat bootomWindowRect = windowRect.origin.y + windowRect.size.height;
    //键盘全部弹出的初始位置
    CGFloat maxKebordOrigin = [UIScreen mainScreen].bounds.size.height - keyboardF.size.height;
    CGFloat insetY = bootomWindowRect - maxKebordOrigin;
    
    BOOL isTextView = ([responderView isKindOfClass:[UITextField class]] || [responderView isKindOfClass:[UITextView class]] );
    // insetY 大于0 证明键盘弹出会遮挡这个控件，目前仅仅适配 UITextFiled和UITextView
    if (insetY > 0 && isTextView) {
        [UIView animateWithDuration:duration animations:^{
            CGRect frame = self.frame;
            frame.origin.y = frame.origin.y - insetY;
            self.frame = frame;
            //self.bottom = self.bottom - insetY;
        }];
    }
    
    
    
    
}
//递归寻找当前第一响应者
- (UIView*)st_findResbonderWithView:(UIView*)fatherView{
    if (fatherView.isFirstResponder) {
        return fatherView;
    }
    for (UIView *view  in fatherView.subviews) {
        UIView * findView = [self st_findResbonderWithView:view];
        if (findView) {
            return findView;
        }
    }
    return nil;
}
- (void)st_keyboardWillHideNotification:(NSNotification*)notify{

    // 动画的持续时间
    NSDictionary *userInfo = notify.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 键盘的frame
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.frame;
        frame.origin.y = keyboardF.origin.y - frame.size.height;
        self.frame = frame;
    }];
    
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
