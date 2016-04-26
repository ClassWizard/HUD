//
//  EVHUD.h
//  HUD
//
//  Created by ClassWizard on 16/4/26.
//  Copyright © 2016年 ClassWizard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EVHUD : UIView

+ (instancetype)sharedInstance;

- (void)showTo:(UIView *)view;
- (void)showTo:(UIView *)view completion:(void (^)(void))completion;
- (void)showTo:(UIView *)view animated:(BOOL)animated;
- (void)showTo:(UIView *)view animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)showTips:(NSString *)tips toView:(UIView *)view;
- (void)showTips:(NSString *)tips toView:(UIView *)view completion:(void (^)(void))completion;
- (void)showTips:(NSString *)tips toView:(UIView *)view animated:(BOOL)animated;
- (void)showTips:(NSString *)tips toView:(UIView *)view animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)showTips:(NSString *)tips withDuration:(CGFloat)duration toView:(UIView *)view;
- (void)showTips:(NSString *)tips withDuration:(CGFloat)duration toView:(UIView *)view completion:(void (^)(void))completion;
- (void)showTips:(NSString *)tips withDuration:(CGFloat)duration toView:(UIView *)view animated:(BOOL)animated;
- (void)showTips:(NSString *)tips withDuration:(CGFloat)duration toView:(UIView *)view animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)dismiss;

// 样式
@property (nonatomic, strong) UIColor *timerColor;
@property (nonatomic, strong) UIColor *tipsColor;
// 动画样式
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat  lineWidth;

@end
