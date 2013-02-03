#import "CCTableRow.h"
#import "CCTableMacro.h"
#import "CCGSpriteRect.h"
#import "NSString+FontSize.h"
#import "CCNode+AnchorLayout.h"
#import "CCNode+Query.h"
#import "NSArray+Comparison.h"

@implementation CCTableRow
@synthesize isSelected;
@synthesize rowStringArray;

#pragma mark - init && dealloc
+(id) rowWithRowStringArray:(NSArray *)rowArray skin:(CCSkinCenter *)skin {
    return [[[self alloc] initRowWithRowStringArray:rowArray skin:skin] autorelease];
}
-(id) initRowWithRowStringArray:(NSArray *)rowArray skin:(CCSkinCenter *)skin{
    if (self = [super initWithSkin:skin]) {
        self.rowStringArray = rowArray;
        self.skinCenter = skin;
        self.isSelected = NO;
        [self createRowCell];
        [self updateElementContent];
    }
    return self;
}

-(void) dealloc {
    [self.rowStringArray release];
    self.rowStringArray = nil;    
    [super dealloc];
}

#pragma mark - cell
-(void) createRowCell {
    for (int i = 1; i <= [self.rowStringArray count]; i ++) {
        int columnWidth = [[self.skinCenter.headerSkin.columnWidthArray objectAtIndex:(i - 1)] intValue];
        NSString *cellString = [self.rowStringArray objectAtIndex:(i - 1)];
        CCRowCell *rowCell = [CCRowCell cellWithWidth:columnWidth cellString:cellString skin:self.skinCenter];
        rowCell.anchorPoint = CGPointZero;
        [self addChild:rowCell z:999 tag:i];
    }
}

-(void) updateElementSize {
    self.ContentSize = CGSizeMake(self.skinCenter.tableAreaSkin.elementWidth,
                                  self.skinCenter.rowSkin.elementHeight);
}

-(void) updateElementColor {
    self.color = (self.tag % 2 != 0) ? self.skinCenter.rowSkin.elementColor : self.skinCenter.rowEvenSkin.elementColor;
    self.opacity = (self.tag % 2 != 0) ? self.skinCenter.rowSkin.elementOpacity : self.skinCenter.rowEvenSkin.elementOpacity;
}

-(void) updateElementTexture {
    if (self.textureSprite) {
        [self.textureSprite removeFromParentAndCleanup:YES];
        self.textureSprite = nil;
    }
    NSString *elementTexture = (self.tag % 2 != 0) ? self.skinCenter.rowSkin.elementTexture : self.skinCenter.rowEvenSkin.elementTexture;
    float textureOpacity = (self.tag % 2 != 0) ? self.skinCenter.rowSkin.textureOpacity : self.skinCenter.rowEvenSkin.textureOpacity;
    if (![elementTexture isEqualToString:@""] && !self.textureSprite) {
        self.textureSprite = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:elementTexture]];
        self.textureSprite.anchorPoint = CGPointZero;
        self.textureSprite.opacity = textureOpacity;
        [self addChild:self.textureSprite z:1];
        [self updateElementTextureScale];
    }
}

-(void) updateElementContent {
    CCRowCell *preRowCell = nil;
    int preColumnWidth = 0;
    for (CCRowCell *rowCell in [self childrenWithType:[CCRowCell class]]) {
        int columnWidth = [[self.skinCenter.headerSkin.columnWidthArray objectAtIndex:rowCell.tag - 1] intValue];
        [rowCell updateWidth:columnWidth];
        [rowCell updateContentWithString:[self.rowStringArray objectAtIndex:(rowCell.tag - 1)]];
        (!preRowCell) ? rowCell.position = CGPointZero : [rowCell addAnchor:kCCNodeAnchorLeft referTo:preRowCell edge:kCCNodeAnchorLeft margin:preColumnWidth];
        preRowCell = rowCell;
        preColumnWidth = columnWidth;
        [rowCell updateElementContent];
    }
}

-(void) updateElementFrame {return;};

-(void) updateRowStringArray:(NSArray *)rowArray {
    if ([rowArray count] != [self.rowStringArray count]) return;
    if ([self.rowStringArray allObjectsIdenticalWith:rowArray]) return;
    self.rowStringArray = [NSArray arrayWithArray:rowArray];
}

-(CCRowCell *) cellFromLocation:(CGPoint)position {
    CCLOG(@"%@", NSStringFromCGPoint(position));
    CCLOG(@"%@", NSStringFromCGPoint([self convertToNodeSpace:position]));
    for (CCRowCell *tableCell in [self childrenWithType:[CCRowCell class]]) {
        if ([tableCell hitTest:[self convertToNodeSpace:position]]) return tableCell;
    }
    return nil;
}

-(void) selectRowEffect {
    self.isSelected = YES;
    [self updateElementColor];
    [self updateElementTexture];
}

-(void) unselectRowEffect {
    self.isSelected = NO;
    [self updateElementColor];
    [self updateElementTexture];
}

@end
