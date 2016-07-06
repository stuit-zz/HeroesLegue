//
//  HLStory.m
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/5/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import "HLStory.h"

@implementation HLStory {
    NSDictionary *_thumbnailDictionary;
}

- (void)setThumbnailDictionary:(NSDictionary *)thumbnailDictionary {
    if (!thumbnailDictionary)
        return;
    
    _thumbnailDictionary = thumbnailDictionary;
    self.thumbnailURL = [NSString stringWithFormat:@"%@.%@", _thumbnailDictionary[@"path"], _thumbnailDictionary[@"extension"]];
}

- (NSDictionary *)thumbnailDictionary {
    return _thumbnailDictionary;
}

@end
