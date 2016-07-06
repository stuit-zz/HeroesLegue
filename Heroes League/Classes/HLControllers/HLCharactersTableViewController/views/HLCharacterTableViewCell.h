//
//  HLCharacterTableViewCell.h
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/4/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLCharacterTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *thumbView;
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *descLbl;

@end
