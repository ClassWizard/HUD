//
//  EVHUD.m
//  HUD
//
//  Created by ClassWizard on 16/4/26.
//  Copyright © 2016年 ClassWizard. All rights reserved.
//

#import "EVHUD.h"
#import "MMMaterialDesignSpinner.h"

static CGFloat contentWidth   = 190;
static CGFloat contentHeight  = 160;
static CGFloat animationWidth = 44;

@interface EVHUD ()
typedef NS_ENUM(NSUInteger, HUDStyle) {
    HUDStyleSimple = 0,
    HUDStyleTips,
    HUDStyleTipsWithTimer
};

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) MMMaterialDesignSpinner *animationView;
@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) void (^completionBlock)(void);
@property (nonatomic, assign) BOOL lock;
@property (nonatomic, assign) NSInteger timeCount;

@end

@implementation EVHUD

@synthesize timeCount;

static EVHUD *_hub = nil;

+ (EVHUD *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _hub = [[super allocWithZone:NULL] init];
        [_hub setupUI];
    });
    return _hub;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [EVHUD sharedInstance];
}

- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return [EVHUD sharedInstance];
}

#pragma mark - UI
/**
 *  建立UI
 *
 *  1. 背景模板,点击交互事件
 *  2. 中间显示区域
 *  |----2.1 动画区域
 *  |----2.2 倒计时区域
 *  |----2.3 文本区域
 */
- (void)setupUI {
    // 1. 背景模板
    self.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.6];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundTapGesture:)];
    [self addGestureRecognizer:tapGesture];

    // 2. 中间显示区域
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentWidth, contentHeight)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.clipsToBounds = YES;
    self.contentView.layer.cornerRadius = 8;
    [self addSubview:self.contentView];
    
    // 2.1 动画区域
    self.animationView = [[MMMaterialDesignSpinner alloc] initWithFrame:CGRectMake((contentWidth - animationWidth) / 2, 30, animationWidth, animationWidth)];

    [self.contentView addSubview:self.animationView];
    
    // 2.2 倒计时区域
    self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 95, contentWidth, 15)];
    self.timerLabel.font = [UIFont systemFontOfSize:12];
    self.timerLabel.textAlignment = NSTextAlignmentCenter;
    self.timerColor = [UIColor blueColor];
    [self.contentView addSubview:self.timerLabel];
    
    // 2.3 文本区域
    self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, contentWidth, 15)];
    self.tipsLabel.font = [UIFont systemFontOfSize:14];
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.tipsLabel];
}

#pragma mark - Actions
- (void)handleBackgroundTapGesture:(UIPanGestureRecognizer *)gesture {
    NSLog(@"点击了背景");
    if (!self.lock) {
        [self dismiss];
    }
}

- (void)handleTimer:(NSTimer *)sender {
    timeCount -= 1;
    [self.timerLabel setText:[NSString stringWithFormat:@"%@ 秒", @(timeCount)]];
    if (timeCount == 0) {
        [self.timer invalidate];
        self.timer = nil;
        [self dismiss];
    }
}

#pragma mark -

- (void)showTo:(UIView *)view {
    [self showTips:nil withDuration:0 toView:view animated:YES completion:nil];
}

- (void)showTo:(UIView *)view completion:(void (^)(void))completion {
    [self showTips:nil withDuration:0 toView:view animated:YES completion:completion];
}

- (void)showTo:(UIView *)view animated:(BOOL)animated {
    [self showTips:nil withDuration:0 toView:view animated:animated completion:nil];
}

- (void)showTo:(UIView *)view animated:(BOOL)animated completion:(void (^)(void))completion {
    [self showTips:nil withDuration:0 toView:view animated:animated completion:completion];
}

- (void)showTips:(NSString *)tips toView:(UIView *)view {
    [self showTips:tips withDuration:0 toView:view animated:YES completion:nil];
}

- (void)showTips:(NSString *)tips toView:(UIView *)view completion:(void (^)(void))completion {
    [self showTips:tips withDuration:0 toView:view animated:YES completion:completion];
}

- (void)showTips:(NSString *)tips toView:(UIView *)view animated:(BOOL)animated {
    [self showTips:tips withDuration:0 toView:view animated:animated completion:nil];
}

- (void)showTips:(NSString *)tips toView:(UIView *)view animated:(BOOL)animated completion:(void (^)(void))completion {
    [self showTips:tips withDuration:0 toView:view animated:animated completion:completion];
}

- (void)showTips:(NSString *)tips withDuration:(CGFloat)duration toView:(UIView *)view {
    [self showTips:tips withDuration:duration toView:view animated:YES completion:nil];
}

- (void)showTips:(NSString *)tips withDuration:(CGFloat)duration toView:(UIView *)view completion:(void (^)(void))completion {
    [self showTips:tips withDuration:duration toView:view animated:YES completion:completion];
}

- (void)showTips:(NSString *)tips withDuration:(CGFloat)duration toView:(UIView *)view animated:(BOOL)animated {
    [self showTips:tips withDuration:duration toView:view animated:animated completion:nil];
}

- (void)showTips:(NSString *)tips withDuration:(CGFloat)duration toView:(UIView *)view animated:(BOOL)animated completion:(void (^)(void))completion {
    //0.block
    self.completionBlock = completion;
    
    //1.config view
    [view addSubview:self];
    self.frame = view.bounds;
    self.contentView.center = self.center;
    
    switch ([self styleWithTips:tips duration:duration]) {
        case HUDStyleSimple: {
            self.timerLabel.hidden = YES;
            self.tipsLabel.hidden  = YES;
            self.lock = NO;
        }
            break;
        case HUDStyleTips: {
            self.timerLabel.hidden = YES;
            self.tipsLabel.hidden  = NO;
            self.lock = NO;
            
            self.tipsLabel.text = tips;
        }
            break;
        case HUDStyleTipsWithTimer: {
            self.timerLabel.hidden = NO;
            self.tipsLabel.hidden  = NO;
            self.lock = YES;
            
            self.tipsLabel.text = tips;
            
            timeCount = duration;
            self.timerLabel.text = [NSString stringWithFormat:@"%@ 秒",@(duration)];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
        }
            break;
    }
    
    //2.animate show
    if (animated) {
        self.alpha = 0;
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
        }];
    }
    
    [self.animationView startAnimating];
}

- (void)dismiss {
    [self.animationView stopAnimating];
    [self removeFromSuperview];
    if (self.completionBlock) {
        self.completionBlock();
        self.completionBlock = nil;
    }
}

#pragma mark - custom methods
- (HUDStyle)styleWithTips:(NSString *)tips duration:(CGFloat)duration {
    if (duration > 0) {
        return HUDStyleTipsWithTimer;
    }
    else if (tips.length > 0) {
        return HUDStyleTips;
    }
    else {
        return HUDStyleSimple;
    }
}

#pragma mark - set
- (void)setTimerColor:(UIColor *)timerColor {
    _timerColor = timerColor;
    self.timerLabel.textColor = timerColor;
}

- (void)setTipsColor:(UIColor *)tipsColor {
    _tipsColor = tipsColor;
    self.tipsLabel.textColor = tipsColor;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    self.animationView.tintColor = lineColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    if (lineWidth <= 0) {
        _lineWidth = 0.1f;
        self.animationView.lineWidth = 0.1f;
    }
    _lineWidth = lineWidth;
    self.animationView.lineWidth = lineWidth;
}
@end
