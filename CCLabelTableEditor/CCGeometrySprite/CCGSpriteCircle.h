#import "cocos2d.h"

@interface CCGSpriteCircle: CCSprite {
	float radius;
	float angle;
	int segments;
	int lineWidth;
	ccColor4B lineColor;
	BOOL drawLineToCenter;
}
-(id) initWithRadius:(float)radius_ 
		   withAngle:(float)angle_ 
		withSegments:(int)segments_ 
		   withWidth:(int)lineWidth_
		   withColor:(ccColor4B)lineColor_ 
withDrawLineToCenter:(BOOL)drawLineToCenter_;

@property(nonatomic, assign) float radius;
@property(nonatomic, assign) float angle;
@property(nonatomic, assign) int segments;
@property(nonatomic, assign) int lineWidth;
@property(nonatomic, assign) ccColor4B lineColor;
@property(nonatomic, assign) BOOL drawLineToCenter;

@end