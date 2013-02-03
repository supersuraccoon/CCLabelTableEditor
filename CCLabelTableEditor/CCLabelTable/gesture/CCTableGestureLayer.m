#import "CCTableGestureLayer.h"
#import "CCNode+SFGestureRecognizers.h"

@implementation CCTableGestureLayer
@synthesize delegate;

#pragma mark - init && dealloc
-(id) initWithWidth:(float)width_ height:(float)height_ delegate:(id<CCTableGestureLayerDelegate>)delegate_ {
    if ((self = [super initWithColor:ccc4(255, 0, 0, 0)
                               width:width_
                              height:height_])) {
        self.delegate = delegate_;
        self.isTouchEnabled = YES;
        [self initGesture];
    }
    return self;
}
#pragma mark - touch
-(void) initGesture {
    UISwipeGestureRecognizer *swipeGestureRecognizerL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureSwipe:)];
    [self addGestureRecognizer:swipeGestureRecognizerL];
    swipeGestureRecognizerL.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeGestureRecognizerL.delegate = self;
    [swipeGestureRecognizerL release];
    
    UISwipeGestureRecognizer *swipeGestureRecognizerR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureSwipe:)];
    [self addGestureRecognizer:swipeGestureRecognizerR];
    swipeGestureRecognizerR.direction = UISwipeGestureRecognizerDirectionRight;
    swipeGestureRecognizerR.delegate = self;
    [swipeGestureRecognizerR release];
    
    UISwipeGestureRecognizer *swipeGestureRecognizerU = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureSwipe:)];
    [self addGestureRecognizer:swipeGestureRecognizerU];
    swipeGestureRecognizerU.direction = UISwipeGestureRecognizerDirectionUp;
    swipeGestureRecognizerU.delegate = self;
    [swipeGestureRecognizerU release];
    
    UISwipeGestureRecognizer *swipeGestureRecognizerD = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureSwipe:)];
    [self addGestureRecognizer:swipeGestureRecognizerD];
    swipeGestureRecognizerD.direction = UISwipeGestureRecognizerDirectionDown;
    swipeGestureRecognizerD.delegate = self;
    [swipeGestureRecognizerD release];
    
    UISwipeGestureRecognizer *swipeGestureRecognizerLL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureSwipe:)];
    [self addGestureRecognizer:swipeGestureRecognizerLL];
    swipeGestureRecognizerLL.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeGestureRecognizerLL.delegate = self;
    swipeGestureRecognizerLL.numberOfTouchesRequired = 2;
    [swipeGestureRecognizerLL release];
    
    UISwipeGestureRecognizer *swipeGestureRecognizerRR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureSwipe:)];
    [self addGestureRecognizer:swipeGestureRecognizerRR];
    swipeGestureRecognizerRR.direction = UISwipeGestureRecognizerDirectionRight;
    swipeGestureRecognizerRR.delegate = self;
    swipeGestureRecognizerRR.numberOfTouchesRequired = 2;
    [swipeGestureRecognizerRR release];
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gestureLongPress:)];
    [self addGestureRecognizer:longPressGestureRecognizer];
    longPressGestureRecognizer.delegate = self;
    longPressGestureRecognizer.minimumPressDuration = 2.0f;
    [longPressGestureRecognizer release];
    
    UITapGestureRecognizer* singleGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureSingleTap:)];
    singleGestureRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleGestureRecognizer];
    singleGestureRecognizer.delegate = self;
    [singleGestureRecognizer release];
    
    UITapGestureRecognizer *doubleGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureDoubleTap:)];
    [self addGestureRecognizer:doubleGestureRecognizer];
    doubleGestureRecognizer.numberOfTapsRequired = 2;
    doubleGestureRecognizer.delegate = self;
    [doubleGestureRecognizer release];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesturePanAt:)];
    [self addGestureRecognizer:panGestureRecognizer];
    panGestureRecognizer.delegate = self;
    [panGestureRecognizer release];
    
    [panGestureRecognizer requireGestureRecognizerToFail:swipeGestureRecognizerU];
    [panGestureRecognizer requireGestureRecognizerToFail:swipeGestureRecognizerD];
    [panGestureRecognizer requireGestureRecognizerToFail:swipeGestureRecognizerL];
    [panGestureRecognizer requireGestureRecognizerToFail:swipeGestureRecognizerR];
    [panGestureRecognizer requireGestureRecognizerToFail:swipeGestureRecognizerLL];
    [panGestureRecognizer requireGestureRecognizerToFail:swipeGestureRecognizerRR];
    [singleGestureRecognizer requireGestureRecognizerToFail:longPressGestureRecognizer];
    [singleGestureRecognizer requireGestureRecognizerToFail:doubleGestureRecognizer];
}

-(void) updateContentSize:(CGSize)size {
    self.contentSize = size;
}

-(void) gestureSwipe:(UISwipeGestureRecognizer*)aGestureRecognizer {
    if (aGestureRecognizer.state != UIGestureRecognizerStateBegan) {
        CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:[aGestureRecognizer locationInView:aGestureRecognizer.view]];
        if ( self.delegate) [self.delegate gestureSwipeAt:touchLocation
                                                direction:aGestureRecognizer.direction
                                                  touches:aGestureRecognizer.numberOfTouchesRequired
                                                    state:aGestureRecognizer.state];
    }
}

-(void) gestureLongPress:(UILongPressGestureRecognizer*)aGestureRecognizer {
    if(aGestureRecognizer.state != UIGestureRecognizerStateBegan) return;
    CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:[aGestureRecognizer locationInView:aGestureRecognizer.view]];
    if (self.delegate) [self.delegate gestureLongPressAt:touchLocation state:aGestureRecognizer.state];
}

-(void) gesturePanAt:(UIPanGestureRecognizer*)aGestureRecognizer {
    CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:[aGestureRecognizer locationInView:aGestureRecognizer.view]];
    if (self.delegate) [self.delegate gesturePanAt:touchLocation state:aGestureRecognizer.state];
}

- (void)gestureSingleTap:(UITapGestureRecognizer*)aGestureRecognizer {
    CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:[aGestureRecognizer locationInView:aGestureRecognizer.view]];
    if (self.delegate) [self.delegate gestureSingleTapAt:touchLocation state:aGestureRecognizer.state];
}

- (void)gestureDoubleTap:(UITapGestureRecognizer*)aGestureRecognizer {
    CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:[aGestureRecognizer locationInView:aGestureRecognizer.view]];
    if (self.delegate) [self.delegate gestureDoubleTapAt:touchLocation state:aGestureRecognizer.state];
}

-(void) enableTouch:(BOOL)enableFlag {
    [self setIsTouchEnabled:enableFlag];
}
@end
