#import "CCTableAreaSkin.h"

@implementation CCTableAreaSkin
@synthesize allowMultiSelectRow;
@synthesize allowEditCell;

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
    self.elementWidth = kDefaultTableWidth;
    self.elementHeight = kDefaultTableHeight;
    self.elementColor = kDefaultTableColor;
    self.elementOpacity = kDefaultTableOpacity;
    self.elementTexture = kDefaultTableTextureFile;
    self.elementOpacity = kDefaultTableTextureOpacity;
    self.frameColor = kDefaultTableFrameColor;
    self.frameWidth = kDefaultTableFrameWidth;
    self.frameOpacity = kDefaultTableFrameOpacity;
    self.allowEditCell = kDefaultAllowEditCellFlag;
    self.allowMultiSelectRow = kDefaultMultiSelectFlag;
}

-(void) updateConfigWithDict:(NSMutableDictionary *)skinDict {
    self.elementWidth = [[skinDict objectForKey:@"TableWidth"] floatValue];
    self.elementHeight = [[skinDict objectForKey:@"TableHeight"] floatValue];
    self.allowEditCell = [[skinDict objectForKey:@"AllowEditCell"] floatValue];
    self.allowMultiSelectRow = [[skinDict objectForKey:@"AllowMultiSelectRow"] floatValue];
}

-(void) updateSkinWithDict:(NSMutableDictionary *)skinDict {
    NSArray *tableColorArray = [[skinDict objectForKey:@"TableColor"] componentsSeparatedByString:@","];
    self.elementColor = ccc3([tableColorArray[0] floatValue], [tableColorArray[1] floatValue], [tableColorArray[2] floatValue]);
    self.elementOpacity = [[skinDict objectForKey:@"TableOpacity"] floatValue];
    self.elementTexture = [skinDict objectForKey:@"TableTextureFile"];
    self.elementOpacity = [[skinDict objectForKey:@"TableTextureOpacity"] floatValue];
}

-(void) parseSkinToDict:(NSMutableDictionary *)skinDict {
    [skinDict setObject:[NSNumber numberWithFloat:self.elementWidth] forKey:@"TableWidth"];
    [skinDict setObject:[NSNumber numberWithFloat:self.elementHeight] forKey:@"TableHeight"];
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.elementColor.r, (float)self.elementColor.g, (float)self.elementColor.b] forKey:@"TableColor"];
    [skinDict setObject:[NSNumber numberWithFloat:self.elementOpacity] forKey:@"TableOpacity"];
    [skinDict setObject:self.elementTexture forKey:@"TableTextureFile"];
    [skinDict setObject:[NSNumber numberWithFloat:self.textureOpacity] forKey:@"TableTextureOpacity"];
    [skinDict setObject:[NSNumber numberWithBool:self.allowEditCell] forKey:@"AllowEditCell"];
    [skinDict setObject:[NSNumber numberWithBool:self.allowMultiSelectRow] forKey:@"AllowMultiSelectRow"];
}

#pragma mark - update property
-(BOOL) updateElementWidth:(float)width {
    if (self.elementWidth == width) return NO;
    self.elementWidth = width;
    return YES;
}

-(BOOL) updateElementHeight:(float)height {
    if (self.elementHeight == height) return NO;
    self.elementHeight = height;
    return YES;
}

-(BOOL) updateFontName:(NSString *)fontName {return NO;}
-(BOOL) updateFontSize:(float)size {return NO;}
-(BOOL) updateFontColor:(ccColor3B)color {return NO;}
-(BOOL) updateElementColorSelected:(ccColor3B)color {return NO;}
-(BOOL) updateElementOpacitySelected:(float)opacity {return NO;}
-(BOOL) updateTextureSelected:(NSString *)textureFile {return NO;}
-(BOOL) updateTextureOpacitySelected:(float)opacity {return NO;}
-(BOOL) updateFrameWidth:(float)width {return NO;}
-(BOOL) updateFrameColor:(ccColor3B)color {return NO;}
-(BOOL) updateFrameOpacity:(float)opacity {return NO;}
-(BOOL) updateAlign:(ALIGN_STYLE)alignStyle {return NO;}

@end
