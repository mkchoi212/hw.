//
//  VoiceTableViewCell.m
//  homework
//
//  Created by Mike Choi on 4/4/15.
//  Copyright (c) 2015 Mike Choi. All rights reserved.
//

#import "VoiceTableViewCell.h"
#import "SYWaveformPlayerView.h"
@implementation VoiceTableViewCell

- (void)awakeFromNib {
    self.circleView.layer.cornerRadius = 29;

   // AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[[NSBundle mainBundle] URLForResource:@"I Need A Dollar" withExtension:@"mp3"] options:nil];
    
//self.voicePlayer = [[SYWaveformPlayerView alloc] initWithFrame:CGRectMake(7, 73, self.frame.size.width-40, 60) asset:asset color:[UIColor lightGrayColor] progressColor:[UIColor colorWithRed:12.0/255.0 green:95.0/255.0 blue:250.0/255.0 alpha:1]];
    [self addSubview:self.voicePlayer];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
