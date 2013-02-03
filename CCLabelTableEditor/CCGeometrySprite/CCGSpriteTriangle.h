#import "cocos2d.h"

@interface CCGSpriteTriangle: CCSprite {
	CGPoint pointOne;
	CGPoint pointTwo;
	CGPoint pointThree;
	float lineWidth;
	ccColor4B lineColor;
}
-(id) initWithPointOne:(CGPoint)pointOne_ 
		  withPointTwo:(CGPoint)pointTwo_ 
		withPointThree:(CGPoint)pointThree_ 
		   	 withWidth:(float)lineWidth_
		   	 withColor:(ccColor4B)lineColor_;

@property(nonatomic, assign) CGPoint pointOne;
@property(nonatomic, assign) CGPoint pointTwo;
@property(nonatomic, assign) CGPoint pointThree;
@property(nonatomic, assign) float lineWidth;
@property(nonatomic, assign) ccColor4B lineColor;

@end