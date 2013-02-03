#import "cocos2d.h"
#import "CCElementSkin.h"

#define    kDefaultTitleString                  @"CCLabelTable Demo"
#define    kDefaultTitleFontName                @"Arial"
#define    kDefaultTitleFontSize                16.0f
#define    kDefaultTitleFontColor               ccc3(255, 255, 255)
#define    kDefaultTitleColor                   ccc3(0, 0, 0)
#define    kDefaultTitleOpacity                 255
#define    kDefaultTitleTextureFile             @""
#define    kDefaultTitleTextureOpacity          255
#define    kDefaultTitleFrameWidth              1.0f
#define    kDefaultTitleFrameColor              ccc3(255, 255, 255)
#define    kDefaultTitleFrameOpacity            255
#define    kDefaultTitleAlign                   kStyleAlignCenter
#define    kDefaultAllowEditTitle               YES

@interface CCTitleSkin : CCElementSkin { 
    NSString *titleString;
    BOOL allowEditTitle;
}

-(BOOL) updateTitleString:(NSString *)string;

@property (nonatomic, retain) NSString *titleString;
@property (nonatomic) BOOL allowEditTitle;
@end

