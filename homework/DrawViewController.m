//
//  DrawViewController.m
//  homework
//
//  Created by Mike Choi on 3/19/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#import "DrawViewController.h"
#import "SphereMenu.h"

@interface DrawViewController () <SphereMenuDelegate>

@end

@implementation DrawViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [(JCDrawView*)[self view] setPreviousPoint:CGPointZero];
        [(JCDrawView*)[self view] setPrePreviousPoint:CGPointZero];
        [(JCDrawView*)[self view] setLineWidth:2.0];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   self.navigationController.navigationBar.opaque = true;
    UIImage *startImage = [UIImage imageNamed:@"start"];
    UIImage *red = [UIImage imageNamed:@"red"];
    UIImage *black = [UIImage imageNamed:@"black"];
    UIImage *green = [UIImage imageNamed:@"green"];
    UIImage *blue = [UIImage imageNamed:@"blue"];
    UIImage *white = [UIImage imageNamed:@"white"];
    UIImage *reset = [UIImage imageNamed:@"reset"];
    UIImage *share = [UIImage imageNamed:@"share"];
    NSArray *images = @[red, black, green, blue, white, reset, share];
    SphereMenu *sphereMenu = [[SphereMenu alloc] initWithStartPoint:CGPointMake(CGRectGetWidth(self.view.frame) / 2,CGRectGetHeight(self.view.frame)- 85) startImage:startImage submenuImages:images];
    sphereMenu.sphereDamping = 0.3;
    sphereMenu.sphereLength = 45;
    sphereMenu.delegate = self;
    [self.view addSubview:sphereMenu];

}


- (void)sphereDidSelected:(int)index
{
    switch (index) {
        case 0:
            [(JCDrawView*)[self view] setCurrentColor:[UIColor redColor]];
            [(JCDrawView*)[self view] setLineWidth:2.0];
            break;
        case 1:
            [(JCDrawView*)[self view] setCurrentColor:[UIColor blackColor]];
            [(JCDrawView*)[self view] setLineWidth:2.0];
            break;
        case 2:
            [(JCDrawView*)[self view] setCurrentColor:[UIColor greenColor]];
            [(JCDrawView*)[self view] setLineWidth:2.0];
            break;
        case 3:
            [(JCDrawView*)[self view] setCurrentColor:[UIColor blueColor]];
            [(JCDrawView*)[self view] setLineWidth:2.0];
            break;
        case 4:
            [(JCDrawView*)[self view] setCurrentColor:[UIColor whiteColor]];
            [(JCDrawView*)[self view] setLineWidth:30.0f];
            break;
        case 5:
            [[(JCDrawView*)[self view] drawImageView] setImage:nil];
            break;
        case 6:
            [self popUp];
            break;
        default:
            break;
    }
    
}

//save picture when button pressed...
- (void)popUp{
    NSString *textToShare = @"what's good";
    UIImage *image = [(JCDrawView *)[self view] image];
    /*if (image != nil) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didExportWithError:contextInfo:), nil);
    }*/
    
    NSArray *itemsToShare = @[textToShare, image];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList];
    [self presentViewController:activityVC animated:YES completion:nil];
}


- (void)image:(UIImage *)image didExportWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *message = @"Image successfully saved to Camera Roll";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    if (error) {
        message = [NSString stringWithFormat:@"Couldn't save image.\n%@", [error localizedDescription]];
        [alert setMessage:message];
        [alert setCancelButtonIndex:[alert addButtonWithTitle:@"Okay"]];
    } else {
        [alert setCancelButtonIndex:[alert addButtonWithTitle:@"Done"]];
    }
    
    [alert show];
    alert = nil;
}

- (IBAction)cancel:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextButton:(id)sender {
}
@end
