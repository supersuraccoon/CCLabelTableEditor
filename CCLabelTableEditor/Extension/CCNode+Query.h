#import "cocos2d.h"

@interface CCNode (Query)
- (CCArray *) childrenWithType:(Class)classType;
@end
