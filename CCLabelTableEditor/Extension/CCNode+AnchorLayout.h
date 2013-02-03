#import "CCNode.h"

typedef enum {
    kCCNodeAnchorLeft,
    kCCNodeAnchorRight,
    kCCNodeAnchorTop,
    kCCNodeAnchorBottom,
    kCCNodeAnchorHorizontalCenter,
    kCCNodeAnchorVerticalCenter,
    kCCNodeAnchorCenterIn
}CCNodeAnchorT;

@interface CCNode(AnchorLayout)
//limitations:
//1. node should be added into node graph
//2. the referNode should be positioned
//3. if you need to set anchorPoint and scale, please do so before calling these methods
- (void) addAnchor: (CCNodeAnchorT)selfEdge referTo: (CCNode*)referNode edge: (CCNodeAnchorT)edge margin: (CGFloat)margin;
- (void) addAnchor: (CCNodeAnchorT)selfEdge referTo:(CCNode *)referNode edge: (CCNodeAnchorT)edge percent: (CGFloat)percent;
- (void) centerIn: (CCNode*)outerNode;

@end