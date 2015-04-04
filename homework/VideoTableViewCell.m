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

    self.circleView.alpha = 0.5;
    self.circleView.layer.cornerRadius = 29;
    //self.dueDate.backgroundColor = [UIColor blueColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
    //self.descriptionLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.frame);
}

@end
