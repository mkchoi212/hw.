//
//  TimeViewController.h
//  homework
//
//  Created by Mike Choi on 4/7/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMStepsController.h"
#import "THDatePickerViewController.h"

@interface TimeViewController : UIViewController <THDatePickerDelegate>

@property (nonatomic, strong) THDatePickerViewController * datePicker;

@end
