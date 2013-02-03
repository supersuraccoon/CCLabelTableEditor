#import "cocos2d.h"

@interface CCMenu(Items)
- (void) enableMenuItem:(int)itemTag;
- (void) disableMenuItem:(int)itemTag;
- (void) enableAllMenuItem;
- (void) disableAllMenuItem;
- (CCMenuItem *) subMenuItem:(int)itemTag;
@end

@interface CCMenuItemToggle(Items)
- (void) removeMenuItem:(int)itemTag;
- (void) removeAllMenuItems;
- (void) appendMenuItem:(CCMenuItem *)newItem;
- (void) appendMenuItems:(CCMenuItem*) item, ...;
@end

