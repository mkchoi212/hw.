//
//  VideoTableViewCell.h
//  homework
//
//  Created by Mike Choi on 3/23/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWEasyVideoPlayer.h"

@interface VideoTableViewCell : UITableViewCell <AWEasyVideoPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet AWEasyVideoPlayer *videoPlayer;

@end
