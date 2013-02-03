#import "CCTableElementCenter.h"

@implementation CCTableElementCenter
@synthesize skinCenter;
@synthesize tableArea;
@synthesize tableTitle;
@synthesize tableHeader;
@synthesize tableFooter;
@synthesize tableGrid;

-(id) initWithSkin:(CCSkinCenter *)skin {
    if (self = [super init]) {
        self.skinCenter = skin;
        [self createTableArea];
        [self createTableTitle];
        [self createTableHeader];
        [self createTableFooter];
        [self createTableGrid];
    }
    return self;
}

-(void) dealloc {
   [self.skinCenter release];
   self.skinCenter = nil;
   [self.tableArea release];
   self.tableArea = nil;
   [self.tableTitle release];
   self.tableTitle = nil;
   [self.tableHeader release];
   self.tableHeader = nil;
   [self.tableFooter release];
   self.tableFooter = nil;
   [self.tableGrid release];
   self.tableGrid = nil;
    [super dealloc];
}

-(CCTableElement *) tableElementFromSkin:(SKIN_TYPE)type {
    if (type == SKIN_TABLE || type == SKIN_ROW || type == SKIN_ROW_EVEN || type == SKIN_ROW_CELL) return self.tableArea;
    if (type == SKIN_TITLE) return self.tableTitle;
    if (type == SKIN_HEADER || type == SKIN_HEADER_CELL) return self.tableHeader;
    if (type == SKIN_FOOTER) return self.tableFooter;
    if (type == SKIN_GRID) return self.tableGrid;
    return nil;
}

-(void) createTableArea {
    self.tableArea = [CCTableArea tableAreaWithSkin:self.skinCenter];
    [self addChild:self.tableArea z:10 tag:kTagTableArea];
}

-(void) createTableTitle {
    self.tableTitle = [CCTableTitle titleWithSkin:self.skinCenter];
    [self addChild:self.tableTitle z:1 tag:kTagTitle];
}

-(void) createTableHeader {
    self.tableHeader = [CCTableHeader hearderWithSkin:self.skinCenter];
    [self addChild:self.tableHeader z:1 tag:kTagHeader];
}

-(void) createTableFooter {
    self.tableFooter = [CCTableFooter footerWithSkin:self.skinCenter];
    [self addChild:self.tableFooter z:1 tag:kTagFooter];
}

-(void) createTableGrid {
    self.tableGrid = [CCTableGrid gridWithMaxRowCount:0 skin:self.skinCenter];
    [self addChild:self.tableGrid z:10 tag:kTagGridLine];
}

#pragma mark - update element
-(BOOL) updateElementWidth:(float)width type:(SKIN_TYPE)type {
    if (![self.skinCenter updateElementWidth:width type:type]) return NO;
    if (type == SKIN_TABLE) {
        [self.tableArea updateElementSize];
        [self.tableArea updateElementPosition];
        [self.tableArea updateElementTexture];
        [self.tableArea updateElementFrame];
        [self.tableHeader updateElementSize];
        [self.tableHeader updateElementPosition];
        [self.tableHeader updateElementFrame];
        [self.tableHeader updateElementTexture];
        [self.tableTitle updateElementContent];
        [self.tableTitle updateElementSize];
        [self.tableTitle updateElementPosition];
        [self.tableTitle updateElementFrame];
        [self.tableTitle updateElementTexture];
        [self.tableFooter updateElementSize];
        [self.tableFooter updateElementPosition];
        [self.tableFooter updateElementFrame];
        [self.tableFooter updateElementTexture];
        [self.tableFooter updateElementContent];
        [self.tableGrid updateElementFrame];
    }
    return YES;
}

-(BOOL) updateElementHeight:(float)height type:(SKIN_TYPE)type {
    if (![self.skinCenter updateElementHeight:height type:type]) return NO;
    if (type == SKIN_TABLE) {
        [self.tableArea updateElementSize];
        [self.tableArea updateElementTexture];
        [self.tableArea updateElementFrame];
        [self.tableHeader updateElementPosition];
        [self.tableHeader updateElementFrame];
        [self.tableTitle updateElementPosition];
        [self.tableTitle updateElementFrame];
        [self.tableFooter updateElementPosition];
        [self.tableFooter updateElementFrame];
        [self.tableGrid updateElementSize];
        [self.tableGrid updateElementFrame];
    }
    return YES;
}

-(BOOL) updateFontName:(NSString *)name type:(SKIN_TYPE)type {
    if (![self.skinCenter updateFontName:name type:type]) return NO;
    if (type == SKIN_TITLE) {
        [self.tableTitle updateElementSize];
        [self.tableTitle updateElementContent];
        [self.tableTitle updateElementTexture];
        [self.tableTitle updateElementFrame];
        
    }
    if (type == SKIN_HEADER) {
        [self.tableHeader updateElementSize];
        [self.tableHeader updateElementContent];
        [self.tableHeader updateElementTexture];
        [self.tableHeader updateElementFrame];
        
    }
    if (type == SKIN_FOOTER) {
        [self.tableFooter updateElementSize];
        [self.tableFooter updateElementContent];
        [self.tableFooter updateElementTexture];
        [self.tableFooter updateElementFrame];
    }
    return YES;
}

