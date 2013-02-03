#import "CCTableTitle.h"
#import "NSString+FontSize.h"

@implementation CCTableTitle

#pragma mark - init && dealloc
+(id) titleWithSkin:(CCSkinCenter *)skin {
    return [[[self alloc] initWithSkin:skin] autorelease];
}
-(id) initWithSkin:(CCSkinCenter *)skin {
    if ((self = [super initWithSkin:skin])) {
        [self updateElementContent];
        [self updateElementFrame];
    }
    return self;
}

#pragma mark - create. udpate title
-(void) updateElementPosition {
    self.position = ccp(0, self.skinCenter.tableAreaSkin.elementHeight + self.skinCenter.headerSkin.elementHeight);
}

-(void) updateElementSize {
    self.ContentSize = CGSizeMake(self.skinCenter.tableAreaSkin.elementWidth,
                                  self.skinCenter.titleSkin.elementHeight);
}

-(void) updateElementContent {
    CCLabelTTF *titleLabel = (CCLabelTTF *)[self getChildByTag:kTagTitleLabel];
    if (!titleLabel) {
        titleLabel = [CCLabelTTF labelWithString:@"" fontName:kDefaultTitleFontName fontSize:kDefaultTitleFontSize];
        [self addChild:titleLabel z:999 tag:kTagTitleLabel];
    }
    NSString *titleWithEllipsis = [self.skinCenter.titleSkin.titleString stringWithLimit:(self.contentSize.width * 0.8f) ellipsis:@"..."
                                                                                fontName:self.skinCenter.titleSkin.fontName
                                                                                fontSize:self.skinCenter.titleSkin.fontSize];
    [titleLabel setString:titleWithEllipsis];
    titleLabel.color = self.skinCenter.titleSkin.fontColor;
    titleLabel.fontSize = self.skinCenter.titleSkin.fontSize;
    titleLabel.fontName = self.skinCenter.titleSkin.fontName;
    if (self.skinCenter.titleSkin.alignStyle == kStyleAlignLeft) {
        titleLabel.anchorPoint = CGPointZero;
        titleLabel.position = ccp(5, 0);
    }
    if (self.skinCenter.titleSkin.alignStyle == kStyleAlignCenter) {
        titleLabel.anchorPoint = ccp(0.5f, 0);
        titleLabel.position = ccp(self.contentSize.width / 2, 0);
    }
}

@end
