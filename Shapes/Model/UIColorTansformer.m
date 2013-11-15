//
//  UIColorTansformer.m
//  Shapes
//
//  Created by lyfing on 13-10-31.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import "UIColorTansformer.h"

@implementation UIColorTansformer
#pragma mark - Over Write Method
+ (BOOL)allowsReverseTransformation;
{
    return YES;
}

+ (Class)transformedValueClass
{
    return [NSData class];
}

- (id)transformedValue:(id)value
{
    UIColor *color = (UIColor *)value;
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSString *result = [NSString stringWithFormat:@"%f,%f,%f",components[0],components[1],components[2]];
    
    return [result dataUsingEncoding:[NSString defaultCStringEncoding]];
}

- (id)reverseTransformedValue:(id)value
{
    NSString *result = [[NSString alloc] initWithData:value encoding:[NSString defaultCStringEncoding]];
    NSArray *components = [result componentsSeparatedByString:@","];
    CGFloat r = [[components objectAtIndex:0] floatValue];
    CGFloat g = [[components objectAtIndex:1] floatValue];
    CGFloat b = [[components objectAtIndex:2] floatValue];
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}
@end
