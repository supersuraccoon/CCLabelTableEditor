#import "CCTableElement.h"
#import "CCTableArea.h"
#import "CCTableTitle.h"
#import "CCTableHeader.h"
#import "CCHeaderCell.h"
#import "CCTableRow.h"
#import "CCRowCell.h"
#import "CCTableFooter.h"
#import "CCTableGrid.h"
#import "CCGSpriteRect.h"
#import "NSString+FontSize.h"

@implementation CCTableElement
@synthesize textureSprite;
@synthesize skinCenter;

-(id) initWithSkin:(CCSkinCenter *)skin {
    if ((self = [super init])) {
        self.textureSprite = nil;
        self.skinCenter = skin;
        [self updateElementSize];
        [self updateElementPosition];
        [self updateElementColor];
        [self updateElementTexture];
        [self updateElementFrame];
    }
    return self;
}

-(void) dealloc {
    if (self.textureSprite) [self.textureSprite release];
    self.textureSprite = nil;
    [self.skinCenter release];
    self.skinCenter = nil;    
    [super dealloc];
}

-(CCElementSkin *) skinElement {
    if ([self isKindOfClass:[CCTableArea class]]) return self.skinCenter.tableAreaSkin;
    if ([self isKindOfClass:[CCTableTitle class]]) return self.skinCenter.titleSkin;
    if ([self isKindOfClass:[CCTableHeader class]]) return self.skinCenter.headerSkin;
    if ([self isKindOfClass:[CCHeaderCell class]]) return self.skinCenter.headerCellSkin;
    if ([self isKindOfClass:[CCTableRow class]]) return self.skinCenter.rowSkin;
    if ([self isKindOfClass:[CCRowSkin class]]) return self.skinCenter.rowEvenSkin;
    if ([self isKindOfClass:[CCRowCell class]]) return self.skinCenter.rowCellSkin;
    if ([self isKindOfClass:[CCTableFooter class]]) return self.skinCenter.footerSkin;
    if ([self isKindOfClass:[CCTableGrid class]]) return self.skinCenter.gridSkin;
    return nil;
}

#pragma mark - update property
-(void) updateElementContent {CCLOG(@"Override me");}
-(void) updateElementPosition {self.position = CGPointZero;}
-(void) updateElementSize {self.ContentSize = CGSizeZero;}

-(void) updateElementTexture {
    CCElementSkin *elementSkin = [self skinElement];
    if (!elementSkin) return;
    if (self.textureSprite) {
        [self.textureSprite removeFromParentAndCleanup:YES];
        self.textureSprite = nil;
    }
    if (![elementSkin.elementTexture isEqualToString:@""] && !self.textureSprite) {
        self.textureSprite = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:elementSkin.elementTexture]];
        self.textureSprite.anchorPoint = CGPointZero;
        self.textureSprite.opacity = elementSkin.textureOpacity;
        [self addChild:self.textureSprite z:1];
        [self updateElementTextureScale];
    }
}

-(void) updateTextureSelected {
    CCElementSkin *elementSkin = [self skinElement];
    if (!elementSkin) return;
    if (self.textureSprite) {
        [self.textureSprite removeFromParentAndCleanup:YES];
        [self.textureSprite release];
        self.textureSprite = nil;
    }
    if ([elementSkin.elementTextureSelected isEqualToString:@""] && self.textureSprite == nil) {
        self.textureSprite = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:elementSkin.elementTextureSelected]];
        self.textureSprite.anchorPoint = CGPointZero;
        self.textureSprite.opacity = elementSkin.textureOpacitySelected;
        [self addChild:self.textureSprite z:1];
        [self updateElementTextureScale];
    }
}

-(void) updateElementTextureScale {
    if (self.textureSprite) {
        [self.textureSprite setScaleX: self.contentSize.width / self.textureSprite.texture.contentSize.width];
        [self.textureSprite setScaleY: self.contentSize.height / self.textureSprite.texture.contentSize.height];
    }
}

-(void) updateElementColor {
    CCElementSkin *elementSkin = [self skinElement];
    if (!elementSkin) return;
    self.color = elementSkin.elementColor;
    self.opacity = elementSkin.elementOpacity;
}

-(void) updateColorSelected {
    CCElementSkin *elementSkin = [self skinElement];
    if (!elementSkin) return;
    self.color = elementSkin.elementColorSelected;
    self.opacity = elementSkin.elementOpacitySelected;
}

-(void) updateElementFrame {
    CCElementSkin *elementSkin = [self skinElement];
    if (!elementSkin) return;
    CCGSpriteRect *rectSprite = (CCGSpriteRect *)[self getChildByTag:kTagFrame];
    if (!rectSprite) {
        rectSprite = [CCGSpriteRect rectWithRect:CGRectZero withLineWidth:0 withLineColor:ccc4(0, 0, 0, 0)];
        [self addChild:rectSprite z:999 tag:kTagFrame];
    }
    rectSprite.targetRect = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    rectSprite.lineWidth = elementSkin.frameWidth;
    rectSprite.lineColor = ccc4(elementSkin.frameColor.r, elementSkin.frameColor.g, elementSkin.frameColor.b, elementSkin.frameOpacity);
}

-(BOOL) hitTest:(CGPoint)position {
    return (CGRectContainsPoint(self.boundingBox, position));
}

@end
