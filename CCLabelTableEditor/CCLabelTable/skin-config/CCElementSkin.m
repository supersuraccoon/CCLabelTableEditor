#import "CCElementSkin.h"

@implementation CCElementSkin
@synthesize elementWidth;
@synthesize elementHeight;
@synthesize elementColor;
@synthesize elementOpacity;
@synthesize elementTexture;
@synthesize textureOpacity;
@synthesize fontName;
@synthesize fontSize;
@synthesize fontColor;
@synthesize frameColor;
@synthesize frameWidth;
@synthesize frameOpacity;
@synthesize elementColorSelected;
@synthesize elementOpacitySelected;
@synthesize elementTextureSelected;
@synthesize textureOpacitySelected;
@synthesize alignStyle;

#pragma mark init/dealloc
- (id) init {
    if((self=[super init])) {}
    return self;
}

- (void) dealloc {
    [self.elementTexture release];
    self.elementTexture = nil;
    [self.elementTextureSelected release];
    self.elementTextureSelected = nil;
    [super dealloc];
}

-(void) initDefaultSkin {CCLOG(@"override me!");}
-(void) updateSkinWithDict:(NSMutableDictionary *)skinDict {CCLOG(@"override me!");}
-(void) updateConfigWithDict:(NSMutableDictionary *)skinDict {CCLOG(@"override me!");}
-(void) parseSkinToDict:(NSMutableDictionary *)skinDict {CCLOG(@"override me!");}


-(BOOL) updateElementWidth:(float)width {CCLOG(@"override me!"); return NO;}
-(BOOL) updateElementHeight:(float)height {CCLOG(@"override me!"); return NO;}

-(BOOL) updateElementColor:(ccColor3B)color {
    if (color.r == self.elementColor.r &&
        color.g == self.elementColor.g &&
        color.b == self.elementColor.b) return NO;
    self.elementColor = color;
    return YES;
}

-(BOOL) updateElementOpacity:(float) opacity {
    if (opacity == self.elementOpacity) return NO;
    self.elementOpacity = opacity;
    return YES;
}

-(BOOL) updateTexture:(NSString *) textureFile {
    if ([textureFile isEqualToString:self.elementTexture]) return NO;
    self.elementTexture = textureFile;
    return YES;
}

-(BOOL) updateTextureOpacity:(float) opacity {
    if (opacity == self.textureOpacity) return NO;
    self.textureOpacity = opacity;
    return YES;
}

-(BOOL) updateElementColorSelected:(ccColor3B)color {
    if (color.r == self.elementColorSelected.r &&
        color.g == self.elementColorSelected.g &&
        color.b == self.elementColorSelected.b) return NO;
    self.elementColorSelected = color;
    return YES;
}

-(BOOL) updateElementOpacitySelected:(float) opacity {
    if (opacity == self.elementOpacitySelected) return NO;
    self.elementOpacitySelected = opacity;
    return YES;
}

-(BOOL) updateTextureSelected:(NSString *) textureFile {
    if ([textureFile isEqualToString:self.elementTextureSelected]) return NO;
    self.elementTextureSelected = textureFile;
    return YES;
}

-(BOOL) updateTextureOpacitySelected:(float) opacity {
    if (opacity == self.textureOpacitySelected) return NO;
    self.textureOpacitySelected = opacity;
    return YES;
}

-(BOOL) updateFontName:(NSString *) name {
    if ([name isEqualToString:self.fontName]) return NO;
    self.fontName = name;
    return YES;
}

-(BOOL) updateFontSize:(float) size {
    if (size == self.fontSize) return NO;
    self.FontSize = size;
    return YES;
}

-(BOOL) updateFontColor:(ccColor3B) color {
    if (color.r == self.fontColor.r &&
        color.g == self.fontColor.g &&
        color.b == self.fontColor.b) return NO;
    self.fontColor = color;
    return YES;
}

-(BOOL) updateFrameWidth:(float) width {
    if (width == self.frameWidth) return NO;
    self.frameWidth = width;
    return YES;
}

-(BOOL) updateFrameColor:(ccColor3B) color {
    if (color.r == self.frameColor.r &&
        color.g == self.frameColor.g &&
        color.b == self.frameColor.b) return NO;
    self.frameColor = color;
    return YES;
}

-(BOOL) updateFrameOpacity:(float) opacity {
    if (opacity == self.frameOpacity) return NO;
    self.frameOpacity = opacity;
    return YES;
}

-(BOOL) updateAlign:(ALIGN_STYLE) align {
    if (align == self.alignStyle) return NO;
    self.alignStyle = align;
    return YES;
}

@end
