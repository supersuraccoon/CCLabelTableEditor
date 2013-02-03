#import "cocos2d.h"

#define kTagFrameSprite     900000
#define kTagArrowMenu       900001
#define kTagShowLayerSprite 900002
#define kTagHideLayerSprite 900003

typedef enum{
    MENU_POSITION_TOP,
    MENU_POSITION_BOTTOM,
    MENU_POSITION_LEFT,
    MENU_POSITION_RIGHT,
} MENU_POSITION;

typedef enum{
    ARROW_SHOW,
    ARROW_HIDE,
} ARROW_TYPE;

typedef enum{
    ANIMATION_TYPE_BLINK,
    ANIMATION_TYPE_TINT,
    ANIMATION_TYPE_PROGRESS,
} ANIMATION_TYPE;

@protocol CCSlidingMenuLayerProtocol <NSObject>
- (void) showSlidingLayerOver;
- (void) hideSlidingLayerOver;
@end

@interface CCSlidingMenuLayer : CCLayerColor {
    id<CCSlidingMenuLayerProtocol> delegate_;
    MENU_POSITION MENU_POSITION_;
    BOOL isShowing_;
    CGSize layerSize_;
    ccColor4B frameColor_;
    ccColor4B frameBgColor_;
    ANIMATION_TYPE animation_;
}

- (id) initWithTarget:(id)delegate position:(MENU_POSITION)menuPosition size:(CGSize)size frameColor:(ccColor4B)frameColor frameBgColor:(ccColor4B)frameBgColor animation:(ANIMATION_TYPE)animation;

- (void) intiMenu;
- (void) initFrameSprite;
- (void) initArrowSprite;
- (void) initArrowProgressSprite;

- (CCSprite *) spriteArrow:(ARROW_TYPE)arrowType;
- (CGPoint) spriteArrowMidPoint:(ARROW_TYPE)arrowType;

- (void) runArrowMenuAction;
- (void) runArrowMenuBlinkAction;
- (void) runArrowMenuTintAction;
- (void) runProgressAction;

- (void) showSlidingLayer;
- (void) hideSlidingLayer;
- (void) showSlidingLayerOver:(id)sender;
- (void) hideSlidingLayerOver:(id)sender;
- (void) arrowMenuSelector:(id)sender;

@end
