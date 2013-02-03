#import "CCHeaderSkin.h"
#import "NSString+FontSize.h"

@implementation CCHeaderSkin
@synthesize headerNameArray;
@synthesize columnWidthArray;
@synthesize allowEditHeaderName;
@synthesize allowAdjustColumnWidth;

#pragma mark init/dealloc
- (id) init {
    if((self = [super init])) {
        [self initDefaultSkin];
    }
    return self;
}

- (void) dealloc {
    [self.headerNameArray removeAllObjects];
    [self.headerNameArray release];
    self.headerNameArray = nil;
    [self.columnWidthArray removeAllObjects];
    [self.columnWidthArray release];
    self.columnWidthArray = nil;
    [super dealloc];
}

-(void) initDefaultSkin {
    self.headerNameArray = [[NSMutableArray alloc] init];
    self.columnWidthArray = [[NSMutableArray alloc] init];
    self.fontName = kDefaultHeaderFontName;
    self.fontSize = kDefaultHeaderFontSize;
    self.fontColor = kDefaultHeaderFontColor;
    self.elementColor = kDefaultHeaderColor;
    self.elementOpacity = kDefaultHeaderOpacity;
    self.elementTexture = kDefaultHeaderTextureFile;
    self.textureOpacity = kDefaultHeaderTextureOpacity;
    self.frameColor = kDefaultHeaderFrameColor;
    self.frameWidth = kDefaultHeaderFrameWidth;
    self.frameOpacity = kDefaultHeaderFrameOpacity;
    self.alignStyle = kDefaultHeaderAlign;
    self.allowEditHeaderName = kDefaultAllowEditHeaderNameFlag;
    self.allowAdjustColumnWidth = kDefaultAllowAdjustColumnWidthFlag;
    [self updateElementHeight:0.0f];
}

-(void) updateConfigWithDict:(NSMutableDictionary *)skinDict {
    self.headerNameArray = [[NSMutableArray alloc] initWithArray:[[skinDict objectForKey:@"HeaderNameArray"] componentsSeparatedByString:@","]];
    self.columnWidthArray = [[NSMutableArray alloc] initWithArray:[[skinDict objectForKey:@"ColumnWidthArray"] componentsSeparatedByString:@","]];
    self.allowEditHeaderName = [[skinDict objectForKey:@"AllowEditHeaderName"] boolValue];
    self.allowAdjustColumnWidth = [[skinDict objectForKey:@"AllowAdjustColumnWidth"] boolValue];
}

-(void) updateSkinWithDict:(NSMutableDictionary *)skinDict {
    self.fontName = [skinDict objectForKey:@"HeaderFont"];
    self.fontSize = [[skinDict objectForKey:@"HeaderFontSize"] floatValue];
    NSArray *headerFontColorArray = [[skinDict objectForKey:@"HeaderFontColor"] componentsSeparatedByString:@","];
    self.fontColor = ccc3([headerFontColorArray[0] floatValue], [headerFontColorArray[1] floatValue], [headerFontColorArray[2] floatValue]);
    NSArray *headerColorArray = [[skinDict objectForKey:@"HeaderColor"] componentsSeparatedByString:@","];
    self.elementColor = ccc3([headerColorArray[0] floatValue], [headerColorArray[1] floatValue], [headerColorArray[2] floatValue]);
    self.elementOpacity = [[skinDict objectForKey:@"HeaderOpacity"] floatValue];
    self.elementTexture = [skinDict objectForKey:@"HeaderTextureFile"];
    self.textureOpacity = [[skinDict objectForKey:@"HeaderTextureOpacity"] floatValue];
    NSArray *headerFrameColorArray = [[skinDict objectForKey:@"HeaderFrameColor"] componentsSeparatedByString:@","];
    self.frameColor = ccc3([headerFrameColorArray[0] floatValue], [headerFrameColorArray[1] floatValue], [headerFrameColorArray[2] floatValue]);
    self.frameWidth = [[skinDict objectForKey:@"HeaderFrameWidth"] floatValue];
    self.frameOpacity = [[skinDict objectForKey:@"HeaderFrameOpacity"] floatValue];
    self.alignStyle = [[skinDict objectForKey:@"HeaderAlign"] intValue];
    [self updateElementHeight:0.0f];
}

