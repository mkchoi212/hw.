//
//  TimeViewController.m
//  homework
//
//  Created by Mike Choi on 4/7/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#import "ReminderViewController.h"
#import "KPTimePicker.h"
#import "Categories.h"

@interface ReminderViewController () <KPTimePickerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic,strong) KPTimePicker *timePicker;
@property (nonatomic,strong) UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (nonatomic,strong) UIPanGestureRecognizer *panRecognizer;

@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;

@end

@implementation ReminderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]){
        [self setNeedsStatusBarAppearanceUpdate];
    }
    self.view.backgroundColor = color(36,40,46,1);
    
    self.timePicker = [[KPTimePicker alloc] initWithFrame:self.view.bounds];
    self.timePicker.delegate = self;
    self.timePicker.minimumDate = [self.timePicker.pickingDate dateAtStartOfDay];
    self.timePicker.maximumDate = [[[self.timePicker.pickingDate dateByAddingMinutes:(60*24)] dateAtStartOfDay] dateBySubtractingMinutes:5];
    self.timePicker.pickingDate = [NSDate date];
    [self.view insertSubview:self.timePicker belowSubview:self.view];
    
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
    [self.view addGestureRecognizer:self.panRecognizer];
    
    [self.timePicker.dayLabel addTarget:self action:@selector(touchedButton:) forControlEvents:UIControlEventTouchUpInside];
    self.curDate = [NSDate date];
    self.formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"MMM dd,yyyy"];
    [self refreshTitle];
}

-(void)refreshTitle {
    NSString *today = [_formatter stringFromDate:self.curDate];
    NSInteger numberOfDaysAfterTodays = [self.curDate distanceInDaysToDate:[[NSDate date] dateAtStartOfDay]];
    if(numberOfDaysAfterTodays == 0){
        [self.timePicker.dayLabel setTitle:[NSString stringWithFormat:@"Today - %@", today] forState:UIControlStateNormal];
    }
    else{
        [self.timePicker.dayLabel setTitle:today forState:UIControlStateNormal];
    }
}


-(void)timePicker:(KPTimePicker *)timePicker selectedDate:(NSDate *)date{
    if(date == nil)
        [self.stepsController showPreviousStep];
    else
        [self.stepsController showNextStep];
}


- (IBAction)touchedButton:(id)sender {
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    self.datePicker.date = self.curDate;
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setClearAsToday:YES];
    [self.datePicker setAutoCloseOnSelectDate:NO];
    [self.datePicker setAllowSelectionOfSelectedDate:YES];
    [self.datePicker setDisableHistorySelection:YES];
    [self.datePicker setDisableFutureSelection:NO];
    //[self.datePicker setAutoCloseCancelDelay:5.0];
    [self.datePicker setSelectedBackgroundColor:[UIColor blackColor]];
    [self.datePicker setCurrentDateColor:[UIColor redColor]];
    [self.datePicker setCurrentDateColorSelected:[UIColor whiteColor]];
    
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        return (tmp % 5 == 0);
    }];
    //[self.datePicker slideUpInView:self.view withModalColor:[UIColor lightGrayColor]];
    [self presentSemiViewController:self.datePicker withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(1.0),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                  }];
}

- (void)datePickerDonePressed:(THDatePickerViewController *)datePicker {
    self.curDate = datePicker.date;
    [self refreshTitle];
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}

- (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker {
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}

- (void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate {
    NSLog(@"Date selected: %@",[_formatter stringFromDate:selectedDate]);
}



-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if([otherGestureRecognizer isEqual:self.panRecognizer] && !self.timePicker) return NO;
    return YES;
}


-(void)panRecognized:(UIPanGestureRecognizer*)sender{
    if(!self.timePicker) return;
    [self.timePicker forwardGesture:sender];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)dealloc{
    self.timePicker = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
