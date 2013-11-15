//
//  Canvas.m
//  Shapes
//
//  Created by lyfing on 13-10-31.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import "Canvas.h"


@implementation Canvas

@dynamic shapes;
@dynamic transform;

#pragma mark - Class Method
+ (id)canvasWithTransform:(Transform *)transform
{
    CDTAppDelegate *appDelegate = (CDTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Canvas *canvas = [NSEntityDescription insertNewObjectForEntityForName:kEntityCanvas inManagedObjectContext:context];
    [canvas setValue:transform forKey:kTransform];
    
    return canvas;
}
@end
