#import "CCRowSkin.h"
#import "NSString+FontSize.h"

@implementation CCRowSkin

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
    self.fontName = kDefaultRowFontName;
    self.fontSize = kDefaultRowFontSize;
    self.fontColor = kDefaultRowFontColor;
    self.elementColor = kDefaultRowColorOddNormal;
    self.elementOpacity = kDefaultRowOddNormalOpacity;
    self.elementTexture = kDefaultRowOddNormalTextureFile;
    self.textureOpacity = kDefaultRowOddNormalTextureOpacity;
    self.elementOpacitySelected = kDefaultRowSelectedOpacity;
    self.elementTextureSelected = kDefaultRowSelectedTextureFile;
    self.textureOpacitySelected = kDefaultRowSelectedTextureOpacity;
    self.alignStyle = kDefaultRowAlign;
    [self updateElementHeight:0.0f];
}

-(void) updateSkinWithDict:(NSMutableDictionary *)skinDict {
    self.fontName = [skinDict objectForKey:@"RowFont"];
    self.fontSize = [[skinDict objectForKey:@"RowFontSize"] floatValue];
    NSArray *rowFontColorArray = [[skinDict objectForKey:@"RowFontColor"] componentsSeparatedByString:@","];
    self.fontColor = ccc3([rowFontColorArray[0] floatValue], [rowFontColorArray[1] floatValue], [rowFontColorArray[2] floatValue]);
    NSArray *rowColorOddNormalArray = [[skinDict objectForKey:@"RowColor"] componentsSeparatedByString:@","];
    self.elementColor = ccc3([rowColorOddNormalArray[0] floatValue], [rowColorOddNormalArray[1] floatValue], [rowColorOddNormalArray[2] floatValue]);
    self.elementOpacity = [[skinDict objectForKey:@"RowOpacity"] floatValue];
    self.elementTexture = [skinDict objectForKey:@"RowTextureFile"];
    self.textureOpacity = [[skinDict objectForKey:@"RowTextureOpacity"] floatValue];
    NSArray *rowColorSelectedArray = [[skinDict objectForKey:@"RowColorSelected"] componentsSeparatedByString:@","];
    self.elementColorSelected = ccc3([rowColorSelectedArray[0] floatValue], [rowColorSelectedArray[1] floatValue], [rowColorSelectedArray[2] floatValue]);
    self.elementOpacitySelected = [[skinDict objectForKey:@"RowColorSelectedOpacity"] floatValue];
    self.elementTextureSelected = [skinDict objectForKey:@"RowColorSelectedTextureFile"];
    self.textureOpacitySelected = [[skinDict objectForKey:@"RowColorSelectedTextureOpacity"] floatValue];
    self.alignStyle = [[skinDict objectForKey:@"RowAlign"] intValue];
    [self updateElementHeight:0.0f];
}

-(void) parseSkinToDict:(NSMutableDictionary *)skinDict {
    [skinDict setObject:self.fontName forKey:@"RowFont"];
    [skinDict setObject:[NSNumber numberWithFloat:self.fontSize] forKey:@"RowFontSize"];
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.fontColor.r, (float)self.fontColor.g, (float)self.fontColor.b] forKey:@"RowFontColor"];
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.elementColor.r, (float)self.elementColor.g, (float)self.elementColor.b] forKey:@"RowColor"];
    [skinDict setObject:[NSNumber numberWithFloat:self.elementOpacity] forKey:@"RowOpacity"];
    [skinDict setObject:self.elementTexture forKey:@"RowTextureFile"];
    [skinDict setObject:[NSNumber numberWithFloat:self.textureOpacity] forKey:@"RowTextureOpacity"];
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.elementColorSelected.r, (float)self.elementColorSelected.g, (float)self.elementColorSelected.b] forKey:@"RowColorSelected"];
    [skinDict setObject:[NSNumber numberWithFloat:self.elementOpacitySelected] forKey:@"RowSelectedOpacity"];
    [skinDict setObject:self.elementTextureSelected forKey:@"RowSelectedTextureFile"];
    [skinDict setObject:[NSNumber numberWithFloat:self.textureOpacitySelected] forKey:@"RowSelectedTextureOpacity"];
    [skinDict setObject:[NSNumber numberWithInt:self.alignStyle] forKey:@"RowAlign"];
}

#pragma mark - update property
-(BOOL) updateElementHeight:(float)height {
    self.elementHeight = [@"XXX" stringHeightWithFont:self.fontName fontSize:self.fontSize];
    return YES;
}

-(BOOL) updateElementWidth:(float)width {return NO;}
-(BOOL) updateFrameWidth:(float)width {return NO;}
-(BOOL) updateFrameColor:(ccColor3B)color {return NO;}
-(BOOL) updateFrameOpacity:(float)opacity {return NO;}

@end
