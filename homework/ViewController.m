//
//  ViewController.m
//  homework
//
//  Created by Mike Choi on 3/11/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#import "ViewController.h"
#import "VBFPopFlatButton.h"
#import "PopMenu.h"
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "PBJViewController.h"
#import "StepsModalViewController.h"
#import "SACollectionViewVerticalScalingCell.h"
#import "SACollectionViewVerticalScalingFlowLayout.h"

@interface ViewController () <UICollectionViewDataSource, UINavigationControllerDelegate, DBCameraCollectionControllerDelegate>

@property (nonatomic, strong) VBFPopFlatButton *quickAddButton;
@property (nonatomic, strong) PopMenu *popMenu;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property BOOL pressed_ornah;

@end

@implementation ViewController

static NSString *const kCellIdentifier = @"Cell";


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [self setTitle:@"Home"];
    
    
    [self.collectionView registerClass:[SACollectionViewVerticalScalingCell class] forCellWithReuseIdentifier:kCellIdentifier];
    self.collectionView.dataSource = self;
    SACollectionViewVerticalScalingFlowLayout *layout = [[SACollectionViewVerticalScalingFlowLayout alloc] init];
    layout.scaleMode = SACollectionViewVerticalScalingFlowLayoutScaleModeHard;
    layout.alphaMode = SACollectionViewVerticalScalingFlowLayoutScaleModeHard;
    self.collectionView.collectionViewLayout = layout;

    //scrolling navbar
    [self setUseSuperview:YES];
    [self followScrollView:self.collectionView withDelay:30];
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


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SACollectionViewVerticalScalingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    NSInteger number = indexPath.row % 7 + 1;
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%@", @(number)]];
    [cell.containerView addSubview:imageView];
    return cell;
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

        if([selectedItem.title compare:@"Text"] == FALSE){
            StepsModalViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"steps"];
            [self presentViewController:vc animated:YES completion:nil];
        }
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