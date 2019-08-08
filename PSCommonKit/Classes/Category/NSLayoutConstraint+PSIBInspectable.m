//
//  NSLayoutConstraint+PSIBInspectable.m
//  tyfocg
//
//  Created by paintingStyle on 2017/11/27.
//  Copyright © 2017年 spap. All rights reserved.
//

#import "NSLayoutConstraint+PSIBInspectable.h"
#import "PSCommonDefine.h"

@implementation NSLayoutConstraint (PSIBInspectable)

- (void)setPs_adaptW:(BOOL)ps_adaptW {
	if (!ps_adaptW) { return; }
	
	self.constant = PS_LAYOUT_W(self.constant);
}

- (BOOL)ps_adaptW {
	return self.ps_adaptW;
}

- (void)setPs_adaptH:(BOOL)ps_adaptH {
	if (!ps_adaptH) { return; }
	
	self.constant = PS_LAYOUT_H(self.constant);
}

- (BOOL)ps_adaptH {
	return self.ps_adaptH;
}

- (void)setPs_adaptNavBar:(BOOL)ps_adaptNavBar {
	
	if (!ps_adaptNavBar) { return; }
	
	self.constant = PS_NAV_BAR_H;
}

- (BOOL)ps_adaptNavBar {
	return self.ps_adaptNavBar;
}

@end
