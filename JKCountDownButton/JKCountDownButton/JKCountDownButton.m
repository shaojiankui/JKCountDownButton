//
//  JKCountDownButton.m
//  JKCountDownButton
//
//  Created by Jakey on 15/3/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "JKCountDownButton.h"
@interface NSTimer (JKCountDownBlocksSupport)
+ (NSTimer *)jkcd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                           block:(void(^)(void))block
                                         repeats:(BOOL)repeats;
@end


@interface JKCountDownButton(){
    NSInteger _second;
    NSUInteger _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    CountDownChanging _countDownChanging;
    CountDownFinished _countDownFinished;
    TouchedCountDownButtonHandler _touchedCountDownButtonHandler;
}
@end

@implementation JKCountDownButton
#pragma -mark touche action
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler{
    _touchedCountDownButtonHandler = [touchedCountDownButtonHandler copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touched:(JKCountDownButton*)sender{
    if (_touchedCountDownButtonHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _touchedCountDownButtonHandler(sender,sender.tag);
        });
    }
}

#pragma -mark count down method
- (void)startCountDownWithSecond:(NSUInteger)totalSecond
{
    _totalSecond = totalSecond;
    _second = totalSecond;
   
    
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer jkcd_scheduledTimerWithTimeInterval:1.0 block:^{
         typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf timerStart];
    } repeats:YES];
    
    _startDate = [NSDate date];
    _timer.fireDate = [NSDate distantPast];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)timerStart {
     double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    
     _second = _totalSecond - (NSInteger)(deltaTime+0.5) ;

    
    if (_second< 0.0)
    {
        [self stopCountDown];
    }
    else
    {
        if (_countDownChanging)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *title = _countDownChanging(self,_second);
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitle:title forState:UIControlStateDisabled];
            });
        }
        else
        {
            NSString *title = [NSString stringWithFormat:@"%zd秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];

        }
    }
}

- (void)stopCountDown{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _second = _totalSecond;
                if (_countDownFinished)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *title = _countDownFinished(self,_totalSecond);
                        [self setTitle:title forState:UIControlStateNormal];
                        [self setTitle:title forState:UIControlStateDisabled];
                    });
                }
                else
                {
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];

                }
            }
        }
    }
}
#pragma -mark block
- (void)countDownChanging:(CountDownChanging)countDownChanging{
    _countDownChanging = [countDownChanging copy];
}
- (void)countDownFinished:(CountDownFinished)countDownFinished{
    _countDownFinished = [countDownFinished copy];
}
@end


@implementation NSTimer (JKCountDownBlocksSupport)
+ (NSTimer *)jkcd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                           block:(void(^)(void))block
                                         repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(jkcd_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}
+ (void)jkcd_blockInvoke:(NSTimer *)timer {
    void (^block)(void) = timer.userInfo;
    if(block) {
        block();
    }
}
@end
