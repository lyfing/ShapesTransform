//
//  GlobalMacros.h
//  Shapes
//
//  Created by lyfing on 13-10-30.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#ifndef Shapes_GlobalMacros_h
#define Shapes_GlobalMacros_h

#define kShapeTypeCount 2
typedef NS_ENUM(NSInteger, ShapeType)
{
    ShapeTypeCircle,
    ShapeTypePolygon
};

/*
 *UI Macros
 */
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

/*
 *Vertex
 */
#define kEntityVertex @"Vertex"
#define kVertex @"vertex"
#define kX @"x"
#define kY @"y"
#define kIndex @"index"
#define kPolygon @"polygon"

/*
 *Circel
 */
#define kEntityCircle @"Circle"
#define kCircle @"circle"
#define kRadius @"radius"

/*
 *Polygon
 */
#define kEntityPolygon @"Polygon"
#define kPolygon @"polygon"
#define kVertices @"vertices"

/*
 *Shape
 */
#define kEntityShape @"Shape"
#define kShape @"shape"
#define kColor @"color"
#define kCanvases @"canvases"

/*
 *Transform
 */
#define kEntityTransform @"Transform"
#define kTransform @"transform"
#define kScale @"scale"
#define kCanvas @"canvass"

/*
 *Canvas
 */
#define kEntityCanvas @"Canvas"
#define kShapes @"shapes"


/*
 *Switch
 */
//#define kValidateCircleRadiusValue
//#define kSetDefaultValueCircleRadius
/*
 *About UndoManager
 */
#define kSetNSUndoManager
//#define kSetNSUndoManagerUnGroup //set the GroupsByEvent to NO.
//#define kSetNSUndoManagerDisable //set the UndoManagerDisable
#endif
