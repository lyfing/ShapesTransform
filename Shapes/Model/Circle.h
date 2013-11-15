//
//  Circle.h
//  Shapes
//
//  Created by lyfing on 13-10-31.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Shape.h"


@interface Circle : Shape

@property (nonatomic, retain) NSNumber * radius;
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;

#pragma mark - Class Method
+ (id)circleWithPoint:(CGPoint)origin;
@end
