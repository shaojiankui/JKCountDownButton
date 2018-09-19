//
//  DemoViewController.h
//  JKCountDownButton
//
//  Created by runlin on 2018/9/19.
//  Copyright © 2018年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKCountDownButton.h"

@interface DemoViewController : UIViewController
//xib 方式
@property (weak, nonatomic) IBOutlet JKCountDownButton *countDownXib;
- (IBAction)countDownXibTouched:(JKCountDownButton*)sender;
@end
