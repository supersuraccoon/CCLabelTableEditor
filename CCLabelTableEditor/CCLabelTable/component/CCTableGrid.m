#import "CCTableGrid.h"
#import "CCNode+Query.h"
#import "CCGSpriteLine.h"

@implementation CCTableGrid
@synthesize pageMaxRowCount;

#pragma mark - init && dealloc
+(id) gridWithMaxRowCount:(int)maxRowCount skin:(CCSkinCenter *)skin {
    return [[[self alloc] initGridWithMaxRowCount:maxRowCount skin:skin] autorelease];
}
-(id) initGridWithMaxRowCount:(int)maxRowCount skin:(CCSkinCenter *)skin {
    if (self = [super initWithSkin:skin]) {
        self.pageMaxRowCount = maxRowCount;
        [self updateElementFrame];
    }
    return self;
}

-(BOOL) hitTest:(CGPoint)position {return NO;};

-(void) updateGridColor {
    for (CCGSpriteLine *lineSprite in [self childrenWithType:[CCGSpriteLine class]]) {
        lineSprite.lineColor = ccc4(self.skinCenter.gridSkin.frameColor.r,
                                    self.skinCenter.gridSkin.frameColor.g,
                                    self.skinCenter.gridSkin.frameColor.b,
                                    self.skinCenter.gridSkin.frameOpacity);
    }
}

-(void) updateGridWidth {
    for (CCGSpriteLine *lineSprite in [self childrenWithType:[CCGSpriteLine class]]) {
        lineSprite.lineWidth = self.skinCenter.gridSkin.frameWidth;
    }
}

-(void) updateMaxRowCount:(int)maxRowCount {
    self.pageMaxRowCount = maxRowCount;
}

-(void) updateElementTexture {return;}

-(void) updateElementFrame {
    [self removeAllChildrenWithCleanup:YES];
    // draw v-line
    float columnWidth = 0;
    for (int i = 1; i <= [self.skinCenter.headerSkin.columnWidthArray count]; i ++) {
        columnWidth += [[self.skinCenter.headerSkin.columnWidthArray objectAtIndex:(i - 1)] intValue];
        CCGSpriteLine *lineSprite = [[CCGSpriteLine alloc] initWithWidth:self.skinCenter.gridSkin.frameWidth
                                                               withColor:ccc4(self.skinCenter.gridSkin.frameColor.r,
                                                                              self.skinCenter.gridSkin.frameColor.g,
                                                                              self.skinCenter.gridSkin.frameColor.b,
                                                                              self.skinCenter.gridSkin.frameOpacity)
                                                          withLineOrigin:ccp(columnWidth, 0)
                                                     withLineDestination:ccp(columnWidth, self.skinCenter.tableAreaSkin.elementHeight + self.skinCenter.headerSkin.elementHeight)];
        [self addChild:lineSprite z:1 tag:0];
    }
    // draw h-line
    for (int i = 1; i < self.pageMaxRowCount; i ++) {
        CCGSpriteLine *lineSprite = [[CCGSpriteLine alloc] initWithWidth:self.skinCenter.gridSkin.frameWidth
                                                               withColor:ccc4(self.skinCenter.gridSkin.frameColor.r,
                                                                              self.skinCenter.gridSkin.frameColor.g,
                                                                              self.skinCenter.gridSkin.frameColor.b,
                                                                              self.skinCenter.gridSkin.frameOpacity)
                                                          withLineOrigin:ccp(0, self.skinCenter.tableAreaSkin.elementHeight - self.skinCenter.rowSkin.elementHeight * i)
                                                     withLineDestination:ccp(self.skinCenter.tableAreaSkin.elementWidth, self.skinCenter.tableAreaSkin.elementHeight - self.skinCenter.rowSkin.elementHeight * i)];
        [self addChild:lineSprite z:1 tag:0];
    }
}

@end
