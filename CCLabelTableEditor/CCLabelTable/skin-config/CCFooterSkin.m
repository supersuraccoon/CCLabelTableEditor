#import "CCFooterSkin.h"
#import "NSString+FontSize.h"

@implementation CCFooterSkin

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
    self.fontName = kDefaultFooterFontName;
    self.fontSize = kDefaultFooterFontSize;
    self.fontColor = kDefaultFooterFontColor;
    self.elementColor = kDefaultFooterColor;
    self.elementOpacity = kDefaultFooterOpacity;
    self.elementTexture = kDefaultFooterTextureFile;
    self.textureOpacity = kDefaultFooterTextureOpacity;
    self.frameColor = kDefaultFooterFrameColor;
    self.frameWidth = kDefaultFooterFrameWidth;
    self.frameOpacity = kDefaultFooterFrameOpacity;
    self.alignStyle = kDefaultFooterAlign;
    [self updateElementHeight:0.0f];
}

-(void) updateSkinWithDict:(NSMutableDictionary *)skinDict {
    self.fontName = [skinDict objectForKey:@"FooterFont"];
    self.fontSize = [[skinDict objectForKey:@"FooterFontSize"] floatValue];
    NSArray *footerFontColorArray = [[skinDict objectForKey:@"FooterFontColor"] componentsSeparatedByString:@","];
    self.fontColor = ccc3([footerFontColorArray[0] floatValue], [footerFontColorArray[1] floatValue], [footerFontColorArray[2] floatValue]);
    NSArray *footerColorArray = [[skinDict objectForKey:@"FooterColor"] componentsSeparatedByString:@","];
    self.elementColor = ccc3([footerColorArray[0] floatValue], [footerColorArray[1] floatValue], [footerColorArray[2] floatValue]);
    self.elementOpacity = [[skinDict objectForKey:@"FooterOpacity"] floatValue];
    self.elementTexture = [skinDict objectForKey:@"FooterTextureFile"];
    self.textureOpacity = [[skinDict objectForKey:@"FooterTextureOpacity"] floatValue];
    NSArray *footerFrameColorArray = [[skinDict objectForKey:@"FooterFrameColor"] componentsSeparatedByString:@","];
    self.frameColor = ccc3([footerFrameColorArray[0] floatValue], [footerFrameColorArray[1] floatValue], [footerFrameColorArray[2] floatValue]);
    self.frameWidth = [[skinDict objectForKey:@"FooterFrameWidth"] floatValue];
    self.frameOpacity = [[skinDict objectForKey:@"FooterFrameOpacity"] floatValue];
    self.alignStyle = [[skinDict objectForKey:@"FooterAlign"] intValue];
    [self updateElementHeight:0.0f];
}

-(void) parseSkinToDict:(NSMutableDictionary *)skinDict {
    [skinDict setObject:self.fontName forKey:@"FooterFont"];
    [skinDict setObject:[NSNumber numberWithFloat:self.fontSize] forKey:@"FooterFontSize"];
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.fontColor.r, (float)self.fontColor.g, (float)self.fontColor.b] forKey:@"FooterFontColor"];
    [skinDict setObject:self.elementTexture forKey:@"FooterTextureFile"];
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.elementColor.r, (float)self.elementColor.g, (float)self.elementColor.b] forKey:@"FooterColor"];
    [skinDict setObject:[NSNumber numberWithFloat:self.elementOpacity] forKey:@"FooterOpacity"];
    [skinDict setObject:[NSNumber numberWithFloat:self.textureOpacity] forKey:@"FooterTextureOpacity"];
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.frameColor.r, (float)self.frameColor.g, (float)self.frameColor.b] forKey:@"FooterFrameColor"];
    [skinDict setObject:[NSNumber numberWithFloat:self.frameWidth] forKey:@"FooterFrameWidth"];
    [skinDict setObject:[NSNumber numberWithFloat:self.frameOpacity] forKey:@"FooterFrameOpacity"];
    [skinDict setObject:[NSNumber numberWithInt:self.alignStyle] forKey:@"FooterAlign"];
}

#pragma mark - update property
-(BOOL) updateElementHeight:(float)height {
    self.elementHeight = [@"XXX" stringHeightWithFont:self.fontName fontSize:self.fontSize];
    return YES;
}

-(BOOL) updateElementWidth:(float)width {return NO;}
-(BOOL) updateElementColorSelected:(ccColor3B)color {return NO;}
-(BOOL) updateElementOpacitySelected:(float)opacity {return NO;}
-(BOOL) updateTextureSelected:(NSString *)textureFile {return NO;}
-(BOOL) updateTextureOpacitySelected:(float)opacity {return NO;}

@end
