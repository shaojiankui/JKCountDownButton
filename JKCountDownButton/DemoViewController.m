//
//  DemoViewController.m
//  JKCountDownButton
//
//  Created by runlin on 2018/9/19.
//  Copyright © 2018年 www.skyfox.org. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)countDownXibTouched:(JKCountDownButton*)sender {
    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [sender startCountDownWithSecond:20];
    
    [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
        NSLog(@"countDownChanging:%@",title);
        return title;
    }];
    [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"倒计时完成" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        NSLog(@"countDownFinished:倒计时完成");
        return @"点击重新获取";
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
