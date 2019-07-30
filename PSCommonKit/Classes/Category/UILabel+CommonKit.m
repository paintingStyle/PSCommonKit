//
//  UILabel+CommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "UILabel+CommonKit.h"

@implementation UILabel (CommonKit)

- (void)ps_fullJustifiedWithMaxW:(CGFloat)maxW {
	
	CGSize size = [self.text boundingRectWithSize:CGSizeMake(maxW,MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName :self.font}  context:nil].size;
	CGFloat margin = (maxW - size.width)/(self.text.length - 1);
	NSMutableAttributedString *attribute = [[NSMutableAttributedString  alloc]  initWithString:self.text];
	[attribute addAttribute:NSKernAttributeName
					  value:@(margin)
					  range:NSMakeRange(0,self.text.length -1)];
	self.attributedText = attribute;
}

@end
