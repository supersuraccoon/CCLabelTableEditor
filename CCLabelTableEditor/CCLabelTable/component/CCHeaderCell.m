#import "CCHeaderCell.h"
#import "CCTableMacro.h"
#import "CCGSpriteRect.h"
#import "NSString+FontSize.h"

@implementation CCHeaderCell
@synthesize cellWidth;
@synthesize cellString;

#pragma mark - init && dealloc
+(id) cellWithWidth:(float)width cellString:(NSString *)string skin:(CCSkinCenter *)skin {
    return [[[self alloc] initCellWithWidth:width cellString:string skin:skin] autorelease];
}

-(id) initCellWithWidth:(float)width cellString:(NSString *)string skin:(CCSkinCenter *)skin {
    if (self = [super initWithSkin:skin]) {
        [self updateWidth:width];
        [self updateContentWithString:string];
    }
    return self;
}

-(void) dealloc {
    [self.cellString release];
    self.cellString = nil;
    [super dealloc];
}

#pragma mark - cell
-(void) updateElementFrame {return;};
-(void) updateElementPosition {CCLOG(@"Set by container");}
-(void) updateElementSize {
    self.ContentSize = CGSizeMake(self.cellWidth, self.skinCenter.headerSkin.elementHeight);
}

-(void) updateWidth:(float)width {
    self.cellWidth = width;
    [self updateElementSize];
}

-(void) updateContentWithString:(NSString *)string {
    self.cellString = string; 
    [self updateElementContent];
}

-(void) updateElementContent {
    CCLabelTTF *cellLabel = (CCLabelTTF *)[self getChildByTag:kTagHeaderCell];
    if (!cellLabel) {
        cellLabel = [CCLabelTTF labelWithString:@"" fontName:kDefaultHeaderFontName fontSize:kDefaultHeaderFontSize];
        [self addChild:cellLabel z:999 tag:kTagHeaderCell];
    }
    NSString *cellStringWithEllipsis = [self.cellString stringWithLimit:(self.contentSize.width * 0.8f) ellipsis:@"..."
                                                          fontName:self.skinCenter.headerSkin.fontName
                                                          fontSize:self.skinCenter.headerSkin.fontSize];
    cellLabel.string = cellStringWithEllipsis;
    cellLabel.fontSize = self.skinCenter.headerSkin.fontSize;
    cellLabel.fontName = self.skinCenter.headerSkin.fontName;
    cellLabel.color = self.skinCenter.headerSkin.fontColor;
    if (self.skinCenter.headerSkin.alignStyle == kStyleAlignLeft) {
        cellLabel.anchorPoint = CGPointZero;
        cellLabel.position = ccp(5, 0);
    }
    if (self.skinCenter.headerSkin.alignStyle == kStyleAlignCenter) {
        cellLabel.anchorPoint = ccp(0.5f, 0);
        cellLabel.position = ccp(self.contentSize.width / 2, 0);
    }
}

-(BOOL) updateAlign:(ALIGN_STYLE)alignStyle {return NO;}

@end
