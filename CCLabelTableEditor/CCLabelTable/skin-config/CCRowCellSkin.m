#import "CCRowCellSkin.h"

@implementation CCRowCellSkin

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
    self.elementColor = kDefaultCellColorNormal;
    self.elementOpacity = kDefaultCellNormalOpacity;
    self.elementTexture = kDefaultCellNormalTextureFile;
    self.textureOpacity = kDefaultCellNormalTextureOpacity;
}

-(BOOL) updateFontName:(NSString *) fontName {return NO;}
-(BOOL) updateFontSize:(float) size {return NO;}
-(BOOL) updateFontColor:(ccColor3B) color {return NO;}
-(BOOL) updateFrameWidth:(float) width {return NO;}
-(BOOL) updateFrameColor:(ccColor3B) color {return NO;}
-(BOOL) updateFrameOpacity:(float) opacity {return NO;}
-(BOOL) updateElementColorSelected:(ccColor3B)color {return NO;}
-(BOOL) updateElementOpacitySelected:(float)opacity {return NO;}
-(BOOL) updateTextureSelected:(NSString *)textureFile {return NO;}
-(BOOL) updateTextureOpacitySelected:(float)opacity {return NO;}

-(void) updateSkinWithDict:(NSMutableDictionary *)skinDict {
    NSArray *cellColorNormalArray = [[skinDict objectForKey:@"CellColorNormal"] componentsSeparatedByString:@","];
    self.elementColor = ccc3([cellColorNormalArray[0] floatValue], [cellColorNormalArray[1] floatValue], [cellColorNormalArray[2] floatValue]);
    self.elementOpacity = [[skinDict objectForKey:@"CellNormalOpacity"] floatValue];
    self.elementTexture = [skinDict objectForKey:@"CellNormalTextureFile"];
    self.textureOpacity = [[skinDict objectForKey:@"CellNormalTextureOpacity"] floatValue];
}

-(void) parseSkinToDict:(NSMutableDictionary *)skinDict {
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.elementColor.r, (float)self.elementColor.g, (float)self.elementColor.b] forKey:@"CellColorNormal"];
    [skinDict setObject:[NSNumber numberWithFloat:self.elementOpacity] forKey:@"CellNormalOpacity"];
    [skinDict setObject:self.elementTexture forKey:@"CellNormalTextureFile"];
    [skinDict setObject:[NSNumber numberWithFloat:self.textureOpacity] forKey:@"CellNormalTextureOpacity"];
}

@end
