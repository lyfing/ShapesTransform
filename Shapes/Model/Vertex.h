//
//  Vertex.h
//  Shapes
//
//  Created by lyfing on 13-10-31.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Polygon;

@interface Vertex : NSManagedObject

@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) Polygon *polygon;

@end
