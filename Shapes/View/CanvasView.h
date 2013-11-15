//
//  CanvasView.h
//  Shapes
//
//  Created by lyfing on 13-10-30.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Canvas.h"

@interface CanvasView : UIView
@property (nonatomic,strong) Canvas *canvas;

- (CGFloat)scale;
@end
