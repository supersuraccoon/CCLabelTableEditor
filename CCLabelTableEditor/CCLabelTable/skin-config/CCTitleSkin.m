#import "CCTitleSkin.h"
#import "NSString+FontSize.h"

@implementation CCTitleSkin
@synthesize titleString;
@synthesize allowEditTitle;

#pragma mark init/dealloc
- (id) init {
    if((self=[super init])) {
        [self initDefaultSkin];
    }
    return self;
}

- (void) dealloc {
    [self.titleString release];
    self.titleString = nil;
    [super dealloc];
}

-(void) initDefaultSkin {
    self.titleString = kDefaultTitleString;
    self.fontName = kDefaultTitleFontName;
    self.fontSize = kDefaultTitleFontSize;
    self.fontColor = kDefaultTitleFontColor;
    self.elementColor = kDefaultTitleColor;
    self.elementOpacity = kDefaultTitleOpacity;
    self.elementTexture = kDefaultTitleTextureFile;
    self.textureOpacity = kDefaultTitleTextureOpacity;
    self.frameColor = kDefaultTitleFrameColor;
    self.frameWidth = kDefaultTitleFrameWidth;
    self.frameOpacity = kDefaultTitleFrameOpacity;
    self.alignStyle = kDefaultTitleAlign;
    self.allowEditTitle = kDefaultAllowEditTitle;
    [self updateElementHeight:0.0f];
}

-(void) updateConfigWithDict:(NSMutableDictionary *)skinDict {
    self.allowEditTitle = [[skinDict objectForKey:@"AllowEditTitle"] boolValue];
}

-(void) updateSkinWithDict:(NSMutableDictionary *)skinDict {
    self.titleString = [skinDict objectForKey:@"TitleString"];
    self.fontName = [skinDict objectForKey:@"TitleFont"];
    self.fontSize = [[skinDict objectForKey:@"TitleFontSize"] floatValue];
    NSArray *titleFontColorArray = [[skinDict objectForKey:@"TitleFontColor"] componentsSeparatedByString:@","];
    self.fontColor = ccc3([titleFontColorArray[0] floatValue], [titleFontColorArray[1] floatValue], [titleFontColorArray[2] floatValue]);
    NSArray *titleColorArray = [[skinDict objectForKey:@"TitleColor"] componentsSeparatedByString:@","];
    self.elementColor = ccc3([titleColorArray[0] floatValue], [titleColorArray[1] floatValue], [titleColorArray[2] floatValue]);
    self.elementOpacity = [[skinDict objectForKey:@"TitleOpacity"] floatValue];
    self.elementTexture = [skinDict objectForKey:@"TitleTextureFile"];
    self.textureOpacity = [[skinDict objectForKey:@"TitleTextureOpacity"] floatValue];
    NSArray *titleFrameColorArray = [[skinDict objectForKey:@"TitleFrameColor"] componentsSeparatedByString:@","];
    self.frameColor = ccc3([titleFrameColorArray[0] floatValue], [titleFrameColorArray[1] floatValue], [titleFrameColorArray[2] floatValue]);
    self.frameWidth = [[skinDict objectForKey:@"TitleFrameWidth"] floatValue];
    self.frameOpacity = [[skinDict objectForKey:@"TitleFrameOpacity"] floatValue];
    self.alignStyle = [[skinDict objectForKey:@"TitleAlign"] intValue];
    [self updateElementHeight:0.0f];
}

-(void) parseSkinToDict:(NSMutableDictionary *)skinDict {
    [skinDict setObject:self.titleString forKey:@"TitleString"];
    [skinDict setObject:self.fontName forKey:@"TitleFont"];
    [skinDict setObject:[NSNumber numberWithFloat:self.fontSize] forKey:@"TitleFontSize"];
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.fontColor.r, (float)self.fontColor.g, (float)self.fontColor.b] forKey:@"TitleFontColor"];
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.elementColor.r, (float)self.elementColor.g, (float)self.elementColor.b] forKey:@"TitleColor"];
    [skinDict setObject:[NSNumber numberWithFloat:self.elementOpacity] forKey:@"TitleOpacity"];
    [skinDict setObject:self.elementTexture forKey:@"TitleTextureFile"];
    [skinDict setObject:[NSNumber numberWithFloat:self.textureOpacity] forKey:@"TitleTextureOpacity"];
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.frameColor.r, (float)self.frameColor.g, (float)self.frameColor.b] forKey:@"TitleFrameColor"];
    [skinDict setObject:[NSNumber numberWithFloat:self.frameWidth] forKey:@"TitleFrameWidth"];
    [skinDict setObject:[NSNumber numberWithFloat:self.frameOpacity] forKey:@"TitleFrameOpacity"];
    [skinDict setObject:[NSNumber numberWithInt:self.alignStyle] forKey:@"TitleAlign"];
    [skinDict setObject:[NSNumber numberWithBool:self.allowEditTitle] forKey:@"AllowEditTitle"];
}

#pragma mark - update property
-(BOOL) updateTitleString:(NSString *)string {
    if ([self.titleString isEqualToString:string]) return NO;
    self.titleString = string;
    return YES;
}

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
