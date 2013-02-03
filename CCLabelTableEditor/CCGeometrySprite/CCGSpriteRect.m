#import "CCGSpriteRect.h"

@implementation CCGSpriteRect
@synthesize targetRect;
@synthesize lineWidth;
@synthesize lineColor;


+(id) rectWithRect:(CGRect)targetRect_ withLineWidth:(float)lineWidth_ withLineColor:(ccColor4B)lineColor_ {
    return [[[self alloc] initWithRect:targetRect_ withLineWidth:lineWidth_ withLineColor:lineColor_] autorelease];
}

-(id) initWithRect:(CGRect)targetRect_ withLineWidth:(float)lineWidth_ withLineColor:(ccColor4B)lineColor_ {
	if( (self=[super init])) {
		self.targetRect = targetRect_;
		self.lineWidth = lineWidth_;
		self.lineColor = lineColor_;
	}
	return self;
}

-(void)draw {
    if (self.lineWidth > 0) {
        glLineWidth(self.lineWidth);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        ccDrawColor4B(self.lineColor.r, self.lineColor.g, self.lineColor.b, self.lineColor.a);
        ccDrawRect(ccp(self.targetRect.origin.x, self.targetRect.origin.y),
                   ccp(self.targetRect.origin.x + self.targetRect.size.width,
                       self.targetRect.origin.y + self.targetRect.size.height));
        glBlendFunc(CC_BLEND_SRC, CC_BLEND_DST);
        glLineWidth(1.0f);
    }
}
@end