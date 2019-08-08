//
//  UILabel+PSIBInspectable.m
//  tyfocg
//
//  Created by paintingStyle on 2018/2/6.
//  Copyright © 2018年 spap. All rights reserved.
//

#import "UILabel+PSIBInspectable.h"
#import "PSCommonDefine.h"

@implementation UILabel (PSIBInspectable)

- (void)setPs_autoFont:(BOOL)ps_autoFont {
    
    if (!ps_autoFont) { return; }
    
    PS_LABEL_FONT_ADAPT(self);
}

- (BOOL)ps_autoFont {
    
    return self.ps_autoFont;
}

@end
