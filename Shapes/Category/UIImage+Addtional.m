//
//  UIImage+Addtional.m
//  Shapes
//
//  Created by lyfing on 13-11-2.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import "UIImage+Addtional.h"

@implementation UIImage (Addtional)
- (UIImage *)middleStretchableImage
{
    CGSize size = [self size];
    
    return [self stretchableImageWithLeftCapWidth:size.width / 2.0f topCapHeight:size.height / 2.0f];
}
@end
