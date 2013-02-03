#import "CCLabelTable.h"

@interface CCLabelTable ()
-(void) initData;
-(void) createTableGestureLayer;
-(void) updatePageInfo:(int)rowCount;
-(int) globalRowIndex:(int)rowTag;
-(float) tableRealHeight;
@end

@implementation CCLabelTable
@synthesize dataSource;
@synthesize skinCenter;
@synthesize tableElementCenter;
@synthesize pageCount;
@synthesize pageMaxRowCount;
@synthesize currentPage;
@synthesize gestureLayer;

#pragma mark - init && dealloc
+(id) tableWithDataSource:(id)source color:(ccColor4B)color width:(int)width height:(int)height title:(NSString *)title header:(NSArray *)headerArray columnWidth:(NSArray *)columnArray {
    return [[[self alloc] initWithDataSource:source color:color width:width height:height title:title header:headerArray columnWidth:columnArray skinFile:@""] autorelease];
}

+(id) tableWithDataSource:(id)source tableSkinFile:(NSString *)tableSkinFile {
    return [[[self alloc] initWithDataSource:source color:ccc4(0, 0, 0, 0) width:0 height:0 title:@"" header:nil columnWidth:nil skinFile:tableSkinFile] autorelease];
}

-(id) initWithDataSource:(id)source color:(ccColor4B)color width:(int)width height:(int)height title:(NSString *)title header:(NSArray *)headerArray columnWidth:(NSArray *)columnArray skinFile:(NSString *)skinFile {
    if ((self = [super initWithColor:ccc4(0, 0, 0, 0)])) {
        self.ignoreAnchorPointForPosition = NO;
        self.dataSource = source;
        
        self.skinCenter = [[CCSkinCenter alloc] initDefaultSkin];
        if (skinFile == @"") {
            [self.skinCenter.tableAreaSkin updateElementWidth:width];
            [self.skinCenter.tableAreaSkin updateElementHeight:height];
            [self.skinCenter.tableAreaSkin updateElementColor:ccc3(color.r, color.g, color.b)];
            [self.skinCenter.tableAreaSkin updateElementOpacity:color.a];
            [self.skinCenter.titleSkin updateTitleString:title];
            [self.skinCenter.headerSkin resetHeaderContent];
            [self.skinCenter.headerSkin updateHeaderNameArray:headerArray columnWidthArray:columnArray];
        }
        else {
            [self.skinCenter loadSkinWithFile:skinFile];
        }
        self.contentSize = CGSizeMake(self.skinCenter.tableAreaSkin.elementWidth,
                                      self.skinCenter.tableAreaSkin.elementHeight);
        [self initData];
        self.tableElementCenter = [[CCTableElementCenter alloc] initWithSkin:self.skinCenter];
        [self addChild:self.tableElementCenter z:999];
        [self createTableGestureLayer];
        [self updatePageInfo:0];
        [self reloadTable];
    }
    return self;
}

-(void) initData {
    self.currentPage = kDefaultPage;
    self.pageMaxRowCount = self.skinCenter.tableAreaSkin.elementHeight / self.skinCenter.rowSkin.elementHeight;
    self.pageCount = kDefaultPage;
    targetHeaderCell = nil;
}

-(void) dealloc {
   [self.skinCenter release];
   self.skinCenter = nil;
   [self.gestureLayer release];
   self.gestureLayer = nil;
    if (targetHeaderCell) [targetHeaderCell release];
    targetHeaderCell = nil;
    [super dealloc];
}
#pragma mark - create gesture layer
-(void) createTableGestureLayer {
    self.gestureLayer = [[CCTableGestureLayer alloc] initWithWidth:self.skinCenter.tableAreaSkin.elementWidth
                                                            height:[self tableRealHeight]
                                                          delegate:self];
    [self.gestureLayer setIsTouchEnabled:kDefaultEnableTouch];
    [self addChild:self.gestureLayer];
}

