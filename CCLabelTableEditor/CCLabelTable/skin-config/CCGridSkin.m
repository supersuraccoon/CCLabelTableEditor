#import "CCGridSkin.h"

@implementation CCGridSkin

#pragma mark init/dealloc
- (id) init {
    if((self=[super init])) {
        [self initDefaultSkin];
    }
    return self;
}

- (void) dealloc {
    [super dealloc];
}

-(void) initDefaultSkin {
    self.frameWidth = kDefaultGridWidth;
    self.frameColor = kDefaultGridColor;
    self.frameOpacity = kDefaultGridOpacity;
}

-(void) updateSkinWithDict:(NSMutableDictionary *)skinDict {
    self.frameWidth = [[skinDict objectForKey:@"GridWidth"] floatValue];
    NSArray *gridColorArray = [[skinDict objectForKey:@"GridColor"] componentsSeparatedByString:@","];
    self.frameColor = ccc3([gridColorArray[0] floatValue], [gridColorArray[1] floatValue], [gridColorArray[2] floatValue]);
    self.frameOpacity = [[skinDict objectForKey:@"GridOpacity"] floatValue];
}

-(void) parseSkinToDict:(NSMutableDictionary *)skinDict {
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.frameColor.r, (float)self.frameColor.g, (float)self.frameColor.b] forKey:@"GridColor"];
    [skinDict setObject:[NSNumber numberWithFloat:self.frameWidth] forKey:@"GridWidth"];
    [skinDict setObject:[NSNumber numberWithFloat:self.frameOpacity] forKey:@"GridOpacity"];
}

#pragma mark - update property
-(BOOL) updateElementWidth:(float)width {return NO;}
-(BOOL) updateElementHeight:(float)height {return NO;}
-(BOOL) updateFontName:(NSString *)fontName {return NO;}
-(BOOL) updateFontSize:(float)size {return NO;}
-(BOOL) updateFontColor:(ccColor3B)color {return NO;}
-(BOOL) updateElementColor:(ccColor3B)color {return NO;}
-(BOOL) updateElementColorSelected:(ccColor3B)color {return NO;}
-(BOOL) updateElementOpacity:(float)opacity {return NO;}
-(BOOL) updateElementOpacitySelected:(float)opacity {return NO;}
-(BOOL) updateTexture:(NSString *)textureFile {return NO;}
-(BOOL) updateTextureSelected:(NSString *)textureFile {return NO;}
-(BOOL) updateTextureOpacity:(float)opacity {return NO;}
-(BOOL) updateTextureOpacitySelected:(float)opacity {return NO;}
-(BOOL) updateAlign:(ALIGN_STYLE)alignStyle {return NO;}

@end
