//
//  Polygon.h
//  Shapes
//
//  Created by lyfing on 13-10-31.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Shape.h"
#import "Vertex.h"

@interface Polygon : Shape

@property (nonatomic, retain) NSSet *vertices;
#pragma mark - Class Method
+ (id)polygonWithPoint:(CGPoint)origin;
@end

@interface Polygon (CoreDataGeneratedAccessors)

- (void)addVerticesObject:(Vertex *)value;
- (void)removeVerticesObject:(Vertex *)value;
- (void)addVertices:(NSSet *)values;
- (void)removeVertices:(NSSet *)values;

@end
