//
//  ViewController.m
//  homework
//
//  Created by Mike Choi on 3/11/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#import "ViewController.h"
#import "AMWaveTransition.h"
#import "VBFPopFlatButton.h"
#import "PopMenu.h"
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "PBJViewController.h"
#import "VideoTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, DBCameraCollectionControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) VBFPopFlatButton *quickAddButton;
@property (nonatomic, strong) PopMenu *popMenu;
@property BOOL pressed_ornah;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [self setTitle:@"Home"];
    
    self.tableView.estimatedRowHeight = 300.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //scrolling navbar
    [self setUseSuperview:YES];
    [self followScrollView:self.tableView withDelay:30];
    [self setShouldScrollWhenContentFits:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setDelegate:self];
    self.quickAddButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(200, 100, 20, 20)
                                                      buttonType:buttonAddType
                                                     buttonStyle:buttonPlainStyle
                                           animateToInitialState:YES];
    self.quickAddButton.lineThickness = 1.5;
    self.quickAddButton.tintColor = [UIColor blackColor];
    [self.quickAddButton addTarget:self
                            action:@selector(quickAddPressed)
                  forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *quickAdd =[[UIBarButtonItem alloc] initWithCustomView:self.quickAddButton];
    self.navigationItem.rightBarButtonItem = quickAdd;
    
    //vertical quick add menu itself
    self.quickMenu.delegate = self;
    self.quickMenu.liveBlurBackgroundStyle = self.navigationController.navigationBar.barStyle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
    if(!cell){
        [tableView registerNib:[UINib nibWithNibName:@"VideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"videoCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
    }

    return cell;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
    if (operation != UINavigationControllerOperationNone) {
        return [AMWaveTransition transitionWithOperation:operation andTransitionType:AMWaveTransitionTypeBounce];
    }
    return nil;
}


- (void)quickAddPressed{
    if(self.pressed_ornah == FALSE){
        [self.quickAddButton animateToType:buttonCloseType];
        self.pressed_ornah = TRUE;
        [self showMenu];
    }
    else{
        [self.quickAddButton animateToType:buttonAddType];
        self.pressed_ornah = FALSE;
        [self.popMenu dismissMenu];
    }
    
}

- (void)showMenu {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    MenuItem *menuItem = [[MenuItem alloc] initWithTitle:@"Text" iconName:@"text" glowColor:[UIColor clearColor] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Draw" iconName:@"draw" glowColor:[UIColor clearColor] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Voice" iconName:@"voice" glowColor:[UIColor clearColor] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Photo" iconName:@"camera" glowColor:[UIColor clearColor] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Video" iconName:@"video" glowColor:[UIColor clearColor] index:0];
    [items addObject:menuItem];
    
    
    //need to change button once clicked outside frame
    if (!_popMenu) {
        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
        _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
    }
    if (_popMenu.isShowed) {
        return;
    }
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
    
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"nav"];

        if([selectedItem.title compare:@"Draw"] == FALSE){
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"draw"];
            navigationController = [[UINavigationController alloc]initWithRootViewController:vc];
            [self.navigationController presentViewController:navigationController animated:YES completion:nil];
        }
        if([selectedItem.title compare:@"Voice"] == FALSE){
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"audio"];
            [self.navigationController presentViewController:vc animated:YES completion:nil];
        }
        if([selectedItem.title compare:@"Photo"] == FALSE){
                DBCameraContainerViewController *cameraContainer = [[DBCameraContainerViewController alloc] initWithDelegate:self];
                [cameraContainer setFullScreenMode];
                
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cameraContainer];
                [nav setNavigationBarHidden:YES];
                [self presentViewController:nav animated:YES completion:nil];
        }
        if([selectedItem.title compare:@"Video"] == FALSE){
            PBJViewController *vc = [[PBJViewController alloc]init];
            [self.navigationController presentViewController:vc animated:YES completion:nil];
        }

        [self.quickAddButton animateToType:buttonAddType];
        self.pressed_ornah = FALSE;
    };
    
    [_popMenu showMenuAtView:self.view startPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds)) endPoint:CGPointMake(60, CGRectGetHeight(self.view.bounds))];
}

#pragma mark Camera Delegates!

/*- (void) camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    [detail setDetailImage:image];
    [self.navigationController pushViewController:detail animated:NO];
    [cameraViewController restoreFullScreenMode];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}*/

- (void) dismissCamera:(id)cameraViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}


#pragma makr Scroll Nav Bar delegate
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    // This enables the user to scroll down the navbar by tapping the status bar.
    //	[self performSelector:@selector(showNavbar) withObject:nil afterDelay:0.1];  // Use a delay if needed (pre iOS8)
    [self showNavbar];
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showNavBarAnimated:NO];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self showNavBarAnimated:NO];
}

- (void)dealloc
{
    [self.navigationController setDelegate:nil];
}


@end