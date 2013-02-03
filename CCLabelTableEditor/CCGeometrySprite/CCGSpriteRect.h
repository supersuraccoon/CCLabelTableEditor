#import "cocos2d.h"

@interface CCGSpriteRect: CCSprite {
	CGRect targetRect;
	float lineWidth;
	ccColor4B lineColor;
}

+(id) rectWithRect:(CGRect)targetRect_
     withLineWidth:(float)lineWidth_
     withLineColor:(ccColor4B)lineColor_;

-(id) initWithRect:(CGRect)targetRect_
     withLineWidth:(float)lineWidth_
     withLineColor:(ccColor4B)lineColor_;

@property(nonatomic, assign) CGRect targetRect;
@property(nonatomic, assign) float lineWidth;
@property(nonatomic, assign) ccColor4B lineColor;

@end