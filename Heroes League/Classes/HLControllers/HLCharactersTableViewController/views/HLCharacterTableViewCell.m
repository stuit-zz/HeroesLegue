//
//  HLCharacterTableViewCell.m
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/4/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import "HLCharacterTableViewCell.h"

@implementation HLCharacterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.thumbView setContentMode:UIViewContentModeScaleAspectFill];
    [self.thumbView setClipsToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
