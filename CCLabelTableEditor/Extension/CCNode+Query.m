#import "CCNode+Query.h"

@implementation CCNode (Query)
- (CCArray *) childrenWithType:(Class)classType {
    CCArray *childrenArray = [[CCArray alloc] init];
    CCNode *child;
    CCARRAY_FOREACH(children_, child)
        if ([child isKindOfClass:classType]) [childrenArray addObject:child];
    return childrenArray;
}
@end
