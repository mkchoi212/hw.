//
//  StepsViewController.m
//  homework
//
//  Created by Mike Choi on 4/6/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#define kBackMargin 10
#define kBackButtonSize 40
#define kOFFSET_FOR_KEYBOARD 80.0
#import "StepsViewController.h"
#import "RMStepsController.h"
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
#import <TOMSMorphingLabel/TOMSMorphingLabel.h>
#import "Categories.h"

@interface StepsViewController ()
@property (weak, nonatomic) IBOutlet TOMSMorphingLabel *pageOne;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *daTitle;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextView *daDetail;
@property (nonatomic, assign) NSInteger idx;
@property (nonatomic, strong) NSArray *textValues;
@property (nonatomic, weak) UIButton *backButton;
@property (nonatomic, weak) UIButton *forwardButton;


@end

@implementation StepsViewController

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

    self.daTitle.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"title", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.daTitle.placeholderYPadding = 4.0f;
    self.daTitle.floatingLabelFont = [UIFont systemFontOfSize:13.0f];
    self.daTitle.floatingLabelActiveTextColor = [UIColor orangeColor];
    
    self.daDetail.placeholder = NSLocalizedString(@"description", @"");
    self.daDetail.placeholderYPadding = 4.0f;
    self.daDetail.floatingLabelFont = [UIFont systemFontOfSize:13.0f];
    self.daDetail.floatingLabelActiveTextColor = [UIColor orangeColor];

}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(JVFloatLabeledTextView *)sender
{
    if ([sender isEqual:self.daDetail])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    }
    return NO;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}
#pragma mark - toggling text

- (NSArray *)textValues
{
    if (!_textValues) {
        _textValues = @[
                        @"Description of the task?",
                        @"What do you",
                        @"have to do?",
                        @"We recommend simple,",
                        @"concise notes"
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
    self.pageOne.text = self.textValues[self.idx++];
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
