#import "cocos2d.h"
#import "CCTableArea.h"
#import "CCTableTitle.h"
#import "CCTableHeader.h"
#import "CCHeaderCell.h"
#import "CCTableRow.h"
#import "CCRowCell.h"
#import "CCTableFooter.h"
#import "CCTableGrid.h"
#import "CCSkinCenter.h"

@interface CCTableElementCenter: CCNode {
    CCSkinCenter *skinCenter;
    CCTableArea *tableArea;
    CCTableTitle *tableTitle;
    CCTableHeader *tableHeader;
    CCTableFooter *tableFooter;
    CCTableGrid *tableGrid;
}

-(id) initWithSkin:(CCSkinCenter *)skin;
// update
-(BOOL) updateElementWidth:(float)width type:(SKIN_TYPE)type;
-(BOOL) updateElementHeight:(float)height type:(SKIN_TYPE)type;
-(BOOL) updateFontName:(NSString *)name type:(SKIN_TYPE)type;
-(BOOL) updateFontSize:(float)size type:(SKIN_TYPE)type;
-(BOOL) updateFontColor:(ccColor3B)color type:(SKIN_TYPE)type;
-(BOOL) updateElementColor:(ccColor3B)color type:(SKIN_TYPE)type state:(BOOL)isNormal;
-(BOOL) updateElementOpacity:(float)opacity type:(SKIN_TYPE)type state:(BOOL)isNormal;
-(BOOL) updateElementTexture:(NSString *)textureFile type:(SKIN_TYPE)type state:(BOOL)isNormal;
-(BOOL) updateTextureOpacity:(float)opacity type:(SKIN_TYPE)type state:(BOOL)isNormal;
-(BOOL) updateFrameWidth:(float)width type:(SKIN_TYPE)type;
-(BOOL) updateFrameColor:(ccColor3B)color type:(SKIN_TYPE)type;
-(BOOL) updateFrameOpacity:(float)opacity type:(SKIN_TYPE)type;
-(BOOL) updateAlign:(ALIGN_STYLE)align type:(SKIN_TYPE)type;

@property (nonatomic, retain) CCSkinCenter *skinCenter;
@property (nonatomic, retain) CCTableArea *tableArea;
@property (nonatomic, retain) CCTableTitle *tableTitle;
@property (nonatomic, retain) CCTableHeader *tableHeader;
@property (nonatomic, retain) CCTableFooter *tableFooter;
@property (nonatomic, retain) CCTableGrid *tableGrid;

@end