#pragma mark - update property
-(void) updateElementWidth:(float)width type:(SKIN_TYPE)type {
    if (![self.tableElementCenter updateElementWidth:width type:type]) return;
    [self reloadTableContent];
    [self.gestureLayer updateContentSize:CGSizeMake(self.skinCenter.tableAreaSkin.elementWidth, [self tableRealHeight])];
}

-(void) updateElementHeight:(float)height type:(SKIN_TYPE)type {
    if (![self.tableElementCenter updateElementHeight:height type:type]) return;
    [self reloadTableContent];
    [self.gestureLayer updateContentSize:CGSizeMake(self.skinCenter.tableAreaSkin.elementWidth, [self tableRealHeight])];
}

-(void) updateFontName:(NSString *)name type:(SKIN_TYPE)type {
    if (![self.tableElementCenter updateFontName:name type:type]) return;
    if (type == SKIN_TITLE || type == SKIN_HEADER || type == SKIN_FOOTER) {
        [self.gestureLayer updateContentSize:CGSizeMake(self.skinCenter.tableAreaSkin.elementWidth, [self tableRealHeight])];
    }
    if (type == SKIN_ROW) [self reloadTableContent];
}

-(void) updateFontSize:(float)size type:(SKIN_TYPE)type{
    if (![self.tableElementCenter updateFontSize:size type:type]) return;
    if (type == SKIN_TITLE || type == SKIN_HEADER || type == SKIN_FOOTER) {
        [self.gestureLayer updateContentSize:CGSizeMake(self.skinCenter.tableAreaSkin.elementWidth, [self tableRealHeight])];
    }
    if (type == SKIN_ROW) [self reloadTableContent];
}

-(void) updateFontColor:(ccColor3B)color type:(SKIN_TYPE)type {
    if (![self.tableElementCenter updateFontColor:color type:type]) return;
}

-(void) updateElementColor:(ccColor3B)color type:(SKIN_TYPE)type state:(BOOL)isNormal {
    if (![self.tableElementCenter updateElementColor:color type:type state:isNormal]) return;
}

-(void) updateElementOpacity:(float)opacity type:(SKIN_TYPE)type state:(BOOL)isNormal {
    if (![self.tableElementCenter updateElementOpacity:opacity type:type state:isNormal]) return;
}

-(void) updateElementTexture:(NSString *)textureFile type:(SKIN_TYPE)type state:(BOOL)isNormal {
    if (![self.tableElementCenter updateElementTexture:textureFile type:type state:isNormal]) return;
}

-(void) updateTextureOpacity:(float)opacity type:(SKIN_TYPE)type state:(BOOL)isNormal {
    if (![self.tableElementCenter updateTextureOpacity:opacity type:type state:isNormal]) return;
}

-(void) updateFrameWidth:(float)width type:(SKIN_TYPE)type {
    if (![self.tableElementCenter updateFrameWidth:width type:type]) return;
}

-(void) updateFrameColor:(ccColor3B)color type:(SKIN_TYPE)type {
    if (![self.tableElementCenter updateFrameColor:color type:type]) return;
}

-(void) updateFrameOpacity:(float)opacity type:(SKIN_TYPE)type {
    if (![self.tableElementCenter updateFrameOpacity:opacity type:type]) return;
}

-(void) updateAlign:(ALIGN_STYLE)align type:(SKIN_TYPE)type {
    if (![self.tableElementCenter updateAlign:align type:type]) return;
}

-(void) updateTitleString:(NSString *)titleString {
    if ([self.skinCenter.titleSkin updateTitleString:titleString]) [self.tableElementCenter.tableTitle updateElementContent];
}

-(void) updateHeaderNameAt:(int)headerCell name:(NSString *)headerName {
    if ([self.skinCenter.headerSkin updateHeaderNameAt:headerCell name:headerName]) {
        [self.tableElementCenter.tableHeader updateElementContent];
    }
}

