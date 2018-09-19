//
//  RootViewController.m
//  JKCountDownButton
//
//  Created by Jakey on 15/3/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "RootViewController.h"
#import "DemoViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self buildCountDown];
    
}
- (void)buildCountDown{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 70, 32)];
    lable.text = @"代码添加";
    lable.textColor = [UIColor whiteColor];
    [self.view addSubview:lable];
    
   
    _countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.frame = CGRectMake(81, 200, 108, 32);
    [_countDownCode setTitle:@"开始" forState:UIControlStateNormal];
    _countDownCode.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_countDownCode];
    
    
    [_countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;

        [sender startCountDownWithSecond:10];

        [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
            return title;
        }];
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"点击重新获取";
            
        }];

    }];
}

- (IBAction)countDownXibTouched:(JKCountDownButton*)sender {
    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [sender startCountDownWithSecond:60];
 
    [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
        return title;
    }];
    [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        return @"点击重新获取";
        
    }];
}

- (IBAction)countDownXibStop:(id)sender {
    [self.countDownXib stopCountDown];
    [_countDownCode stopCountDown];
}
- (IBAction)pushTouched:(id)sender {
    DemoViewController *demo = [[DemoViewController alloc] init];
    [self.navigationController pushViewController:demo animated:YES];
}
@end
