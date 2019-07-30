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

- (void)setPs_autoAdaptW:(BOOL)ps_autoAdaptW {
    
    if (!ps_autoAdaptW) { return; }
    
    self.constant = PS_LAYOUT_W(self.constant);
}

- (BOOL)ps_autoAdaptW {
    
    return self.ps_autoAdaptW;
}

- (void)setPs_autoAdaptH:(BOOL)ps_autoAdaptH {
    
    if (!ps_autoAdaptH) { return; }
    
    self.constant = PS_LAYOUT_H(self.constant);
}

- (BOOL)ps_autoAdaptH {
    
    return self.ps_autoAdaptH;
}

- (void)setPs_autoAdaptNavBar:(BOOL)ps_autoAdaptNavBar {
    
    if (!ps_autoAdaptNavBar) { return; }
	
	self.constant = PS_NAV_BAR_H;
}

- (BOOL)ps_autoAdaptNavBar {
    
    return self.ps_autoAdaptNavBar;
}

@end