#pragma mark - reload table
-(void) reloadTableContent {
    int rowCount = [self.dataSource tableRowCount];
    [self updatePageInfo:rowCount];
    NSMutableArray *rowStringArray = [[NSMutableArray alloc] init];
    for (int i = 1 ; i <= self.pageMaxRowCount; i ++) {
        int rowIndex = (self.currentPage - 1) * self.pageMaxRowCount + i;
        if (rowIndex > rowCount) break;
        [rowStringArray addObject:[self.dataSource rowStringArrayAtIndex:(rowIndex - 1)]];
    }
    [self.tableElementCenter.tableArea updateRows:rowStringArray];
    [self.tableElementCenter.tableArea updateRowsPosition];
    [self.tableElementCenter.tableGrid updateElementFrame];
}

#pragma mark - page
-(void) updatePageInfo:(int)rowCount {
    self.pageMaxRowCount = self.skinCenter.tableAreaSkin.elementHeight / self.skinCenter.rowSkin.elementHeight;
    self.pageCount = (rowCount + self.pageMaxRowCount - 1) / self.pageMaxRowCount;
    if (self.pageCount == 0) self.pageCount = 1;
    self.currentPage = (self.currentPage > self.pageCount) ? self.pageCount : self.currentPage;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tablePageUpdate:totalPage:)]) [self.dataSource tablePageUpdate:self.currentPage totalPage:self.pageCount];
    [self.tableElementCenter.tableFooter updateCurrentPage:self.currentPage totalPage:self.pageCount];
    [self.tableElementCenter.tableGrid updateMaxRowCount:self.pageMaxRowCount];
}

-(void) nextPage {
    if (self.currentPage + 1 > self.pageCount) return;
    self.currentPage ++;
    [self reloadTableContent];
}

-(void) prePage {
    if (self.currentPage - 1 < 1) return;
    self.currentPage --;
    [self reloadTableContent];
}

-(void) firstPage {
    self.currentPage = 1;
    [self reloadTableContent];
}

-(void) lastPage {
    self.currentPage = self.pageCount;
    [self reloadTableContent];
}

#pragma mark - skin
-(BOOL) exportTableSkinToFile:(NSString *)fileName {
    return [self.skinCenter exportTableSkinToFile:fileName];
}

-(void) updateTableSkin:(NSString *)fileName {
    [self.skinCenter updateSkinWithFile:fileName];
    [self reloadTable];
}

-(void) reloadTable {
    [self.tableElementCenter.tableTitle updateElementSize];
    [self.tableElementCenter.tableTitle updateElementPosition];
    [self.tableElementCenter.tableTitle updateElementContent];
    [self.tableElementCenter.tableTitle updateElementColor];
    [self.tableElementCenter.tableTitle updateElementFrame];
    [self.tableElementCenter.tableTitle updateElementTexture];
    [self.tableElementCenter.tableTitle updateElementTextureScale];
    
    [self.tableElementCenter.tableHeader updateElementSize];
    [self.tableElementCenter.tableHeader updateElementPosition];
    [self.tableElementCenter.tableHeader updateElementContent];
    [self.tableElementCenter.tableHeader updateElementColor];
    [self.tableElementCenter.tableHeader updateElementFrame];
    [self.tableElementCenter.tableHeader updateElementTexture];
    [self.tableElementCenter.tableHeader updateElementTextureScale];
    
    [self.tableElementCenter.tableArea updateElementSize];
    [self.tableElementCenter.tableArea updateElementPosition];
    [self.tableElementCenter.tableArea updateElementColor];
    [self.tableElementCenter.tableArea updateElementFrame];
    [self.tableElementCenter.tableArea updateElementTexture];
    [self.tableElementCenter.tableArea updateElementTextureScale];
    
    [self.tableElementCenter.tableFooter updateElementSize];
    [self.tableElementCenter.tableFooter updateElementPosition];
    [self.tableElementCenter.tableFooter updateElementContent];
    [self.tableElementCenter.tableFooter updateElementColor];
    [self.tableElementCenter.tableFooter updateElementFrame];
    [self.tableElementCenter.tableFooter updateElementTexture];
    [self.tableElementCenter.tableFooter updateElementTextureScale];
    
    [self.tableElementCenter.tableGrid updateElementFrame];
    
    [self reloadTableContent];
}

