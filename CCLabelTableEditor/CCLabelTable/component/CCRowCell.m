#import "CCRowCell.h"
#import "NSString+FontSize.h"

@implementation CCRowCell
@synthesize cellWidth;
@synthesize cellString;

#pragma mark - init && dealloc
+(id) cellWithWidth:(float)width cellString:(NSString *)string skin:(CCSkinCenter *)skin {
    return [[[self alloc] initCellWithWidth:width cellString:string skin:skin] autorelease];
}

-(id) initCellWithWidth:(float)width cellString:(NSString *)string skin:(CCSkinCenter *)skin {
    if ((self = [super initWithSkin:skin])) {
        [self updateContentWithString:string];
        [self updateWidth:width];
        [self updateElementContent];
    }
    return self;
}

-(void) updateElementSize {
    self.ContentSize = CGSizeMake(self.cellWidth, self.skinCenter.rowSkin.elementHeight);
}

-(void) updateWidth:(float)width {
    self.cellWidth = width;
    [self updateElementSize];
}

-(void) updateContentWithString:(NSString *)string {
    self.cellString = string;
    [self updateElementContent];
}

-(void) dealloc {
    [self.cellString release];
    self.cellString = nil;
    [super dealloc];
}

#pragma mark - cell
-(void) updateElementContent {
    CCLabelTTF *cellLabel = (CCLabelTTF *)[self getChildByTag:kTagRowCell];
    if (!cellLabel) {
        cellLabel = [CCLabelTTF labelWithString:@"" fontName:kDefaultRowFontName fontSize:kDefaultRowFontSize];
        [self addChild:cellLabel z:999 tag:kTagRowCell];
    }
    NSString *cellStringWithEllipsis = [self.cellString stringWithLimit:(self.contentSize.width * 0.8f) ellipsis:@"..."
                                                          fontName:self.skinCenter.rowSkin.fontName
                                                          fontSize:self.skinCenter.rowSkin.fontSize];
    cellLabel.string = cellStringWithEllipsis;
    cellLabel.fontSize = self.skinCenter.rowSkin.fontSize;
    cellLabel.fontName = self.skinCenter.rowSkin.fontName;
    cellLabel.color = self.skinCenter.rowSkin.fontColor;
    if (self.skinCenter.rowSkin.alignStyle == kStyleAlignLeft) {
        cellLabel.anchorPoint = CGPointZero;
    cellLabel.position = ccp(5, 0);
    }
    if (self.skinCenter.rowSkin.alignStyle == kStyleAlignCenter) {
        cellLabel.anchorPoint = ccp(0.5f, 0);
        cellLabel.position = ccp(self.contentSize.width / 2, 0);
    }
}

-(BOOL) updateAlign:(ALIGN_STYLE)alignStyle {return NO;}

@end
