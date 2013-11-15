//
//  Circle.m
//  Shapes
//
//  Created by lyfing on 13-10-31.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import "Circle.h"


@implementation Circle

@dynamic radius;
@dynamic x;
@dynamic y;

#pragma mark - Class Method
+ (id)circleWithPoint:(CGPoint)origin
{
    CDTAppDelegate *appDelegate = (CDTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Circle *circle = [NSEntityDescription insertNewObjectForEntityForName:kEntityCircle inManagedObjectContext:context];
    circle.x = [NSNumber numberWithFloat:origin.x];
    circle.y = [NSNumber numberWithFloat:origin.y];
    circle.radius = [NSNumber numberWithFloat:( 10 + arc4random() % 20 )];
    
    return circle;
}

#pragma mark - Private Method
- (NSError *)errorFromOriginalError:(NSError *)originalError error:(NSError *)newError
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
    NSMutableArray *errors = [NSMutableArray arrayWithObject:newError];
    if ( [originalError code] == NSValidationMultipleErrorsError ) {
        [userInfo addEntriesFromDictionary:[originalError userInfo]];
        [errors addObjectsFromArray:[userInfo valueForKey:NSDetailedErrorsKey]];
    }
    else{
        [errors addObject:originalError];
    }
    [userInfo setObject:errors forKey:NSDetailedErrorsKey];
    
    return [NSError errorWithDomain:NSCocoaErrorDomain code:NSValidationMultipleErrorsError userInfo:userInfo];
}

#pragma mark - Over Write Method
- (BOOL)validateValue:(id *)value forKey:(NSString *)key error:(NSError **)error
{
    BOOL retValue = YES;
#ifdef kValidateCircleRadiusValue
    if ( [key isEqualToString:kRadius] ) {
        float trueValue = [*value floatValue];
        if ( trueValue > 7.0f && trueValue < 10.0f ) {
            retValue = NO;
        }
        
        if ( NULL != error ) {
            NSString *msg = [NSString stringWithFormat:@"Radius must be between 7.0 and 10.0"];
            NSDictionary *dict = [NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey];
            *error = [[NSError alloc] initWithDomain:kEntityShape code:10 userInfo:dict];
        }
    }
#endif
    
    return retValue;
}

- (void)awakeFromInsert
{
    [super awakeFromInsert];
#ifdef kSetDefaultValueCircleRadius
    [self setRadius:[NSNumber numberWithFloat:8.0f]];
#endif
}

@end
