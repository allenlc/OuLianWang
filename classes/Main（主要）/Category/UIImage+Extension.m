//
//  UIImage+Extension.m
//  ZQ微博
//
//  Created by Ibokan on 15/4/14.
//  Copyright (c) 2015年 HZQ. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+(UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
