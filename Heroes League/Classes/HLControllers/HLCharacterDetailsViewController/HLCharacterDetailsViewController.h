//
//  HLCharacterDetailsViewController.h
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/5/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIScrollView+APParallaxHeader.h>
#import "HLMediaTableViewCell.h"
#import "HLMediaCollectionViewCell.h"

@interface HLCharacterDetailsViewController : UITableViewController
<
HLConnectionManagerDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property (strong, nonatomic) NSNumber *charID;

@end
