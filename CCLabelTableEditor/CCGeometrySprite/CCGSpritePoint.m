#import "CCGSpritePoint.h"

@implementation CCGSpritePoint
@synthesize pointSize;
@synthesize pointColor;
@synthesize point;

-(id) initWithPoint:(CGPoint)point_
	  withPointSize:(float)pointSize_
		  withColor:(ccColor4B)pointColor_ {
	if( (self=[super init])) {
		self.point = point_;
		self.pointSize = pointSize_;
		self.pointColor = pointColor_;
	}
	return self;
}

-(void)draw {
	ccPointSize(pointSize);
	ccDrawColor4B(pointColor.r, pointColor.g, pointColor.b, pointColor.a);
	ccDrawPoint(point);
	ccPointSize(1.0f);
	ccDrawColor4B(255, 255, 255, 255);
}
@end