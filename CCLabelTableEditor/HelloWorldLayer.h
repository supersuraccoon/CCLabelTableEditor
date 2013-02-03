#import "cocos2d.h"
#import "CCLabelTable.h"
#import "SDColourWheel.h"
#import "NIDropDown.h"
#import "CCSlidingMenuLayer.h"
#import "YIPopupTextView.h"

typedef enum {
    TC_ELEMENT_WIDTH = 1,
    TC_ELEMENT_HEIGHT,
    TC_FONT_NAME,
    TC_FONT_SIZE,
    TC_FONT_COLOR,
    TC_ELEMENT_OPACITY,
    TC_ELEMENT_COLOR,
    TC_TEXTURE_OPACITY,
    TC_ELEMENT_TEXTURE,
    TC_FRAME_COLOR,
    TC_FRAME_WIDTH,
    TC_FRAME_OPACITY,
    TC_ALIGN_STYLE,
    TC_UNKNOW,
}TargetCategory;

typedef enum {
    DP_FONT_NAME = 1,
    DP_TEXTURE,
    DP_ALIGN_STYLE,
    DP_SKIN,
    DP_TABLE,
    DP_TOUCH_FLAG,
}DropDownType;

@interface HelloWorldLayer : CCLayer<SDColourWheelDelegate, NIDropDownDelegate, UIAlertViewDelegate, YIPopupTextViewDelegate> {
    CCArray *dataArray;
    CCArray *fontNameArray;
    CCArray *resourceImageArray;
    CCLabelTable * labelTable;
    NSString *titleString;
    NSArray *headerTitleArray;
    NSArray *columnWidthArray;
    
    SDColourWheel *sdColourWheel;
    CCMenu *topMenu;
    CCMenu *bottomMenu;
    NIDropDown *dropDown;
    UISlider *mSlider;
    SKIN_TYPE targetSkin;
    BOOL isNormalState;
    TargetCategory targetProperty;    
}

+(CCScene *) scene;
-(void) initData;
-(void) initSlidingMenu;
-(void) initSystemFontArray;
-(void) initResourceImageArray;
-(CCArray *)listUserTables;

-(void) showDropDownBoxWithRect:(CGRect)rect length:(float)length dataSource:(NSArray *)dataSource tag:(int)tag;

@property(nonatomic, retain) NSString *titleString;
@property(nonatomic, retain) NSArray *headerTitleArray;
@property(nonatomic, retain) NSArray *columnWidthArray;


@end
