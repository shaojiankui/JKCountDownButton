//
//  JKCountDownButton.h
//  JKCountDownButton
//
//  Created by Jakey on 15/3/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKCountDownButton;
typedef NSString* (^CountDownChanging)(JKCountDownButton *countDownButton,NSUInteger second);
typedef NSString* (^CountDownFinished)(JKCountDownButton *countDownButton,NSUInteger second);

typedef void (^TouchedCountDownButtonHandler)(JKCountDownButton *countDownButton,NSInteger tag);

@interface JKCountDownButton : UIButton
{
    NSInteger _second;
    NSUInteger _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    CountDownChanging _countDownChanging;
    CountDownFinished _countDownFinished;
    TouchedCountDownButtonHandler _touchedCountDownButtonHandler;
}
@property(nonatomic,strong) id userInfo;

-(void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;
-(void)countDownChanging:(CountDownChanging)countDownChanging;
-(void)countDownFinished:(CountDownFinished)countDownFinished;

-(void)startCountDownWithSecond:(NSUInteger)second;
-(void)stopCountDown;
@end
