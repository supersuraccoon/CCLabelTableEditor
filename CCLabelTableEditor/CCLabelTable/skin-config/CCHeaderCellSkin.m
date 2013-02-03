#import "CCHeaderCellSkin.h"

@implementation CCHeaderCellSkin

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
    self.elementColor = kDefaultHeaderCellColorNormal;
    self.elementOpacity = kDefaultHeaderCellNormalOpacity;
    self.elementTexture = kDefaultHeaderCellNormalTextureFile;
    self.textureOpacity = kDefaultHeaderCellNormalTextureOpacity;
}

-(void) updateSkinWithDict:(NSMutableDictionary *)skinDict {
    NSArray *headerCellColorNormalArray = [[skinDict objectForKey:@"HeaderCellColorNormal"] componentsSeparatedByString:@","];
    self.elementColor = ccc3([headerCellColorNormalArray[0] floatValue], [headerCellColorNormalArray[1] floatValue], [headerCellColorNormalArray[2] floatValue]);
    self.elementOpacity = [[skinDict objectForKey:@"HeaderCellOpacity"] floatValue];
    self.elementTexture = [skinDict objectForKey:@"HeaderCellNormalTextureFile"];
    self.textureOpacity = [[skinDict objectForKey:@"HeaderCellNormalTextureOpacity"] floatValue];
}

-(void) parseSkinToDict:(NSMutableDictionary *)skinDict {
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.elementColor.r, (float)self.elementColor.g, (float)self.elementColor.b] forKey:@"HeaderCellColorNormal"];
    [skinDict setObject:[NSNumber numberWithFloat:self.elementOpacitySelected] forKey:@"HeaderCellNormalOpacity"];
    [skinDict setObject:self.elementTexture forKey:@"HeaderCellNormalTextureFile"];
    [skinDict setObject:[NSNumber numberWithFloat:self.textureOpacity] forKey:@"HeaderCellNormalTextureOpacity"];
}

#pragma mark - update property
-(BOOL) updateElementWidth:(float)width {return NO;}
-(BOOL) updateElementHeight:(float)height {return NO;}
-(BOOL) updateElementColorSelected:(ccColor3B)color {return NO;};
-(BOOL) updateElementOpacitySelected:(float)opacity {return NO;};
-(BOOL) updateTextureSelected:(NSString *)textureFile {return NO;};
-(BOOL) updateTextureOpacitySelected:(float)opacity {return NO;};
-(BOOL) updateFontName:(NSString *)fontName {return NO;}
-(BOOL) updateFontSize:(float)size {return NO;}
-(BOOL) updateFontColor:(ccColor3B)color {return NO;}
-(BOOL) updateFrameWidth:(float)width {return NO;}
-(BOOL) updateFrameColor:(ccColor3B)color {return NO;}
-(BOOL) updateFrameOpacity:(float)opacity {return NO;}
-(BOOL) updateAlign:(ALIGN_STYLE)alignStyle {return NO;}

@end
