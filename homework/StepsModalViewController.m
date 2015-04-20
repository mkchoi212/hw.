//
//  StepsModalViewController.m
//  homework
//
//  Created by Mike Choi on 4/6/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#import "StepsModalViewController.h"

@interface StepsModalViewController ()

@end

@implementation StepsModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSArray *)stepViewControllers {
    UIViewController *firstStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep"];
    firstStep.step.title = @"Description";
    
    UIViewController *secondStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep2"];
    secondStep.step.title = @"Category";
    
    UIViewController *thirdStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep3"];
    thirdStep.step.title = @"Due Date";
    
    UIViewController *fourthStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep4"];
    fourthStep.step.title = @"Reminder";
    
    return @[firstStep, secondStep, thirdStep, fourthStep];
}

- (void)finishedAllSteps {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)canceled {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
