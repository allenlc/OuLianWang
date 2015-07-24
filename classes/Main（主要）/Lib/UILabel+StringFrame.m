//
//  UILabel+StringFrame.m
//  OuLianWang
//
//  Created by hsmj on 15/7/1.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "UILabel+StringFrame.h"

@implementation UILabel (StringFrame)


- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}



@end
