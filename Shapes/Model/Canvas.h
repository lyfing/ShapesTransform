//
//  Canvas.h
//  Shapes
//
//  Created by lyfing on 13-10-31.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Shape.h"
#import "Transform.h"
#import "Circle.h"
#import "Polygon.h"

@interface Canvas : NSManagedObject

@property (nonatomic, retain) NSSet *shapes;
@property (nonatomic, retain) Transform *transform;

#pragma mark - Class Method
+ (id)canvasWithTransform:(Transform *)transform;
@end

@interface Canvas (CoreDataGeneratedAccessors)

- (void)addShapesObject:(Shape *)value;
- (void)removeShapesObject:(Shape *)value;
- (void)addShapes:(NSSet *)values;
- (void)removeShapes:(NSSet *)values;

@end
