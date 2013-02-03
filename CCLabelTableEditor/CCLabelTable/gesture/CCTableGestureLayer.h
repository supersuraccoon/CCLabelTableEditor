#import "cocos2d.h"

@protocol CCTableGestureLayerDelegate<NSObject>
-(void) gestureSwipeAt:(CGPoint)touchLocation direction:(int)direction touches:(int)touches state:(UIGestureRecognizerState)state;
-(void) gestureLongPressAt:(CGPoint)touchLocation state:(UIGestureRecognizerState)state;
-(void) gestureSingleTapAt:(CGPoint)touchLocation state:(UIGestureRecognizerState)state;
-(void) gestureDoubleTapAt:(CGPoint)touchLocation state:(UIGestureRecognizerState)state;
-(void) gesturePanAt:(CGPoint)touchLocation state:(UIGestureRecognizerState)state;
@end

@interface CCTableGestureLayer : CCLayerColor<UIGestureRecognizerDelegate> {
    id<CCTableGestureLayerDelegate> delegate;
}

// init
-(id) initWithWidth:(float)width_ height:(float)height_ delegate:(id<CCTableGestureLayerDelegate>)delegate_;
-(void) initGesture;
-(void) enableTouch:(BOOL)enableFlag;
-(void) updateContentSize:(CGSize)size;

// table
@property (nonatomic, retain) id<CCTableGestureLayerDelegate> delegate;
    
@end

