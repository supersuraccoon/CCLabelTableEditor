#import "cocos2d.h"
#import "CCElementSkin.h"

#define    kDefaultHeaderFontName               @"Arial"
#define    kDefaultHeaderFontSize               16.0f
#define    kDefaultHeaderFontColor              ccc3(255, 255, 255)
#define    kDefaultHeaderColor                  ccc3(0, 0, 0)
#define    kDefaultHeaderOpacity                255
#define    kDefaultHeaderTextureFile            @""
#define    kDefaultHeaderTextureOpacity         255
#define    kDefaultHeaderFrameWidth             1.0f
#define    kDefaultHeaderFrameColor             ccc3(255, 255, 255)
#define    kDefaultHeaderFrameOpacity           255
#define    kDefaultHeaderAlign                  kStyleAlignCenter
#define    kDefaultAllowEditHeaderNameFlag      YES
#define    kDefaultAllowAdjustColumnWidthFlag   YES

@interface CCHeaderSkin : CCElementSkin { 
    NSMutableArray *headerNameArray;
    NSMutableArray *columnWidthArray;
    BOOL allowEditHeaderName;
    BOOL allowAdjustColumnWidth;
}

-(BOOL) updateColumnWidthAt:(int)index width:(float)width;
-(BOOL) resetHeaderContent;
-(BOOL) updateHeaderNameAt:(int)index name:(NSString *)name;
-(BOOL) updateHeaderNameArray:(NSArray *)headerArray columnWidthArray:(NSArray *)columnArray;

@property (nonatomic, retain) NSMutableArray *headerNameArray;
@property (nonatomic, retain) NSMutableArray *columnWidthArray;
@property (nonatomic) BOOL allowEditHeaderName;
@property (nonatomic) BOOL allowAdjustColumnWidth;
@end

