#import "CCGSpriteCircle.h"

@implementation CCGSpriteCircle
@synthesize radius;
@synthesize angle;
@synthesize segments;
@synthesize lineWidth;
@synthesize lineColor;
@synthesize drawLineToCenter;

-(id) initWithRadius:(float)radius_ 
		   withAngle:(float)angle_ 
		withSegments:(int)segments_ 
		   withWidth:(int)lineWidth_
		   withColor:(ccColor4B)lineColor_ 
withDrawLineToCenter:(BOOL)drawLineToCenter_ {
	if( (self=[super init])) {
		self.radius = radius_;
		self.angle = angle_;
		self.segments = segments_;
		self.lineWidth = lineWidth_;
		self.lineColor = lineColor_;
		self.drawLineToCenter = drawLineToCenter_;
	}
	return self;
}

-(void)draw {
	glLineWidth(self.lineWidth);
	ccDrawColor4B(lineColor.r, lineColor.g, lineColor.b, lineColor.a);
	ccDrawCircle(ccp(self.position.x,self.position.y), radius, angle, segments, drawLineToCenter);
	glLineWidth(1.0f);
	ccDrawColor4B(255, 255, 255, 255);
}
@end