#pragma mark - gesture delegate
-(void) gestureSwipeAt:(CGPoint)touchLocation direction:(int)direction touches:(int)touches state:(UIGestureRecognizerState)state {
    CGPoint touchInTableArea = [self.tableElementCenter.tableArea convertToNodeSpace:touchLocation];
    if ([self.tableElementCenter.tableTitle hitTest:touchInTableArea]) {CCLOG(@"Title gestureSwipe"); return;}
    if ([self.tableElementCenter.tableHeader hitTest:touchInTableArea]) {CCLOG(@"Header gestureSwipe"); return;}
    if ([self.tableElementCenter.tableArea hitTest:touchInTableArea]) {
        if (direction == UISwipeGestureRecognizerDirectionLeft) (touches == 1) ? [self nextPage] : [self lastPage];
        if (direction == UISwipeGestureRecognizerDirectionRight) (touches == 1) ? [self prePage] : [self firstPage];
        int count = [self.dataSource tableRowCount];
        CCTableRow *tableRow = nil;
        if (count > 0) {
            tableRow = [self.tableElementCenter.tableArea rowFromLocation:touchLocation];
            if (!tableRow) return;
        }
        if (direction == UISwipeGestureRecognizerDirectionUp) {
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(insertRowBefore:)]) {
                if ([self.dataSource insertRowBefore:(tableRow) ? [self globalRowIndex:tableRow.tag] : 1]) [self reloadTableContent];
            }
        }
        if (direction == UISwipeGestureRecognizerDirectionDown) {
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(insertRowAfter:)]) {
                if ([self.dataSource insertRowAfter:(tableRow) ? [self globalRowIndex:tableRow.tag] : 1]) [self reloadTableContent];
            }
        }
        return;
    }
}

-(void) gestureLongPressAt:(CGPoint)touchLocation state:(UIGestureRecognizerState)state {
    CGPoint touchInTableArea = [self.tableElementCenter.tableArea convertToNodeSpace:touchLocation];
    if (self.skinCenter.titleSkin.allowEditTitle && [self.tableElementCenter.tableTitle hitTest:touchInTableArea]) {
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(updateTitleString:)]) {
            [self.dataSource updateTitleString:self.skinCenter.titleSkin.titleString];
        }
        return;        
    }
    if (self.skinCenter.headerSkin.allowEditHeaderName && [self.tableElementCenter.tableHeader hitTest:touchInTableArea]) {
        CCHeaderCell *headerCell = [self.tableElementCenter.tableHeader headerCellFromLocation:touchLocation];
        if (!headerCell) return;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(updateHeaderCell:oldHeaderString:)]) {
            [self.dataSource updateHeaderCell:headerCell.tag oldHeaderString:headerCell.cellString];
        }
        return;
    }
    if (self.skinCenter.tableAreaSkin.allowEditCell && [self.tableElementCenter.tableArea hitTest:touchInTableArea]) {
        CCTableRow *tableRow = tableRow = [self.tableElementCenter.tableArea rowFromLocation:touchLocation];
        if (!tableRow) return;
        CCRowCell *tableCell = [tableRow cellFromLocation:touchLocation];
        if (!tableCell || tableCell.tag == 1) return;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(updateCell:atRow:oldCellString:)]) {
            [self.dataSource updateCell:tableCell.tag atRow:[self globalRowIndex:tableRow.tag] oldCellString:tableCell.cellString];
        }
        return;
    }
}

