//
//  StepsNavViewController.m
//  homework
//
//  Created by Mike Choi on 4/6/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#import "StepsNavViewController.h"

@interface StepsNavViewController ()

@end

@implementation StepsNavViewController

#pragma mark - Init and Dealloc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.stepsBar.hideCancelButton = YES;
}

#pragma mark - Actions
- (void)finishedAllSteps {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)canceled {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
