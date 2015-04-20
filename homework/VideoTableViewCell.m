//
//  VideoTableViewCell.m
//  homework
//
//  Created by Mike Choi on 3/23/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#import "VideoTableViewCell.h"

@implementation VideoTableViewCell

- (void)awakeFromNib {

    self.circleView.layer.cornerRadius = 29;
    [self.videoPlayer setDelegate:self];
    [self.videoPlayer setEndAction:AWEasyVideoPlayerEndActionLoop];
    [self setVideoPlayer:self.videoPlayer];
 }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
   
}
#pragma mark - AWEasyVideoPlayerDelegate

-(void)videoPlayer:(AWEasyVideoPlayer *)videoPlayer encounteredError:(NSError *)error {
    
    NSLog(@"Encountered error: %@",[error localizedDescription]);
    
}


@end
