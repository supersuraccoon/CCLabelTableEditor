#import "CCGSpriteLine.h"

@implementation CCGSpriteLine
@synthesize lineWidth;
@synthesize lineColor;
@synthesize lineOrigin;
@synthesize lineDestination;

-(id) initWithWidth:(float)lineWidth_
		  withColor:(ccColor4B)lineColor_
	 withLineOrigin:(CGPoint)lineOrigin_
withLineDestination:(CGPoint)lineDestination_ {
	if( (self=[super init])) {
		self.lineWidth = lineWidth_;
		self.lineColor = lineColor_;
		self.lineOrigin = lineOrigin_;
		self.lineDestination = lineDestination_;
	}
	return self;
}

-(void)draw {
	if (lineWidth > 0) {
		glLineWidth(lineWidth);
		ccDrawColor4B(lineColor.r, lineColor.g, lineColor.b, lineColor.a);
		ccDrawLine(lineOrigin, lineDestination);
		glLineWidth(1.0f);
		ccDrawColor4B(255, 255, 255, 255);
	}
}
@end