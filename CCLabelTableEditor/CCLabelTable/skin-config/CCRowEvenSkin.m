#import "CCRowEvenSkin.h"
#import "NSString+FontSize.h"

@implementation CCRowEvenSkin

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
    self.elementColor = kDefaultRowColorEvenNormal;
    self.elementOpacity = kDefaultRowEvenNormalOpacity;
    self.elementTexture = kDefaultRowEvenNormalTextureFile;
    self.textureOpacity = kDefaultRowEvenNormalTextureOpacity;
    [self updateElementHeight:0.0f];
}

-(void) updateSkinWithDict:(NSMutableDictionary *)skinDict {
    NSArray *rowColorEvenNormalArray = [[skinDict objectForKey:@"RowColorEven"] componentsSeparatedByString:@","];
    self.elementColor = ccc3([rowColorEvenNormalArray[0] floatValue], [rowColorEvenNormalArray[1] floatValue], [rowColorEvenNormalArray[2] floatValue]);
    self.elementOpacity = [[skinDict objectForKey:@"RowEvenOpacity"] floatValue];
    self.elementTexture = [skinDict objectForKey:@"RowEvenTextureFile"];
    self.textureOpacity = [[skinDict objectForKey:@"RowEvenTextureOpacity"] floatValue];
}

-(void) parseSkinToDict:(NSMutableDictionary *)skinDict {
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.elementColor.r, (float)self.elementColor.g, (float)self.elementColor.b] forKey:@"RowColorEven"];
    [skinDict setObject:[NSNumber numberWithFloat:self.elementOpacity] forKey:@"RowEvenOpacity"];
    [skinDict setObject:self.elementTexture forKey:@"RowEvenTextureFile"];
    [skinDict setObject:[NSNumber numberWithFloat:self.textureOpacity] forKey:@"RowEvenTextureOpacity"];
}

#pragma mark - update property
-(BOOL) updateFontName:(NSString *)fontName {return NO;}
-(BOOL) updateFontSize:(float)size {return NO;}
-(BOOL) updateFontColor:(ccColor3B)color {return NO;}
-(BOOL) updateElementColorSelected:(ccColor3B)color {return NO;}
-(BOOL) updateElementOpacitySelected:(float)opacity {return NO;}
-(BOOL) updateTextureSelected:(NSString *)textureFile {return NO;}
-(BOOL) updateTextureOpacitySelected:(float)opacity {return NO;}

@end
