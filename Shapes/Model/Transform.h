//
//  Transform.h
//  Shapes
//
//  Created by lyfing on 13-10-31.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Canvas;

@interface Transform : NSManagedObject

@property (nonatomic, retain) NSNumber * scale;
@property (nonatomic, retain) Canvas *canvas;
#pragma mark - Class Method
+ (id)transformWithScale:(float)scale;
@end
