# JKCountDownButton
JKCountDownButton,子类化UIButton实现IOS倒计时按钮,常常用于注册等发送验证码的时候进行倒计时操作

##代码方式使用
    JKCountDownButton *_countDownCode;
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

    
##xib方式使用
    @property (weak, nonatomic) IBOutlet JKCountDownButton *countDownXib;

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


##效果图
![](https://raw.githubusercontent.com/shaojiankui/JKCountDownButton/master/demo.gif)