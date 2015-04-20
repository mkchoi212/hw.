//
//  PictureTableViewCell.h
//  homework
//
//  Created by Mike Choi on 4/4/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureButton;

@end
