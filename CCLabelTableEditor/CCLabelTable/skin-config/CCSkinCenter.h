#import "cocos2d.h"
#import "CCElementSkin.h"
#import "CCTableAreaSkin.h"
#import "CCTitleSkin.h"
#import "CCHeaderSkin.h"
#import "CCHeaderCellSkin.h"
#import "CCRowSkin.h"
#import "CCRowEvenSkin.h"
#import "CCRowCellSkin.h"
#import "CCFooterSkin.h"
#import "CCGridSkin.h"

@interface CCSkinCenter: NSObject {
    CCTableAreaSkin *tableAreaSkin;
    CCTitleSkin *titleSkin;
    CCHeaderSkin *headerSkin;
    CCHeaderCellSkin *headerCellSkin;
    CCRowSkin *rowSkin;
    CCRowEvenSkin *rowEvenSkin;
    CCRowCellSkin *rowCellSkin;
    CCFooterSkin *footerSkin;
    CCGridSkin *gridSkin;
}

-(id) initDefaultSkin;
-(void) loadSkinWithFile:(NSString *)skinFileName;
-(void) updateSkinWithFile:(NSString *)skinFileName;
-(BOOL) exportTableSkinToFile:(NSString *)fileName;

-(CCElementSkin *) skinElementFromType:(SKIN_TYPE)type;

-(BOOL) updateElementContent:(NSString *)content type:(SKIN_TYPE)type;
-(BOOL) updateElementWidth:(float)width type:(SKIN_TYPE)type;
-(BOOL) updateElementHeight:(float)height type:(SKIN_TYPE)type;
-(BOOL) updateFontName:(NSString *)name type:(SKIN_TYPE)type;
-(BOOL) updateFontSize:(float)size type:(SKIN_TYPE)type;
-(BOOL) updateFontColor:(ccColor3B)color type:(SKIN_TYPE)type;
-(BOOL) updateElementColor:(ccColor3B)color type:(SKIN_TYPE)type;
-(BOOL) updateElementColorSelected:(ccColor3B)color type:(SKIN_TYPE)type;
-(BOOL) updateElementOpacity:(float)opacity type:(SKIN_TYPE)type;
-(BOOL) updateElementOpacitySelected:(float)opacity type:(SKIN_TYPE)type;
-(BOOL) updateElementTexture:(NSString *)textureFile type:(SKIN_TYPE)type;
-(BOOL) updateElementTextureSelected:(NSString *)textureFile type:(SKIN_TYPE)type;
-(BOOL) updateTextureOpacity:(float)opacity type:(SKIN_TYPE)type;
-(BOOL) updateTextureOpacitySelected:(float)opacity type:(SKIN_TYPE)type;
-(BOOL) updateFrameWidth:(float)width type:(SKIN_TYPE)type;
-(BOOL) updateFrameColor:(ccColor3B)color type:(SKIN_TYPE)type;
-(BOOL) updateFrameOpacity:(float)opacity type:(SKIN_TYPE)type;
-(BOOL) updateAlign:(ALIGN_STYLE)align type:(SKIN_TYPE)type;

@property (nonatomic, retain) CCTableAreaSkin *tableAreaSkin;
@property (nonatomic, retain) CCTitleSkin *titleSkin;
@property (nonatomic, retain) CCHeaderSkin *headerSkin;
@property (nonatomic, retain) CCHeaderCellSkin *headerCellSkin;
@property (nonatomic, retain) CCRowSkin *rowSkin;
@property (nonatomic, retain) CCRowEvenSkin *rowEvenSkin;
@property (nonatomic, retain) CCRowCellSkin *rowCellSkin;
@property (nonatomic, retain) CCFooterSkin *footerSkin;
@property (nonatomic, retain) CCGridSkin *gridSkin;
    
@end

