#import "cocos2d.h"
#import "CCElementSkin.h"

#define    kDefaultTableWidth                   400.0f
#define    kDefaultTableHeight                  200.0f
#define    kDefaultTableColor                   ccc3(255, 255, 255)
#define    kDefaultTableOpacity                 255
#define    kDefaultTableTextureFile             @""
#define    kDefaultTableTextureOpacity          255
#define    kDefaultTableFrameWidth              1.0f
#define    kDefaultTableFrameColor              ccc3(255, 255, 255)
#define    kDefaultTableFrameOpacity            255
#define    kDefaultMultiSelectFlag              NO
#define    kDefaultAllowEditCellFlag            YES

@interface CCTableAreaSkin : CCElementSkin {
    BOOL allowMultiSelectRow;
    BOOL allowEditCell;
}

@property (nonatomic) BOOL allowMultiSelectRow;
@property (nonatomic) BOOL allowEditCell;

@end

