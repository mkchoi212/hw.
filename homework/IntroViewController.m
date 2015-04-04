//
//  IntroViewController.m
//  homework
//
//  Created by Mike Choi on 3/21/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#import "IntroViewController.h"
#import "SKPanoramaView.h"
#import "FBShimmeringView.h"
#import "RQShineLabel.h"
#import "MainNavigationController.h"

@interface IntroViewController (){
    FBShimmeringView *_shimmeringView;
    UIView *_contentView;
    UILabel *_logoLabel;
}
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
- (IBAction)goHome:(id)sender;
@property (strong, nonatomic) RQShineLabel *shineLabel;
@property (strong, nonatomic) NSArray *textArray;
@property (assign, nonatomic) NSUInteger textIndex;
@end
@implementation IntroViewController

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        _textArray = @[
                       @"Hey, welcome to HW, an app designed to make reminders easier and more intuitive",
                       @"You will be able to create reminders in seconds",
                       @"And unlike other apps, we won't bug you with unnecessary...things",
                       @"Other than that, everything is pretty self-explanatory", @"Have fun!"
                       ];
        _textIndex  = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self panoramaView];
    [self shimmer];

}

- (void)shimmer{
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(0.0f,self.view.bounds.size.height/2-self.view.bounds.size.height/5,self.view.bounds.size.width,self.view.bounds.size.height/4)];
    [self.view addSubview:shimmeringView];
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:shimmeringView.bounds];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = NSLocalizedString(@"hw.", nil);
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.font = [UIFont fontWithName:@"Arial" size:60];
    shimmeringView.contentView = loadingLabel;
    shimmeringView.shimmeringSpeed = 250;
    shimmeringView.shimmering = YES;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [FBShimmeringView beginAnimations:nil context:nil];
        [FBShimmeringView setAnimationDuration:1.0];
        [FBShimmeringView setAnimationTransition:UIViewAnimationTransitionNone forView:[self view] cache:YES];
        [shimmeringView setFrame:CGRectMake(0.0f,10,self.view.bounds.size.width,self.view.bounds.size.height/4)];
        [FBShimmeringView commitAnimations];
        shimmeringView.shimmering = NO;
        [self instructions];
    });
}

#pragma mark THE INSTRUCTIONS
- (void)instructions{
    self.shineLabel = ({
        RQShineLabel *label = [[RQShineLabel alloc] initWithFrame:CGRectMake(16, 16, 320 - 32, CGRectGetHeight(self.view.bounds) - 16)];
        label.numberOfLines = 0;
        label.text = [self.textArray objectAtIndex:self.textIndex];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0];
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        label.center = self.view.center;
        label;
    });
    [self.view addSubview:self.shineLabel];
    [self.shineLabel shine];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (self.shineLabel.isVisible) {
        [self.shineLabel fadeOutWithCompletion:^{
            [self changeText];
            [self.shineLabel shine];
        }];
    }
    else {
        [self.shineLabel shine];
    }
}

- (void)changeText
{
    if(self.textIndex == self.textArray.count-1){
        MainNavigationController *main = [self.storyboard instantiateViewControllerWithIdentifier:@"nav"];
        main.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:main animated:YES completion:nil];

    }
    else
        self.shineLabel.text = self.textArray[++self.textIndex];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)panoramaView
{
    SKPanoramaView *panoramaView = [[SKPanoramaView alloc] initWithFrame:self.view.frame image:[UIImage imageNamed:@"nyc"]];
    panoramaView.animationDuration = 100;
    [self.view addSubview:panoramaView];
    [panoramaView startAnimating];
    UIView *overlayView = [[UIView alloc] initWithFrame:self.view.frame];
    overlayView.backgroundColor = [UIColor blackColor];
    overlayView.alpha = 0.4;
    [panoramaView addSubview:overlayView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goHome:(id)sender {
}
@end
