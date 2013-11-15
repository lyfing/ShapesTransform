//
//  Shape.h
//  Shapes
//
//  Created by lyfing on 13-10-31.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Canvas;

@interface Shape : NSManagedObject

@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) NSSet *canvases;
@end

@interface Shape (CoreDataGeneratedAccessors)

- (void)addCanvasesObject:(Canvas *)value;
- (void)removeCanvasesObject:(Canvas *)value;
- (void)addCanvases:(NSSet *)values;
- (void)removeCanvases:(NSSet *)values;

@end