-(BOOL) updateFontSize:(float)size type:(SKIN_TYPE)type{
    if (![self.skinCenter updateFontSize:size type:type]) return NO;
    if (type == SKIN_TITLE) {
        [self.tableTitle updateElementSize];
        [self.tableTitle updateElementContent];
        [self.tableTitle updateElementTexture];
        [self.tableTitle updateElementFrame];
        
    }
    if (type == SKIN_HEADER) {
        [self.tableHeader updateElementSize];
        [self.tableHeader updateElementContent];
        [self.tableHeader updateElementTexture];
        [self.tableHeader updateElementFrame];
        [self.tableTitle updateElementPosition];
        [self.tableTitle updateElementContent];
        [self.tableTitle updateElementTexture];
        [self.tableTitle updateElementFrame];
        [self.tableGrid updateElementFrame];
    }
    if (type == SKIN_FOOTER) {
        [self.tableFooter updateElementSize];
        [self.tableFooter updateElementPosition];
        [self.tableFooter updateElementContent];
        [self.tableFooter updateElementTexture];
        [self.tableFooter updateElementFrame];
    }
    return YES;
}

-(BOOL) updateFontColor:(ccColor3B)color type:(SKIN_TYPE)type {
    if (![self.skinCenter updateFontColor:color type:type]) return NO;
    CCTableElement *tableElement = [self tableElementFromSkin:type];
    if (!tableElement) return NO;
    [tableElement updateElementContent];
    return YES;
}

-(BOOL) updateElementColor:(ccColor3B)color type:(SKIN_TYPE)type state:(BOOL)isNormal {
    BOOL result = isNormal ? [self.skinCenter updateElementColor:color type:type] : [self.skinCenter updateElementColorSelected:color type:type];
    if (!result) return NO;
    CCTableElement *tableElement = [self tableElementFromSkin:type];
    if (!tableElement) return NO;
    [tableElement updateElementColor];
    return YES;
}

-(BOOL) updateElementOpacity:(float)opacity type:(SKIN_TYPE)type state:(BOOL)isNormal {
    BOOL result = isNormal ? [self.skinCenter updateElementOpacity:opacity type:type] : [self.skinCenter updateElementOpacitySelected:opacity type:type];
    if (!result) return NO;
    CCTableElement *tableElement = [self tableElementFromSkin:type];
    if (!tableElement) return NO;
    [tableElement updateElementColor];
    return YES;
}

-(BOOL) updateElementTexture:(NSString *)textureFile type:(SKIN_TYPE)type state:(BOOL)isNormal {
    BOOL result = isNormal ? [self.skinCenter updateElementTexture:textureFile type:type] : [self.skinCenter updateElementTextureSelected:textureFile type:type];
    if (!result) return NO;
    CCTableElement *tableElement = [self tableElementFromSkin:type];
    if (!tableElement) return NO;
    [tableElement updateElementTexture];
    return YES;
}

-(BOOL) updateTextureOpacity:(float)opacity type:(SKIN_TYPE)type state:(BOOL)isNormal {
    BOOL result = isNormal ? [self.skinCenter updateTextureOpacity:opacity type:type] : [self.skinCenter updateTextureOpacitySelected:opacity type:type];
    if (!result) return NO;
    CCTableElement *tableElement = [self tableElementFromSkin:type];
    if (!tableElement) return NO;
    [tableElement updateElementTexture];
    return YES;
}

-(BOOL) updateFrameWidth:(float)width type:(SKIN_TYPE)type {
    if (![self.skinCenter updateFrameWidth:width type:type]) return NO;
    CCTableElement *tableElement = [self tableElementFromSkin:type];
    if (!tableElement) return NO;
    [tableElement updateElementFrame];
    return YES;
}

-(BOOL) updateFrameColor:(ccColor3B)color type:(SKIN_TYPE)type {
    if (![self.skinCenter updateFrameColor:color type:type]) return NO;
    CCTableElement *tableElement = [self tableElementFromSkin:type];
    if (!tableElement) return NO;
    [tableElement updateElementFrame];
    return YES;
}

-(BOOL) updateFrameOpacity:(float)opacity type:(SKIN_TYPE)type {
    if (![self.skinCenter updateFrameOpacity:opacity type:type]) return NO;
    CCTableElement *tableElement = [self tableElementFromSkin:type];
    if (!tableElement) return NO;
    [tableElement updateElementFrame];
    return YES;
}

-(BOOL) updateAlign:(ALIGN_STYLE)align type:(SKIN_TYPE)type {
    if (![self.skinCenter updateAlign:align type:type]) return NO;
    CCTableElement *tableElement = [self tableElementFromSkin:type];
    if (!tableElement) return NO;
    [tableElement updateElementContent];
    return YES;
}

@end
