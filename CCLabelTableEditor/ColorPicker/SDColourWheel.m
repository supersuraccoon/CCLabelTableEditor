//
//  SDColourWheel.m
//
//  Created by Trent Milton on 12/07/11.
//  Copyright 2011 shaydes.dsgn. All rights reserved.
//
//
//  This code is released under the creative commons attribution-share alike licence, meaning:
//
//  Attribution - You must attribute the work in the manner specified by the author or licensor 
//  (but not in any way that suggests that they endorse you or your use of the work).
//  In this case, simple credit somewhere in your app or documentation will suffice.
//
//  Share Alike - If you alter, transform, or build upon this work, you may distribute the resulting
//  work only under the same, similar or a compatible license.
//  Simply put, if you improve upon it, share!
//
//  http://creativecommons.org/licenses/by-sa/3.0/us/
//
//  Thanks goes to Alex Restrepo for his original Color Picker as this was based on his idea, the images are burrowed
//  directly from that project located at:
//  http://mac.softpedia.com/get/Developer-Tools/Restrepo-Color-Picker.shtml

#import "SDColourWheel.h"

@interface SDColourWheel (PrivateMethods)
- (void) positionKnob:(UITouch *)touch;
- (void) mapPointToColor:(CGPoint) point;
@end

@implementation SDColourWheel

@synthesize delegate;

+ (id) colourWheel {
    return [[[self alloc] initColourWheel] autorelease];
}

- (id) initColourWheel {
    if ((self = [super init])) {
        
        self.isTouchEnabled = YES;
        
        CCSprite *wheel = [CCSprite spriteWithFile:@"pickerColourWheel.png"];
        CCSprite *knob = [CCSprite spriteWithFile:@"colourPickerKnob.png"];
        
        self.contentSize = CGSizeMake(wheel.contentSize.width, wheel.contentSize.height);
        
        wheel.anchorPoint = CGPointMake(0.5, 0.5);

        knob.position = CGPointMake(0, 0);
        
        [self addChild:wheel z:0 tag:ColourWheelTagColourWheel];
        [self addChild:knob z:0 tag:ColourWheelTagKnob];
        

        
    }
    return self;
}


- (void)ccTouchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    UITouch* touch = [touches anyObject];
    [self positionKnob:touch];
}

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    [self positionKnob:touch];
}

- (void) positionKnob:(UITouch *)touch {
    CCSprite *knob =  (CCSprite *)[self getChildByTag:ColourWheelTagKnob]; 
    CCSprite *colourWheel =  (CCSprite *)[self getChildByTag:ColourWheelTagColourWheel]; 
    CGPoint point = [self convertTouchToNodeSpace:touch];
   
    float imageRadius = colourWheel.contentSize.width / 2;
    float x = fabsf(point.x);
    float y = fabsf(point.y);
    float positionRadius = sqrtf(x * x + y * y);
    
	if (positionRadius <= imageRadius) {
        knob.position = point;
        
        [self mapPointToColor:point];
        
	}
}

// maps a given point in the color wheel to its corresponding hsv value
- (void) mapPointToColor:(CGPoint) touchPoint {
	CCSprite *colourWheel =  (CCSprite *)[self getChildByTag:ColourWheelTagColourWheel]; 
	CGPoint center = CGPointMake( colourWheel.contentSize.width / 2, colourWheel.contentSize.height / 2);

    CGPoint point = CGPointMake(touchPoint.x + colourWheel.contentSize.width / 2, touchPoint.y + colourWheel.contentSize.height / 2);

    double radius = colourWheel.texture.contentSizeInPixels.width / 2;
    
	// trig 101, find the angle between the point and the horizontal origin
	double dx = ABS(point.x - center.x);
    double dy = ABS(point.y - center.y);
    double angle = atan(dy / dx);
	
	if (isnan(angle))
		angle = 0.0;
	
	// if the point is above the center line, the angle will be 180º - angle
	if (point.x < center.x)
        angle = M_PI - angle;
	
	// if below, the angle is 360º - angle
    if (point.y > center.y) 
        angle = 2.0 * M_PI - angle;
	
	// saturation is the distance
    double dist = sqrt(pow(dx, 2) + pow(dy, 2));
    double saturation = MIN(dist / radius, 1.0);
	
	// if too close to the center, snap to white
	if (dist < 10)
        saturation = 0; // snap to center		    
	
	HSVType hsv = HSVTypeMake(angle / (2.0 * M_PI),
								  saturation, 
								  1.0);
    RGBType rgb = HSV_to_RGB(hsv);
    
    //CCLOG(@"RGB = %f %f %f", rgb.r * 255, rgb.g * 255, rgb.b * 255);
    [delegate colourChanged:rgb];
}

@end
