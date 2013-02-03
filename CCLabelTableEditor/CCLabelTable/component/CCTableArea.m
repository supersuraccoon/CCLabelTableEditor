#import "CCTableArea.h"
#import "CCNode+AnchorLayout.h"
#import "CCNode+Query.h"

@implementation CCTableArea
@synthesize rowsInTabeArea;

#pragma mark - init && dealloc
+(id) tableAreaWithSkin:(CCSkinCenter *)skin {
    return [[[self alloc] initWithSkin:skin] autorelease];
}
-(id) initWithSkin:(CCSkinCenter *)skin {
    if (self = [super initWithSkin:skin]) {
        self.rowsInTabeArea = 0;
    }
    return self;
}

-(void) dealloc {
    [super dealloc];
}

#pragma mark - update
-(void) updateElementPosition {
    self.position = ccp(0, 0);
}

-(void) updateElementSize {
    self.ContentSize = CGSizeMake(self.skinCenter.tableAreaSkin.elementWidth,
                                  self.skinCenter.tableAreaSkin.elementHeight);
}

-(void) removeAllRows {
    for (CCTableRow *tableRow in [self childrenWithType:[CCTableRow class]]) {
        [tableRow removeFromParentAndCleanup:YES];
    }
}

-(void) removeUnusedRows {
    for (CCTableRow *tableRow in [self childrenWithType:[CCTableRow class]]) {
        if (tableRow.tag - kTagRow > self.rowsInTabeArea) [tableRow removeFromParentAndCleanup:YES];
    }
}

-(void) updateRows:(NSArray *)rowsStringArray {
    for (int i = 1; i <= [rowsStringArray count]; i++) {
        NSArray *rowStringArray = [rowsStringArray objectAtIndex:i - 1];
        CCTableRow *tableRow = (CCTableRow *)[self getChildByTag:kTagRow + i];
        if (!tableRow) {
            tableRow = [CCTableRow rowWithRowStringArray:rowStringArray skin:self.skinCenter];
            [self addChild:tableRow z:1 tag:kTagRow + i];
            [tableRow updateElementColor];
        }
        else {
            [tableRow updateRowStringArray:rowStringArray];
        }
        [tableRow updateElementSize];
    }
    if (self.rowsInTabeArea == [rowsStringArray count]) return;
    if (self.rowsInTabeArea > [rowsStringArray count]) {
        self.rowsInTabeArea = [rowsStringArray count];
        [self removeUnusedRows];
    }
    else {
        self.rowsInTabeArea = [rowsStringArray count];
    }
    [self updateElementTexture];
}

-(void) updateRowsPosition {
    CCTableRow *preTableRow = nil;
    for (CCTableRow *tableRow in [self childrenWithType:[CCTableRow class]]) {
        (!preTableRow) ? tableRow.position = ccp(0, self.skinCenter.tableAreaSkin.elementHeight - self.skinCenter.rowSkin.elementHeight) : [tableRow addAnchor:kCCNodeAnchorTop referTo:preTableRow edge:kCCNodeAnchorTop margin:(self.skinCenter.rowSkin.elementHeight)];
        preTableRow = tableRow;
        [tableRow updateElementContent];
    }
}

-(void) updateElementTexture {
    [super updateElementTexture];
    for (CCTableRow *tableRow in [self childrenWithType:[CCTableRow class]]) {
        [tableRow updateElementTexture];
        for (CCRowCell *tableCell in [tableRow childrenWithType:[CCRowCell class]]) {
            [tableCell updateElementTexture];
        }
    }
}

-(void) updateElementContent {
    for (CCTableRow *tableRow in [self childrenWithType:[CCTableRow class]]) {
        [tableRow updateElementContent];
    }
}

-(void) updateElementColor {
    [super updateElementColor];
    for (CCTableRow *tableRow in [self childrenWithType:[CCTableRow class]]) {
        [tableRow updateElementColor];
        for (CCRowCell *tableCell in [tableRow childrenWithType:[CCRowCell class]]) {
            [tableCell updateElementColor];
        }
    }
}

#pragma mark - select && unselect
-(void) selectRow:(CCTableRow *)tableRow {
    [tableRow selectRowEffect];
}

-(void) unselectRow:(CCTableRow *)tableRow {
    [tableRow unselectRowEffect];
}

-(void) selectAllRows {
    for (CCTableRow *tableRow in [self childrenWithType:[CCTableRow class]]) {
        if (!tableRow.isSelected) [self selectRow:tableRow];
    }
}

-(void) unselectAllRows {
    for (CCTableRow *tableRow in [self childrenWithType:[CCTableRow class]]) {
        if (!tableRow.isSelected) [self unselectRow:tableRow];
    }
}

-(NSMutableArray *) selectedRows {
    NSMutableArray *selectedRowsArray = [[NSMutableArray alloc] init];
    for (CCTableRow *tableRow in [self childrenWithType:[CCTableRow class]]) {
        if (!tableRow.isSelected) [selectedRowsArray addObject:tableRow];
    }
    return selectedRowsArray;
}

#pragma mark - touch
-(CCTableRow *) rowFromLocation:(CGPoint)position {
    for (CCTableRow *tableRow in [self childrenWithType:[CCTableRow class]]) {
        if ([tableRow hitTest:[self convertToNodeSpace:position]]) return tableRow;
    }
    return nil;
}

@end
