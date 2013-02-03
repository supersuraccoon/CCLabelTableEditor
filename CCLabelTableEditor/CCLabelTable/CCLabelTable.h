#import "cocos2d.h"
#import "CCTableMacro.h"
#import "CCSkinCenter.h"
#import "CCTableElementCenter.h"
#import "CCTableGestureLayer.h"

// table property
#define    kDefaultPage                     1
#define    kDefaultEnableTouch              YES

@protocol CCLabelTableDataSource<NSObject>
@required
-(int) tableRowCount;
-(NSArray *) rowStringArrayAtIndex:(int)rowIndex;
@optional
-(void) tablePageUpdate:(int)currentPage totalPage:(int)totalPage;
-(void) rowSelected:(int)rowIndex rowsSelected:(NSArray *)selectedRowArray;
-(BOOL) insertRowBefore:(int)rowIndex;
-(BOOL) insertRowAfter:(int)rowIndex;
-(void) updateTitleString:(NSString *)oldTitleString;
-(void) updateHeaderCell:(int)headerCellIndex oldHeaderString:(NSString *)oldHeaderName;
-(void) updateCell:(int)cellIndex atRow:(int)rowIndex oldCellString:(NSString *)oldCellString;
-(BOOL) removeRowAt:(int)rowIndex;
@end

@interface CCLabelTable : CCLayerColor<CCTableGestureLayerDelegate> {
    // data source
    id<CCLabelTableDataSource> dataSource;
    // skin
    CCSkinCenter *skinCenter;
    // component
    CCTableElementCenter *tableElementCenter;
    // page
    int pageMaxRowCount;
    int pageCount;
    int currentPage;   
    CCHeaderCell *targetHeaderCell;
}

// init
+(id) tableWithDataSource:(id)source color:(ccColor4B)color width:(int)width height:(int)height title:(NSString *)title header:(NSArray *)headerArray columnWidth:(NSArray *)columnArray;
+(id) tableWithDataSource:(id)source tableSkinFile:(NSString *)tableSkinFile;
-(id) initWithDataSource:(id)source color:(ccColor4B)color width:(int)width height:(int)height title:(NSString *)title header:(NSArray *)headerArray columnWidth:(NSArray *)columnArray skinFile:(NSString *)skinFile;

// update
-(void) updateElementWidth:(float)width type:(SKIN_TYPE)type;
-(void) updateElementHeight:(float)height type:(SKIN_TYPE)type;
-(void) updateFontName:(NSString *)name type:(SKIN_TYPE)type;
-(void) updateFontSize:(float)size type:(SKIN_TYPE)type;
-(void) updateFontColor:(ccColor3B)color type:(SKIN_TYPE)type;
-(void) updateElementColor:(ccColor3B)color type:(SKIN_TYPE)type state:(BOOL)isNormal;
-(void) updateElementOpacity:(float)opacity type:(SKIN_TYPE)type state:(BOOL)isNormal;
-(void) updateElementTexture:(NSString *)textureFile type:(SKIN_TYPE)type state:(BOOL)isNormal;
-(void) updateTextureOpacity:(float)opacity type:(SKIN_TYPE)type state:(BOOL)isNormal;
-(void) updateFrameWidth:(float)width type:(SKIN_TYPE)type;
-(void) updateFrameColor:(ccColor3B)color type:(SKIN_TYPE)type;
-(void) updateFrameOpacity:(float)opacity type:(SKIN_TYPE)type;
-(void) updateAlign:(ALIGN_STYLE)align type:(SKIN_TYPE)type;

-(void) updateTitleString:(NSString *)titleString;
-(void) updateHeaderNameAt:(int)headerCell name:(NSString *)headerName;

// table
-(void) reloadTableContent;

// skin
-(BOOL) exportTableSkinToFile:(NSString *)fileName;
-(void) updateTableSkin:(NSString *)fileName;

// page
-(void) nextPage;
-(void) prePage;
-(void) firstPage;
-(void) lastPage;

// touch
-(void) enableGesture:(BOOL)enableFlag;

@property (nonatomic, retain) id<CCLabelTableDataSource> dataSource;
@property (nonatomic, retain) CCTableElementCenter *tableElementCenter;
@property (nonatomic, retain) CCSkinCenter *skinCenter;
@property (nonatomic) int pageMaxRowCount;
@property (nonatomic) int pageCount;
@property (nonatomic) int currentPage;
@property (nonatomic, retain) CCTableGestureLayer *gestureLayer;
    
@end

