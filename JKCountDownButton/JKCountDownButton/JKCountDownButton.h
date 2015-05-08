//
//  JKCountDownButton.h
//  JKCountDownButton
//
//  Created by Jakey on 15/3/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKCountDownButton;
typedef NSString* (^DidChangeBlock)(JKCountDownButton *countDownButton,int second);
typedef NSString* (^DidFinishedBlock)(JKCountDownButton *countDownButton,int second);

typedef void (^TouchedDownBlock)(JKCountDownButton *countDownButton,NSInteger tag);

@interface JKCountDownButton : UIButton
{
    int _second;
    int _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    DidChangeBlock _didChangeBlock;
    DidFinishedBlock _didFinishedBlock;
    TouchedDownBlock _touchedDownBlock;
}
//@property(nonatomic,strong)UIColor *changeFontColor;
//@property(nonatomic,strong)UIColor *normalFontColor;
-(void)addToucheHandler:(TouchedDownBlock)touchHandler;

-(void)didChange:(DidChangeBlock)didChangeBlock;
-(void)didFinished:(DidFinishedBlock)didFinishedBlock;
-(void)startWithSecond:(int)second;
- (void)stop;
@end
