#import "cocos2d.h"

@interface CCGSpritePoint: CCSprite {
	CGPoint point;
	float pointSize;
	ccColor4B pointColor;
}
-(id) initWithPoint:(CGPoint)point_
	  withPointSize:(float)pointSize_
		  withColor:(ccColor4B)pointColor_;

@property(nonatomic, assign) CGPoint point;
@property(nonatomic, assign) float pointSize;
@property(nonatomic, assign) ccColor4B pointColor;

@end