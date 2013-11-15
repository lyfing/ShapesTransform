//
//  CDTShapeViewController.m
//  Shapes
//
//  Created by lyfing on 13-10-30.
//  Copyright (c) 2013年 lyfing.inc. All rights reserved.
//

#import "CDTShapeViewController.h"
#import "CanvasView.h"

NSInteger flag = 0;
@interface CDTShapeViewController ()
@property (nonatomic,strong) CanvasView *topView;
@property (nonatomic,strong) CanvasView *bottomView;
@property (nonatomic,strong) UIButton *redoBtn;
@property (nonatomic,strong) UIButton *undoBtn;
@property (nonatomic,assign) CGFloat screenWidth;
@property (nonatomic,assign) CGFloat screenHeight;
@end

@implementation CDTShapeViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.topView = nil;
    self.bottomView = nil;
    self.redoBtn = nil;
    self.undoBtn = nil;
}

- (id)init
{
    if ( self = [super init] ) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateRedoAndUndoButton:) name:NSManagedObjectContextObjectsDidChangeNotification object:nil];
        self.screenWidth = SCREEN_WIDTH;
        self.screenHeight = SCREEN_HEIGHT;
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self setupViews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadData];
    [self handleUpdateRedoAndUndoButton:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    BOOL portrait = ( UIInterfaceOrientationPortrait == toInterfaceOrientation || UIInterfaceOrientationPortraitUpsideDown == toInterfaceOrientation );
    self.screenWidth = portrait ? SCREEN_WIDTH:SCREEN_HEIGHT;
    self.screenHeight = portrait ? SCREEN_HEIGHT:SCREEN_WIDTH;
    [self setupViews];
}
#pragma mark - Private Method
- (void)setupViews
{
    CGRect frame = CGRectMake(0.0f, 0.0f, self.screenWidth, self.screenHeight / 2.0f);
    if ( nil == self.topView ) {
        self.topView = [[CanvasView alloc] initWithFrame:frame];
        [self.view addSubview:self.topView];
    }
    self.topView.frame = frame;
    
    frame = CGRectMake(0.0f, self.screenHeight / 2.0f, self.screenWidth, self.screenHeight / 2.0f);
    if ( nil == self.bottomView ) {
        self.bottomView = [[CanvasView alloc] initWithFrame:frame];
        [self.view addSubview:self.bottomView];
    }
    self.bottomView.frame = frame;
    
    frame = CGRectMake(10.0f, 20.0f, 60.0f, 36.0f);
    UIImage *img = [UIImage imageNamed:@"greyButton"];
    img = [img middleStretchableImage];
    if ( nil == self.redoBtn ) {
        self.redoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.redoBtn setTitle:@"Redo" forState:UIControlStateNormal];
        [self.redoBtn setBackgroundImage:img forState:UIControlStateNormal];
        [self.redoBtn addTarget:self action:@selector(redoAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.redoBtn];
    }
    self.redoBtn.frame = frame;
    
    frame = CGRectMake(self.screenWidth - 10.0f - 60.0f, 20.0f, 60.0f, 36.0f);
    if ( nil == self.undoBtn ) {
        self.undoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.undoBtn setTitle:@"Undo" forState:UIControlStateNormal];
        [self.undoBtn setBackgroundImage:img forState:UIControlStateNormal];
        [self.undoBtn addTarget:self action:@selector(undoAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.undoBtn];
    }
    self.undoBtn.frame = frame;
}

- (void)loadData
{
    Canvas *canvas1 = nil;
    Canvas *canvas2 = nil;
    
    //NSManageObjectContext
    CDTAppDelegate *appDelegate = (CDTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //Load the canvas
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kEntityCanvas];
    NSArray *canvasArry = [context executeFetchRequest:fetchRequest error:nil];
    if ( [canvasArry count] >= 2 ) {
        canvas1 = [canvasArry objectAtIndex:0];
        canvas2 = [canvasArry objectAtIndex:1];
    }
    else{
        //not exist,create them
        Transform *transform1 = [Transform transformWithScale:1];
        canvas1 = [Canvas canvasWithTransform:transform1];

        Transform *transform2 = [Transform transformWithScale:2];
        canvas2 = [Canvas canvasWithTransform:transform2];
        
        //Save
        [appDelegate saveContext];
    }
    
    self.topView.canvas = canvas1;
    self.bottomView.canvas = canvas2; 
}

