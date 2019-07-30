//
//  UIImageView+PSIBInspectable.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "UIImageView+PSIBInspectable.h"
#import "PSCommonDefine.h"

@implementation UIImageView (PSIBInspectable)

- (void)setPs_autoFit:(BOOL)ps_autoFit {
	
	if (ps_autoFit) {
		PS_IMAGEVIEW_CENTER_FIX(self);
	}
}

- (BOOL)ps_autoFit {
	
	return self.ps_autoFit;
}

@end
