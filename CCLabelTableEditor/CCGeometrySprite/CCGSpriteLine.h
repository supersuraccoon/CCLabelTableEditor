#import "cocos2d.h"

@interface CCGSpriteLine: CCSprite {
	float lineWidth;
	ccColor4B lineColor;
	CGPoint lineOrigin;
	CGPoint lineDestination;
}
-(id) initWithWidth:(float)lineWidth_
		  withColor:(ccColor4B)lineColor_
	 withLineOrigin:(CGPoint)lineOrigin_
withLineDestination:(CGPoint)lineDestination_;
		  
@property(nonatomic, assign) float lineWidth;
@property(nonatomic, assign) ccColor4B lineColor;
@property(nonatomic, assign) CGPoint lineOrigin;
@property(nonatomic, assign) CGPoint lineDestination;

@end