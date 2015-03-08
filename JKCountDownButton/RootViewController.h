//
//  RootViewController.h
//  JKCountDownButton
//
//  Created by Jakey on 15/3/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKCountDownButton.h"
@interface RootViewController : UIViewController
{
    JKCountDownButton *_countDownCode;
}
//xib 方式
@property (weak, nonatomic) IBOutlet JKCountDownButton *countDownXib;
- (IBAction)countDownXibTouched:(JKCountDownButton*)sender;
- (IBAction)countDownXibStop:(id)sender;

@end
