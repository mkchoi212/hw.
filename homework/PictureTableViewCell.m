//
//  PictureTableViewCell.m
//  homework
//
//  Created by Mike Choi on 4/4/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#import "PictureTableViewCell.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "ViewController.h"

@implementation PictureTableViewCell

- (void)awakeFromNib {
    
    self.circleView.layer.cornerRadius = 29;
    
    self.pictureButton.layer.cornerRadius = 5;
    self.pictureButton.clipsToBounds = YES;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] init];
    [tapRecognizer addTarget:self action:@selector(imageTapped:)];
    [self.pictureButton addGestureRecognizer:tapRecognizer];
    [self.pictureButton setAccessibilityLabel:@"Photo of a cat wearing a Bane costume."];

}

- (void)imageTapped:(id)sender {
    
    // Create image info
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = self.pictureButton.image;

    imageInfo.referenceRect = self.pictureButton.frame;
    imageInfo.referenceView = self.pictureButton.superview;
    imageInfo.referenceContentMode = self.pictureButton.contentMode;
    imageInfo.referenceCornerRadius = 0;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    UITableView *tv = (UITableView *) self.superview.superview;
    ViewController *vc = (ViewController *) tv.dataSource;
    [imageViewer showFromViewController:vc transition:JTSImageViewControllerTransition_FromOriginalPosition];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
