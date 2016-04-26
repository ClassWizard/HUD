//
//  ViewController.m
//  HUD
//
//  Created by ClassWizard on 16/4/26.
//  Copyright © 2016年 ClassWizard. All rights reserved.
//

#import "ViewController.h"
#import "EVHUD.h"

@interface ViewController ()

@property (nonatomic, strong) EVHUD *hub;
@property (weak, nonatomic) IBOutlet UIView *subView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hub = [EVHUD sharedInstance];
    self.hub.timerColor = [UIColor colorWithRed:18/255. green:152/255. blue:233/255. alpha:1];
    self.hub.lineColor = [UIColor colorWithRed:18/255. green:152/255. blue:233/255. alpha:1];
    self.hub.lineWidth = 4;
}

- (IBAction)showHUD:(UIButton *)sender {
//    [self.hub showTips:@"正在结束充电..." withDuration:10 toView:self.view animated:YES completion:^{
//        NSLog(@"ssss");
//    }];
    
//    [self.hub showTips:@"正在结束..." toView:self.view completion:^{
//        NSLog(@"dddd");
//    }];
    
    [self.hub showTo:self.subView completion:^{
        NSLog(@"ffff");
    }];
}

@end
