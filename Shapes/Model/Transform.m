//
//  Transform.m
//  Shapes
//
//  Created by lyfing on 13-10-31.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import "Transform.h"
#import "Canvas.h"


@implementation Transform

@dynamic scale;
@dynamic canvas;

#pragma mark - Class Method
+ (id)transformWithScale:(float)scale
{
    CDTAppDelegate *appDelegate = (CDTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Transform *transform = [NSEntityDescription insertNewObjectForEntityForName:kEntityTransform inManagedObjectContext:context];
    [transform setValue:[NSNumber numberWithFloat:scale] forKey:kScale];
    
    return transform;
}
@end
