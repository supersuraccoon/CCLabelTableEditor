#import "CCMenu+Items.h"

@implementation CCMenu(Items)
- (void) enableAllMenuItem {
    CCMenuItem *item;
    CCARRAY_FOREACH(children_, item){
        [item setIsEnabled:YES];
    }  
}

- (void) disableAllMenuItem {
    CCMenuItem *item;
    CCARRAY_FOREACH(children_, item){
        [item setIsEnabled:NO];
    }  
}

- (void) enableMenuItem:(int)itemTag {
    CCMenuItem *item;
    CCARRAY_FOREACH(children_, item){
        if (item.tag == itemTag) [item setIsEnabled:YES];
    }  
}

- (void) disableMenuItem:(int)itemTag {
    CCMenuItem *item;
    CCARRAY_FOREACH(children_, item){
        if (item.tag == itemTag) [item setIsEnabled:NO];
    } 
}

- (CCMenuItem *) subMenuItem:(int)itemTag {
    CCMenuItem *item;
    CCARRAY_FOREACH(children_, item){
        if (item.tag == itemTag) return item;
    } 
    return nil;
}
@end


@implementation CCMenuItemToggle(Items)
- (void) removeMenuItem:(int)itemTag {
    for(CCMenuItem* item in subItems_) {
        if (item.tag == itemTag) {
            [item removeFromParentAndCleanup:YES];
            [subItems_ removeObject:item];
            break;
        }
    }
}

- (void) removeAllMenuItems {
    for(CCMenuItem* item in subItems_) {
        [item removeFromParentAndCleanup:YES];
    }
    [subItems_ removeAllObjects];
}

- (void) appendMenuItem:(CCMenuItem *)newItem {
    for(CCMenuItem* item in subItems_) {
        if (item.tag == newItem.tag || item == newItem) {
            return;
        }
    }
    [self.subItems addObject:newItem];
}

- (void) appendMenuItems:(CCMenuItem*) item, ... {
    va_list args;
    va_start(args, item);
    CCMenuItem *i;
    while ((i = va_arg(args, CCMenuItem*))) { 
        [self.subItems addObject:i];
    } 
    va_end(args);
    
    [self activate];
}

@end
