#import "CCGSpriteTriangle.h"

@implementation CCGSpriteTriangle
@synthesize pointOne;
@synthesize pointTwo;
@synthesize pointThree;
@synthesize lineWidth;
@synthesize lineColor;

-(id) initWithPointOne:(CGPoint)pointOne_ 
		  withPointTwo:(CGPoint)pointTwo_ 
		withPointThree:(CGPoint)pointThree_ 
		   	 withWidth:(float)lineWidth_
		   	 withColor:(ccColor4B)lineColor_ {
	if( (self=[super init])) {
		self.pointOne = pointOne_;
		self.pointTwo = pointTwo_;
		self.pointThree = pointThree_;
		self.lineWidth = lineWidth_;
		self.lineColor = lineColor_;
	}
	return self;
}

-(void)draw {
	glLineWidth(lineWidth);
	ccDrawColor4B(lineColor.r, lineColor.g, lineColor.b, lineColor.a);
	CGPoint points[] = {pointOne, pointTwo, pointThree};
	ccDrawPoly(points, 4, YES);
	glLineWidth(1.0f);
	ccDrawColor4B(255, 255, 255, 255);
}
@end