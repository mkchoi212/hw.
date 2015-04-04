//
//  ViewController.h
//  homework
//
//  Created by Mike Choi on 3/11/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FCVerticalMenu/FCVerticalMenu.h>
#import "UIViewController+ScrollingNavbar.h"

@interface ViewController : UIViewController <FCVerticalMenuDelegate>

@property (strong, readonly, nonatomic) FCVerticalMenu *quickMenu;

@end