-(void) parseSkinToDict:(NSMutableDictionary *)skinDict {
    NSMutableString *headerColumnNameString = [[NSMutableString alloc] init];
    for (int i = 0; i < [self.headerNameArray count] - 1; i++) {
        [headerColumnNameString appendString:[NSString stringWithFormat:@"%@,", [self.headerNameArray objectAtIndex:i]]];
    }
    [headerColumnNameString appendString:[NSString stringWithFormat:@"%@", [self.headerNameArray lastObject]]];
    [skinDict setObject:headerColumnNameString forKey:@"HeaderNameArray"];
    NSMutableString *headerColumnWidthString = [[NSMutableString alloc] init];
    for (int i = 0; i < [self.columnWidthArray count] - 1; i++) {
        [headerColumnWidthString appendString:[NSString stringWithFormat:@"%@,", [self.columnWidthArray objectAtIndex:i]]];
    }
    [headerColumnWidthString appendString:[NSString stringWithFormat:@"%@", [self.columnWidthArray lastObject]]];
    [skinDict setObject:headerColumnWidthString forKey:@"ColumnWidthArray"];
    [skinDict setObject:self.fontName forKey:@"HeaderFont"];
    [skinDict setObject:[NSNumber numberWithFloat:self.fontSize] forKey:@"HeaderFontSize"];
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.fontColor.r, (float)self.fontColor.g, (float)self.fontColor.b] forKey:@"HeaderFontColor"];
    [skinDict setObject:self.elementTexture forKey:@"HeaderTextureFile"];
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.elementColor.r, (float)self.elementColor.g, (float)self.elementColor.b] forKey:@"HeaderColor"];
    [skinDict setObject:[NSNumber numberWithFloat:self.elementOpacity] forKey:@"HeaderOpacity"];
    [skinDict setObject:self.elementTexture forKey:@"HeaderTextureFile"];
    [skinDict setObject:[NSNumber numberWithFloat:self.textureOpacity] forKey:@"HeaderTextureOpacity"];
    [skinDict setObject:[NSString stringWithFormat:@"%0.1f, %0.1f, %0.1f", (float)self.frameColor.r, (float)self.frameColor.g, (float)self.frameColor.b] forKey:@"HeaderFrameColor"];
    [skinDict setObject:[NSNumber numberWithFloat:self.frameWidth] forKey:@"HeaderFrameWidth"];
    [skinDict setObject:[NSNumber numberWithFloat:self.frameOpacity] forKey:@"HeaderFrameOpacity"];
    [skinDict setObject:[NSNumber numberWithInt:self.alignStyle] forKey:@"HeaderAlign"];
    [skinDict setObject:[NSNumber numberWithBool:self.allowEditHeaderName] forKey:@"AllowEditHeaderName"];
    [skinDict setObject:[NSNumber numberWithBool:self.allowAdjustColumnWidth] forKey:@"AllowAdjustColumnWidth"];
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

-(BOOL) updateColumnWidthAt:(int)index width:(float)width {
    if (index > [self.columnWidthArray count]) return NO;
    float curWidth = [[self.columnWidthArray objectAtIndex:index - 1] floatValue];
    if (curWidth == width) return NO;
    [self.columnWidthArray replaceObjectAtIndex:index - 1 withObject:[NSNumber numberWithFloat:width]];
    return YES;
}

-(BOOL) updateHeaderNameArray:(NSArray *)headerArray columnWidthArray:(NSArray *)columnArray {
    if ([headerArray count] <= 0 || [columnArray count] <= 0) return NO;
    if ([headerArray count] != [columnArray count]) return NO;
    [self.headerNameArray addObjectsFromArray:headerArray];
    [self.columnWidthArray addObjectsFromArray:columnArray];
    return YES;
}

-(BOOL) resetHeaderContent {
    if ([self.headerNameArray count] <= 0 || [self.columnWidthArray count] <= 0) return NO;
    [self.headerNameArray removeAllObjects];
    [self.columnWidthArray removeAllObjects];
    return YES;    
}

-(BOOL) updateHeaderNameAt:(int)index name:(NSString *)name {
    if ([name length] <= 0) return NO;
    if (index > [self.headerNameArray count]) return NO;
    NSString *curHeaderName = [self.headerNameArray objectAtIndex:index - 1];
    if ([curHeaderName isEqualToString:name]) return NO;
    [self.headerNameArray replaceObjectAtIndex:index - 1 withObject:name];
    return YES;
}

@end
