//
//  HLMediaTableViewCell.h
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/5/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLMediaTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *categoryNameLbl;
@property (strong, nonatomic) IBOutlet UICollectionView *categoryCollectionView;

@end
