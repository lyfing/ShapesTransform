//
//  CanvasView.m
//  Shapes
//
//  Created by lyfing on 13-10-30.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import "CanvasView.h"

@implementation CanvasView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Instance Method
- (CGFloat)scale
{
    Transform *transform = [self.canvas valueForKey:kTransform];
    return [[transform valueForKey:kScale] floatValue];
}

#pragma mark - Private Method
- (UIColor *)colorFromStringValue:(NSString *)color
{
    UIColor *value = nil;
    NSArray *colorCodes = [color componentsSeparatedByString:@","];
    
    if ( [colorCodes count] == 3 ) {
        CGFloat r = [[colorCodes objectAtIndex:0] floatValue] / 255.0f;
        CGFloat g = [[colorCodes objectAtIndex:1] floatValue] / 255.0f;
        CGFloat b = [[colorCodes objectAtIndex:2] floatValue] / 255.0f;
        value = [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
    }
    
    return value;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Drawing code
    if ( self.canvas ) {
        //Get the current context
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //clear
        CGContextClearRect(context, rect);
        
        float scale = self.scale;
        
        //scale the context according to the stored value
        CGContextScaleCTM(context, scale, scale);
        
        NSSet *shapes = [self.canvas valueForKey:kShapes];
        for ( Shape *shape in shapes ) {
            CGColorRef colorRef = [[shape valueForKey:kColor] CGColor];
            CGContextSetFillColorWithColor(context, colorRef);
            
            NSString *entityName = [[shape entity] name];
            if ( [entityName isEqualToString:kEntityCircle] ) {
                float x = [[shape valueForKey:kX] floatValue];
                float y = [[shape valueForKey:kY] floatValue];
                float radius = [[shape valueForKey:kRadius] floatValue];
                CGContextFillEllipseInRect(context, CGRectMake(x - radius, y - radius, radius * 2, radius * 2));
            }
            else if ( [entityName isEqualToString:kEntityPolygon] )
            {                
                NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:kIndex ascending:YES];
                NSArray *sorts = [NSArray arrayWithObject:sortDescriptor];
                NSMutableSet *verticesSet = [shape mutableSetValueForKey:kVertices];
                NSArray *vertices = [verticesSet sortedArrayUsingDescriptors:sorts];
                
                CGContextBeginPath(context);
                Vertex *vertex = [vertices lastObject];
                CGContextMoveToPoint(context, [[vertex valueForKey:kX] floatValue], [[vertex valueForKey:kY] floatValue]);
                for ( Vertex *v in vertices ) {
                    CGContextAddLineToPoint(context, [[v valueForKey:kX] floatValue], [[v valueForKey:kY] floatValue]);
                }
                CGContextFillPath(context); 
            }
        }
    }
}
@end