-(void) gesturePanAt:(CGPoint)touchLocation state:(UIGestureRecognizerState)state {
    CGPoint touchInTableArea = [self.tableElementCenter.tableArea convertToNodeSpace:touchLocation];
    if ([self.tableElementCenter.tableTitle hitTest:touchInTableArea]) {CCLOG(@"Title gesturePan"); return;}
    if (self.skinCenter.headerSkin.allowAdjustColumnWidth && [self.tableElementCenter.tableHeader hitTest:touchInTableArea]) {
        if (state == UIGestureRecognizerStateBegan) targetHeaderCell = [self.tableElementCenter.tableHeader headerCellFromLocation:touchLocation];
        if (state == UIGestureRecognizerStateChanged) {
            if (!targetHeaderCell) return;
            float width = [self convertToNodeSpace:touchLocation].x - targetHeaderCell.position.x;
            if (width <= 0) width = 5.0f;
            if ([self.skinCenter.headerSkin updateColumnWidthAt:targetHeaderCell.tag width:width]) {
                [self.tableElementCenter.tableHeader updateElementSize];
                [self.tableElementCenter.tableHeader updateElementContent];
                [self.tableElementCenter.tableHeader updateElementTexture];
                [self.tableElementCenter.tableArea updateElementTexture];
                [self reloadTableContent];
                [self.tableElementCenter.tableGrid updateElementFrame];
            }
        }
        if (state == UIGestureRecognizerStateEnded) targetHeaderCell = nil;
        return;
    }
    if ([self.tableElementCenter.tableArea hitTest:touchInTableArea]) {CCLOG(@"TableArea gesturePan"); return;}
}

-(void) gestureSingleTapAt:(CGPoint)touchLocation state:(UIGestureRecognizerState)state {
    CGPoint touchInTableArea = [self.tableElementCenter.tableArea convertToNodeSpace:touchLocation];
    if ([self.tableElementCenter.tableTitle hitTest:touchInTableArea]) {CCLOG(@"Title gestureSingleTap"); return;}
    if ([self.tableElementCenter.tableHeader hitTest:touchInTableArea]) {CCLOG(@"Header gestureSingleTap"); return;}
    if ([self.tableElementCenter.tableArea hitTest:touchInTableArea]) {
        CCTableRow *tableRow = [self.tableElementCenter.tableArea rowFromLocation:touchLocation];
        if (!tableRow) return;
        if (self.skinCenter.tableAreaSkin.allowMultiSelectRow) {
            if (tableRow.isSelected) {
                [self.tableElementCenter.tableArea unselectRow:tableRow];
            }
            else {
                [self.tableElementCenter.tableArea selectRow:tableRow];
            }
        }
        else {
            if (tableRow.isSelected) {
                [self.tableElementCenter.tableArea unselectRow:tableRow];
            }
            else {
                [self.tableElementCenter.tableArea unselectAllRows];
                [self.tableElementCenter.tableArea selectRow:tableRow];
            }
        }
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(rowSelected:rowsSelected:)]) [self.dataSource rowSelected:[self globalRowIndex:tableRow.tag] rowsSelected:[self.tableElementCenter.tableArea selectedRows]];
    }
}
-(void) gestureDoubleTapAt:(CGPoint)touchLocation  state:(UIGestureRecognizerState)state{
    CGPoint touchInTableArea = [self.tableElementCenter.tableArea convertToNodeSpace:touchLocation];
    if ([self.tableElementCenter.tableTitle hitTest:touchInTableArea]) {CCLOG(@"Title gestureDoubleTap"); return;}
    if ([self.tableElementCenter.tableHeader hitTest:touchInTableArea]) {CCLOG(@"Header gestureDoubleTap"); return;}
    if ([self.tableElementCenter.tableArea hitTest:touchInTableArea]) {
        CCTableRow *tableRow = [self.tableElementCenter.tableArea rowFromLocation:touchLocation];
        if (!tableRow) return;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(removeRowAt:)])  [self.dataSource removeRowAt:[self globalRowIndex:tableRow.tag]];
    }
}

-(void) enableGesture:(BOOL)enableFlag {
    [self.gestureLayer setIsTouchEnabled:enableFlag];
}

#pragma mark - helper
-(int) globalRowIndex:(int)rowTag {
    return (self.currentPage - 1) * self.pageMaxRowCount + rowTag - kTagRow;
}

-(float) tableRealHeight {
    return (self.skinCenter.titleSkin.elementHeight +
            self.skinCenter.headerSkin.elementHeight +
            self.skinCenter.tableAreaSkin.elementHeight);
}

@end
