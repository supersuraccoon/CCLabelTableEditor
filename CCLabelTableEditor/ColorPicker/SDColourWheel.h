//
//  SDColourWheel.h
//
//  Created by Trent Milton on 12/07/11.
//  Copyright 2011 shaydes.dsgn. All rights reserved.
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

#import "HSV.h"
#import "cocos2d.h"
 
typedef enum {
    ColourWheelTagColourWheel = 0,
    ColourWheelTagKnob,
    ColourWheelTagMAX,
} ColourWheelTags;

@protocol SDColourWheelDelegate  
- (void) colourChanged:(RGBType)colour;
@end  

@interface SDColourWheel : CCLayer {
    id<SDColourWheelDelegate> delegate;  
}

@property (nonatomic, retain) id<SDColourWheelDelegate> delegate; 

+ (id) colourWheel;
    
- (id) initColourWheel;
    
@end
