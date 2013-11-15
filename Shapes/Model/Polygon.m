//
//  Polygon.m
//  Shapes
//
//  Created by lyfing on 13-10-31.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import "Polygon.h"


@implementation Polygon

@dynamic vertices;

#pragma mark - Class Method
+ (id)polygonWithPoint:(CGPoint)origin
{
    CDTAppDelegate *appDelegate = (CDTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Polygon *polygon = [NSEntityDescription insertNewObjectForEntityForName:kEntityPolygon inManagedObjectContext:context];
    int nVertices = 3 + arc4random() % 20;
    float angleIncrement = ( 2 * M_PI ) / nVertices;
    NSUInteger index = 0;
    for ( NSUInteger idx = 0; idx < nVertices; idx ++ ) {
        float a = idx * angleIncrement;
        float radius = 10 + arc4random() % 90;
        float x = origin.x + radius * cos(a);
        float y = origin.y + radius * sin(a);
        
        Vertex *v = [NSEntityDescription insertNewObjectForEntityForName:kEntityVertex inManagedObjectContext:context];
        [v setValue:[NSNumber numberWithInt:x] forKey:kX];
        [v setValue:[NSNumber numberWithInt:y] forKey:kY];
        [v setValue:[NSNumber numberWithInt:index ++] forKey:kIndex];
        [polygon addVerticesObject:v];
    }
    
    return polygon;
}
@end
