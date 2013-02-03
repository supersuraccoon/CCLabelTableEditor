#import "CCSkinCenter.h"

@implementation CCSkinCenter
@synthesize tableAreaSkin;
@synthesize titleSkin;
@synthesize headerSkin;
@synthesize headerCellSkin;
@synthesize rowSkin;
@synthesize rowEvenSkin;
@synthesize rowCellSkin;
@synthesize footerSkin;
@synthesize gridSkin;

#pragma mark - skin
-(id) initDefaultSkin {
    if (self == [super init]) {
        self.tableAreaSkin = [[CCTableAreaSkin alloc] init];
        self.titleSkin = [[CCTitleSkin alloc] init];
        self.headerSkin = [[CCHeaderSkin alloc] init];
        self.headerCellSkin = [[CCHeaderCellSkin alloc] init];
        self.rowSkin = [[CCRowSkin alloc] init];
        self.rowEvenSkin = [[CCRowEvenSkin alloc] init];
        self.rowCellSkin = [[CCRowCellSkin alloc] init];
        self.footerSkin = [[CCFooterSkin alloc] init];
        self.gridSkin = [[CCGridSkin alloc] init];
    }
    return self;
}

-(void) dealloc {
    [self.tableAreaSkin release];
    self.tableAreaSkin = nil;
    [self.titleSkin release];
    self.titleSkin = nil;
    [self.headerSkin release];
    self.headerSkin = nil;
    [self.headerCellSkin release];
    self.headerCellSkin = nil;
    [self.rowSkin release];
    self.rowSkin = nil;
    [self.rowEvenSkin release];
    self.rowEvenSkin = nil;
    [self.rowCellSkin release];
    self.rowCellSkin = nil;
    [self.footerSkin release];
    self.footerSkin = nil;
    [self.gridSkin release];
    self.gridSkin = nil;
    [super dealloc];
}

-(CCElementSkin *) skinElementFromType:(SKIN_TYPE)type {
    if (type == SKIN_TABLE) return self.tableAreaSkin;
    if (type == SKIN_TITLE) return self.titleSkin;
    if (type == SKIN_HEADER) return self.headerSkin;
    if (type == SKIN_HEADER_CELL) return self.headerCellSkin;
    if (type == SKIN_ROW) return self.rowSkin;
    if (type == SKIN_ROW_EVEN) return self.rowEvenSkin;
    if (type == SKIN_ROW_CELL) return self.rowCellSkin;
    if (type == SKIN_FOOTER) return self.footerSkin;
    if (type == SKIN_GRID) return self.gridSkin;
    return nil;
}

-(void) loadSkinWithFile:(NSString *)skinFileName {
    NSMutableDictionary* skinDict = [self skinDictFromFile:skinFileName];
    [self.tableAreaSkin updateConfigWithDict:skinDict];
    [self.headerSkin updateConfigWithDict:skinDict];
    [self updateSkinWithFile:skinFileName];
}

-(void) updateSkinWithFile:(NSString *)skinFileName {
    NSMutableDictionary* skinDict = [self skinDictFromFile:skinFileName];
    [self.tableAreaSkin updateSkinWithDict:skinDict];
    [self.titleSkin updateSkinWithDict:skinDict];
    [self.headerSkin updateSkinWithDict:skinDict];
    [self.headerCellSkin updateSkinWithDict:skinDict];
    [self.rowSkin updateSkinWithDict:skinDict];
    [self.rowEvenSkin updateSkinWithDict:skinDict];
    [self.rowCellSkin updateSkinWithDict:skinDict];
    [self.footerSkin updateSkinWithDict:skinDict];
    [self.gridSkin updateSkinWithDict:skinDict];
}

-(BOOL) exportTableSkinToFile:(NSString *)fileName {
    NSMutableDictionary* skinDict = [[NSMutableDictionary alloc] init];
    // key
    [skinDict setObject:@"CCLabelTable" forKey:@"Identity"];
    [self.tableAreaSkin parseSkinToDict:skinDict];
    [self.titleSkin parseSkinToDict:skinDict];
    [self.headerCellSkin parseSkinToDict:skinDict];
    [self.headerSkin parseSkinToDict:skinDict];
    [self.rowSkin parseSkinToDict:skinDict];
    [self.rowEvenSkin parseSkinToDict:skinDict];
    [self.rowCellSkin parseSkinToDict:skinDict];
    [self.footerSkin parseSkinToDict:skinDict];
    [self.gridSkin parseSkinToDict:skinDict];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingFormat:@"/%@.table", fileName];
    if (![skinDict writeToFile:filePath atomically:YES]) {
        CCLOG(@"Export Error!");
        return NO;
    }
    return YES;
}

#pragma mark - update property
-(BOOL) updateElementContent:(NSString *)content type:(SKIN_TYPE)type {
    return NO;
}

-(BOOL) updateElementWidth:(float)width type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    if (![elementSkin updateElementWidth:width]) return NO;
    return YES;
}

-(BOOL) updateElementHeight:(float)height type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    if (![elementSkin updateElementHeight:height]) return NO;
    return YES;
}

-(BOOL) updateFontName:(NSString *)name type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    if (![elementSkin updateFontName:name]) return NO;
    [elementSkin updateElementHeight:0.0f];
    return YES;
}

-(BOOL) updateFontSize:(float)size type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    if (![elementSkin updateFontSize:size]) return NO;
    [elementSkin updateElementHeight:0.0f];
    return YES;
}

-(BOOL) updateFontColor:(ccColor3B)color type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    return [elementSkin updateFontColor:color];
}

#pragma mark - element
-(BOOL) updateElementColor:(ccColor3B)color type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    return [elementSkin updateElementColor:color];
}

-(BOOL) updateElementColorSelected:(ccColor3B)color type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    return [elementSkin updateElementColorSelected:color];
}

-(BOOL) updateElementOpacity:(float)opacity type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    return [elementSkin updateElementOpacity:opacity];
}

-(BOOL) updateElementOpacitySelected:(float)opacity type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    return [elementSkin updateElementOpacitySelected:opacity];
}

-(BOOL) updateElementTexture:(NSString *)textureFile type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    return [elementSkin updateTexture:textureFile];
}

-(BOOL) updateElementTextureSelected:(NSString *)textureFile type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    return [elementSkin updateTextureSelected:textureFile];
}

-(BOOL) updateTextureOpacity:(float)opacity type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    return [elementSkin updateTextureOpacity:opacity];
}

-(BOOL) updateTextureOpacitySelected:(float)opacity type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    return [elementSkin updateTextureOpacitySelected:opacity];
}

#pragma mark - frame
-(BOOL) updateFrameWidth:(float)width type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    return [elementSkin updateFrameWidth:width];
}

-(BOOL) updateFrameColor:(ccColor3B)color type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    return [elementSkin updateFrameColor:color];
}

-(BOOL) updateFrameOpacity:(float)opacity type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    return [elementSkin updateFrameOpacity:opacity];
}

#pragma mark - align
-(BOOL) updateAlign:(ALIGN_STYLE)align type:(SKIN_TYPE)type {
    CCElementSkin *elementSkin = [self skinElementFromType:type];
    if (!elementSkin) return NO;
    return [elementSkin updateAlign:align];
}

-(NSMutableDictionary *) skinDictFromFile:(NSString *)skinFileName {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingFormat:@"/%@", skinFileName];
    NSMutableDictionary* skinDict =  [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSAssert([[skinDict objectForKey:@"Identity"] isEqualToString:@"CCLabelTable"], @"Invalid layout file");
    return skinDict;
}

@end
