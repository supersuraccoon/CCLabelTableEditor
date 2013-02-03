#import "CCTableHeader.h"
#import "CCHeaderCell.h"
#import "CCTableMacro.h"
#import "CCGSpriteRect.h"
#import "NSString+FontSize.h"
#import "CCNode+AnchorLayout.h"
#import "CCNode+Query.h"

@implementation CCTableHeader

#pragma mark - init && dealloc
+(id) hearderWithSkin:(CCSkinCenter *)skin {
    return [[[self alloc] initHeaderWithSkin:skin] autorelease];
}
-(id) initHeaderWithSkin:(CCSkinCenter *)skin{
    if ((self = [super initWithSkin:skin])) {
        [self createHeaderCell];
        [self updateElementContent];
    }
    return self;
}

-(BOOL) hitTest:(CGPoint)position {
    return (CGRectContainsPoint(self.boundingBox, position));
}

#pragma mark - table header
-(void) updateElementPosition {
    self.position = ccp(0, self.skinCenter.tableAreaSkin.elementHeight);
}

-(void) updateElementSize {
    self.ContentSize = CGSizeMake(self.skinCenter.tableAreaSkin.elementWidth, 
                                  self.skinCenter.headerSkin.elementHeight);
}

-(void) createHeaderCell {
    for (int i = 1; i <= [self.skinCenter.headerSkin.headerNameArray count]; i ++) {
        int columnWidth = [[self.skinCenter.headerSkin.columnWidthArray objectAtIndex:(i - 1)] intValue];
        NSString *cellString = [self.skinCenter.headerSkin.headerNameArray objectAtIndex:(i - 1)];
        CCHeaderCell *headerCell = [CCHeaderCell cellWithWidth:columnWidth cellString:cellString skin:self.skinCenter];
        headerCell.anchorPoint = CGPointZero;
        [self addChild:headerCell z:1 tag:i];
    }
}

-(void) updateElementTexture {
    [super updateElementTexture];
    for (CCHeaderCell *headerCell in [self childrenWithType:[CCHeaderCell class]]) {
        [headerCell updateElementTexture];
    }
}

-(void) updateElementColor {
    [super updateElementColor];
    for (CCHeaderCell *headerCell in [self childrenWithType:[CCHeaderCell class]]) {
        [headerCell updateElementColor];
    }
}

-(void) updateElementContent {
    CCLayerColor *preHeaderCell = nil;
    float preColumnWidth = 0.0f;
    for (CCHeaderCell *headerCell in [self childrenWithType:[CCHeaderCell class]]) {
        float columnWidth = [[self.skinCenter.headerSkin.columnWidthArray objectAtIndex:headerCell.tag - 1] intValue];
        (!preHeaderCell) ? headerCell.position = CGPointZero : [headerCell addAnchor:kCCNodeAnchorLeft referTo:preHeaderCell edge:kCCNodeAnchorLeft margin:preColumnWidth];
        preHeaderCell = headerCell;
        preColumnWidth = columnWidth;
        NSString *cellString = [self.skinCenter.headerSkin.headerNameArray objectAtIndex:(headerCell.tag - 1)];
        [headerCell updateWidth:columnWidth];
        [headerCell updateContentWithString:cellString];
    }
}

-(CCHeaderCell *) headerCellFromLocation:(CGPoint)position {
    for (CCHeaderCell *headerCell in [self childrenWithType:[CCHeaderCell class]]) {
        if ([headerCell hitTest:[self convertToNodeSpace:position]]) return headerCell;
    }
    return nil;
}

@end
