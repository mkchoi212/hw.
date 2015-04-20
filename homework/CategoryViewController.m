//
//  CategoryViewController.m
//  homework
//
//  Created by Mike Choi on 4/7/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//
#define kBackMargin 10
#define kBackButtonSize 40

#import "CategoryViewController.h"
#import "AKPickerView.h"
#import "Categories.h"
#import "ZFModalTransitionAnimator.h"
#import "ColorsTableViewController.h"

@interface CategoryViewController () <AKPickerViewDataSource, AKPickerViewDelegate>
@property (weak, nonatomic) IBOutlet TOMSMorphingLabel *pageTwo;
@property (nonatomic, assign) NSInteger idx;
@property (nonatomic, strong) NSArray *textValues;
@property (nonatomic, strong) AKPickerView *pickerView;
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *forwardButton;

@property (nonatomic, strong) ZFModalTransitionAnimator *animator;

@end

@implementation CategoryViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    _idx = 0;
    [self toggleText];
    [self setupTextView];
}

- (void)setupTextView
{
    self.backButton = [SlowHighlightIcon buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(kBackMargin, self.view.bounds.size.height-kBackButtonSize-kBackMargin, kBackButtonSize, kBackButtonSize);
    self.backButton.autoresizingMask = (UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin);
    [self.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"back_high"] forState:UIControlStateHighlighted];
    [self.backButton addTarget:self action:@selector(previousStepTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    self.forwardButton = [SlowHighlightIcon buttonWithType:UIButtonTypeCustom];
    self.forwardButton.frame = CGRectMake(self.view.bounds.size.width-kBackMargin-kBackButtonSize, self.view.bounds.size.height-kBackButtonSize-kBackMargin, kBackButtonSize, kBackButtonSize);
    self.forwardButton.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin);
    [self.forwardButton setImage:[UIImage imageNamed:@"forward"] forState:UIControlStateNormal];
    [self.forwardButton setImage:[UIImage imageNamed:@"forward_high"] forState:UIControlStateHighlighted];
    [self.forwardButton addTarget:self action:@selector(nextStepTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forwardButton];

    self.pickerView = [[AKPickerView alloc] initWithFrame:self.view.bounds];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:self.pickerView aboveSubview:self.pageTwo];

    self.pickerView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    self.pickerView.highlightedFont = [UIFont fontWithName:@"HelveticaNeue" size:20];
    self.pickerView.interitemSpacing = 20.0;
    self.pickerView.fisheyeFactor = 0.001;
    self.pickerView.pickerViewStyle = AKPickerViewStyle3D;
    self.pickerView.maskDisabled = false;

    self.titles = @[@"Tokyo",
                    @"Kanagawa",
                    @"Osaka",
                    @"Aichi",
                    @"Saitama",
                    @"Chiba",
                    @"Hyogo",
                    @"Hokkaido",
                    @"Fukuoka",
                    @"Add Category"];

    [self.pickerView reloadData];
}

#pragma mark - AKPickerViewDataSource

- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView
{
    self.pickerView.textColor = [UIColor orangeColor];
    return [self.titles count];
}


- (NSArray *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item
{
    return self.titles[item];
}


/*
 - (UIImage *)pickerView:(AKPickerView *)pickerView imageForItem:(NSInteger)item
 {
	return [UIImage imageNamed:self.titles[item]];
 }
 */

#pragma mark - AKPickerViewDelegate

- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item
{
    //add new category
    if(item == self.titles.count-1){
        ColorsTableViewController *modalVC = [self.storyboard instantiateViewControllerWithIdentifier:@"colors"];
        modalVC.modalPresentationStyle = UIModalPresentationCustom;
        
        self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:modalVC];
        self.animator.dragable = YES;
        self.animator.bounces = YES;
        self.animator.behindViewAlpha = 0.5f;
        self.animator.transitionDuration = 0.7f;
        
        self.animator.direction = ZFModalTransitonDirectionBottom;
        [self.animator setContentScrollView:modalVC.tableView];
        self.animator.behindViewScale = 0.8;
        modalVC.transitioningDelegate = self.animator;
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self presentViewController:modalVC animated:YES completion:nil];
        });
    }
}


#pragma mark - toggling text

- (NSArray *)textValues
{
    if (!_textValues) {
        _textValues = @[
                        @"Category of the task?",
                        @"What kind of work",
                        @"is it?",
                        @"Subject?"
                        ];
    }
    return _textValues;
}

- (void)setIdx:(NSInteger)idx
{
    _idx = MAX(0, MIN(idx, idx % [self.textValues count]));
}

- (void)toggleText
{
    self.pageTwo.text = self.textValues[self.idx++];
    [self performSelector:@selector(toggleText)
               withObject:nil
               afterDelay:2];
}

- (IBAction)nextStepTapped:(id)sender {
    [self.stepsController showNextStep];
}

- (IBAction)previousStepTapped:(id)sender {
    [self.stepsController showPreviousStep];
}


@end
