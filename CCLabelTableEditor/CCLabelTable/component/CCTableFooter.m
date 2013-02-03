#import "CCTableFooter.h"

@implementation CCTableFooter
@synthesize currentPage;
@synthesize totalPage;
    
#pragma mark - init && dealloc
+(id) footerWithSkin:(CCSkinCenter *)skin {
    return [[[self alloc] initFooterWithSkin:skin] autorelease];
}
-(id) initFooterWithSkin:(CCSkinCenter *)skin {
    if (self = [super initWithSkin:skin]) {
        self.currentPage = 1;
        self.totalPage = 1;
        [self updateElementContent];
    }
    return self;
}

#pragma mark - footer
-(void) updateElementPosition {
    self.position = ccp(0, 0 - self.skinCenter.footerSkin.elementHeight);
}

-(void) updateElementSize {
    self.ContentSize = CGSizeMake(self.skinCenter.tableAreaSkin.elementWidth,
                                  self.skinCenter.footerSkin.elementHeight);
}

-(void) updateElementContent {
    CCLabelTTF *footerLabel = (CCLabelTTF *)[self getChildByTag:kTagFooterLabel];
    if (!footerLabel) {
        footerLabel = [CCLabelTTF labelWithString:@"Page: ? / ?"
                                         fontName:self.skinCenter.footerSkin.fontName
                                         fontSize:self.skinCenter.footerSkin.fontSize];
        [self addChild:footerLabel z:999 tag:kTagFooterLabel];
    }
    [footerLabel setString:[NSString stringWithFormat:@"Page: %d / %d", self.currentPage, self.totalPage]];
    footerLabel.color = self.skinCenter.footerSkin.fontColor;
    footerLabel.fontSize = self.skinCenter.footerSkin.fontSize;
    footerLabel.fontName = self.skinCenter.footerSkin.fontName;
    if (self.skinCenter.footerSkin.alignStyle == kStyleAlignLeft) {
        footerLabel.anchorPoint = CGPointZero;
        footerLabel.position = ccp(5, 0);
    }
    if (self.skinCenter.footerSkin.alignStyle == kStyleAlignCenter) {
        footerLabel.anchorPoint = ccp(0.5f, 0);
        footerLabel.position = ccp(self.contentSize.width / 2, 0);
    }
}

-(void) updateCurrentPage:(int)cPage totalPage:(int)tPage {
    if (self.currentPage == cPage && self.totalPage == tPage) return;
    self.currentPage = cPage;
    self.totalPage = tPage;
    CCLabelTTF *footerLabel = (CCLabelTTF *)[self getChildByTag:kTagFooterLabel];
    [footerLabel setString:[NSString stringWithFormat:@"Page: %d / %d", self.currentPage, self.totalPage]];
}
@end