- (UIColor *)makeRandomColor
{
    float r = ( arc4random() % 256 ) / 255.0;
    float g = ( arc4random() % 256 ) / 255.0;
    float b = ( arc4random() % 256 ) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

- (void)createShapeAt:(CGPoint)point
{
    CDTAppDelegate *appDelegate = (CDTAppDelegate *)[UIApplication sharedApplication].delegate;
#ifdef kSetNSUndoManagerUnGroup
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    [context.undoManager beginUndoGrouping];
#endif
    
    Shape *shape = nil;
    ShapeType type = arc4random() % kShapeTypeCount;
    if ( ShapeTypeCircle == type ) {
        shape = [Circle circleWithPoint:point];
    }
    else if ( ShapeTypePolygon == type )
    {
        shape = [Polygon polygonWithPoint:point];
    }
    [shape setValue:[self makeRandomColor] forKey:kColor];
    
    [self.topView.canvas addShapesObject:shape];
    [self.bottomView.canvas addShapesObject:shape];
    
#ifdef kSetNSUndoManagerUnGroup
    [context.undoManager endUndoGrouping];
#endif
    
    [appDelegate saveContext];

    //Set Display layout
    [self.topView setNeedsDisplay];
    [self.bottomView setNeedsDisplay];
}

- (void)updateAllShapes
{
    CDTAppDelegate *appDelegate = (CDTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kEntityShape];
    NSArray *shapes = [context executeFetchRequest:fetchRequest error:nil];
    for ( Shape *shape in shapes ) {
        [shape setValue:[self makeRandomColor] forKey:kColor];
    }
    
    [appDelegate saveContext];
    
    [self.topView setNeedsDisplay];
    [self.bottomView setNeedsDisplay];
}

- (void)deleteAllShapes
{
    CDTAppDelegate *appDelegate = (CDTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kEntityShape];
    NSArray *shapes = [context executeFetchRequest:fetchRequest error:nil];
    for ( Shape *shape in shapes ) {
        [context deleteObject:shape]; 
    }
    
    [appDelegate saveContext];
    
    [self.topView setNeedsDisplay];
    [self.bottomView setNeedsDisplay];
}

#pragma mark - Button Action Related
- (void)redoAction:(id)sender
{
    CDTAppDelegate *appDelegate = (CDTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    if ( [context.undoManager canRedo] ) {
        [context.undoManager redo];
    }
    
    [self.topView setNeedsDisplay];
    [self.bottomView setNeedsDisplay];
}

- (void)undoAction:(id)sender
{
    CDTAppDelegate *appDelegate = (CDTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSUndoManager *undoMgr = [context undoManager];
    NSUInteger undoLevel = [context.undoManager levelsOfUndo];
    NSLog(@"undoLevel = %d",undoLevel);
    
    if ( [undoMgr canUndo] ) {
        [context.undoManager undo];
    }
    
    [self.topView setNeedsDisplay];
    [self.bottomView setNeedsDisplay];
    NSLog(@"self.topView.cavas = %@\nself.bottom.cavas = %@",self.topView.canvas,self.bottomView.canvas);
}

- (void)handleUpdateRedoAndUndoButton:(NSNotification *)notify
{
    CDTAppDelegate *appDelegate = (CDTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSUndoManager *undoMgr = [appDelegate.managedObjectContext undoManager];
    self.undoBtn.hidden = ![undoMgr canUndo];
    self.redoBtn.hidden = ![undoMgr canRedo];
}
#pragma mark - UITouch Event Tracking
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    UIView *view = touch.view;
    if ( [view isKindOfClass:[CanvasView class]] ) {
        float scale = [(CanvasView *)touch.view scale];
        point = CGPointMake(point.x / scale, point.y / scale);
        
        [self createShapeAt:point];
    }
}

#pragma mark - Shake Event Handling
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake ) {
        [self deleteAllShapes];
    }
}

//#pragma mark - UndoManager
//- (void)makeItHotter
//{
//    flag += 10;
//    
//    CDTAppDelegate *appDelegate = (CDTAppDelegate *)[UIApplication sharedApplication].delegate;
//    NSUndoManager *undoMgr = [appDelegate.managedObjectContext undoManager];
//    [[undoMgr prepareWithInvocationTarget:self] makeItColder];
//}
//
//- (void)makeItColder
//{
//    flag -= 10;
//    
//    CDTAppDelegate *appDelegate = (CDTAppDelegate *)[UIApplication sharedApplication].delegate;
//    NSUndoManager *undoMgr = [appDelegate.managedObjectContext undoManager];
//    [[undoMgr prepareWithInvocationTarget:self] makeItHotter];
//    
//}
@end