//
//  UIViewController+HLAdditions.m
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/5/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import "UIViewController+HLAdditions.h"

@implementation UIViewController (HLAdditions)

- (void)showProgress {
    [SVProgressHUD show];
}

- (void)hideProgress {
    [SVProgressHUD dismiss];
}

@end
