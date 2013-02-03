#import "CCSlidingMenuLayer.h"
#import "CCGSpriteRect.h"


#define ARROW_MENU_POS_TOP  ccp(20, 270)
#define ARROW_MENU_POS_BOTTOM  ccp(20, 50)
#define ARROW_MENU_POS_LEFT  ccp(50, 160)
#define ARROW_MENU_POS_RIGHT  ccp(518, 160)

@implementation CCSlidingMenuLayer

- (id) initWithTarget:(id)delegate position:(MENU_POSITION)menuPosition size:(CGSize)size frameColor:(ccColor4B)frameColor frameBgColor:(ccColor4B)frameBgColor animation:(ANIMATION_TYPE)animation
{
    if (self == [super initWithColor:ccc4(0, 0, 0, 0)]) {
        delegate_ = [delegate retain];
        MENU_POSITION_ = menuPosition;
        layerSize_ = size;
        frameColor_ = frameColor;
        frameBgColor_ = frameBgColor;
        isShowing_ = YES;
        animation_ = animation;
        [self initFrameSprite];
        [self intiMenu];
        if (animation_ == ANIMATION_TYPE_PROGRESS) [self initArrowProgressSprite];
        if (animation_ == ANIMATION_TYPE_BLINK || animation_ == ANIMATION_TYPE_TINT) [self initArrowSprite];
        [self runArrowMenuAction]; 
    }
    return self;
}

#pragma mark - init
- (void) initFrameSprite
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCGSpriteRect *frameSprite = [CCGSpriteRect rectWithRect:CGRectMake(self.position.x,
                                                                        self.position.y,
                                                                        layerSize_.width - 1,
                                                                        layerSize_.height - 1)
                                               withLineWidth:1.0f
                                               withLineColor:frameColor_];
    if (MENU_POSITION_ == MENU_POSITION_TOP) frameSprite.position = ccp(1, winSize.height - layerSize_.height - 1);
    if (MENU_POSITION_ == MENU_POSITION_BOTTOM) frameSprite.position = ccp(1, 0);
    if (MENU_POSITION_ == MENU_POSITION_LEFT) frameSprite.position = ccp(layerSize_.width, 0);
    if (MENU_POSITION_ == MENU_POSITION_RIGHT) frameSprite.position = ccp(winSize.width - layerSize_.width, 0);
    [self addChild:frameSprite z:0 tag:kTagFrameSprite];
}

- (void) initArrowProgressSprite
{
    CCProgressTimer *hideSpritePT = [CCProgressTimer progressWithSprite:[self spriteArrow:ARROW_HIDE]];
    CCProgressTimer *showSpritePT = [CCProgressTimer progressWithSprite:[self spriteArrow:ARROW_SHOW]];
    hideSpritePT.type = kCCProgressTimerTypeBar;
    showSpritePT.type = kCCProgressTimerTypeBar;
    hideSpritePT.midpoint = [self spriteArrowMidPoint:ARROW_HIDE];
    showSpritePT.midpoint = [self spriteArrowMidPoint:ARROW_SHOW];
    showSpritePT.visible = NO;
    if (MENU_POSITION_ == MENU_POSITION_TOP) showSpritePT.position = hideSpritePT.position = ARROW_MENU_POS_TOP;
    if (MENU_POSITION_ == MENU_POSITION_BOTTOM) showSpritePT.position = hideSpritePT.position = ARROW_MENU_POS_BOTTOM;
    if (MENU_POSITION_ == MENU_POSITION_LEFT) showSpritePT.position = hideSpritePT.position = ARROW_MENU_POS_LEFT;
    if (MENU_POSITION_ == MENU_POSITION_RIGHT) showSpritePT.position = hideSpritePT.position = ARROW_MENU_POS_RIGHT;
    [self addChild:showSpritePT z:999 tag:kTagShowLayerSprite];
    [self addChild:hideSpritePT z:999 tag:kTagHideLayerSprite];
}

- (void) initArrowSprite
{
    CCSprite *hideSprite = [self spriteArrow:ARROW_HIDE];
    CCSprite *showSprite = [self spriteArrow:ARROW_SHOW];
    showSprite.visible = NO;
    if (MENU_POSITION_ == MENU_POSITION_TOP) showSprite.position = hideSprite.position = ARROW_MENU_POS_TOP;
    if (MENU_POSITION_ == MENU_POSITION_BOTTOM) showSprite.position = hideSprite.position = ARROW_MENU_POS_BOTTOM;
    if (MENU_POSITION_ == MENU_POSITION_LEFT) showSprite.position = hideSprite.position = ARROW_MENU_POS_LEFT;
    if (MENU_POSITION_ == MENU_POSITION_RIGHT) showSprite.position = hideSprite.position = ARROW_MENU_POS_RIGHT;
    [self addChild:showSprite z:999 tag:kTagShowLayerSprite];
    [self addChild:hideSprite z:999 tag:kTagHideLayerSprite];
}

- (void) intiMenu
{
    CCSprite *hideSpriteNormal = [self spriteArrow:ARROW_HIDE]; 
    CCSprite *hideSpriteSelected = [self spriteArrow:ARROW_HIDE]; 
    CCSprite *showSpriteSelected = [self spriteArrow:ARROW_SHOW]; 
    CCSprite *showSpriteNormal = [self spriteArrow:ARROW_SHOW]; 
    hideSpriteSelected.color = ccORANGE;
    showSpriteSelected.color = ccORANGE;
    CCMenuItemToggle *arrowMenuItem = [CCMenuItemToggle itemWithTarget:self selector:@selector(arrowMenuSelector:) items:
                                       [CCMenuItemSprite itemWithNormalSprite:hideSpriteNormal selectedSprite:hideSpriteSelected],
                                       [CCMenuItemSprite itemWithNormalSprite:showSpriteNormal selectedSprite:showSpriteSelected],
                                       nil];
    arrowMenuItem.opacity = 0;
    CCMenu *showLayerMenu = [CCMenu menuWithItems:arrowMenuItem, nil];
    if (MENU_POSITION_ == MENU_POSITION_TOP) showLayerMenu.position = ARROW_MENU_POS_TOP;
    if (MENU_POSITION_ == MENU_POSITION_BOTTOM) showLayerMenu.position = ARROW_MENU_POS_BOTTOM;
    if (MENU_POSITION_ == MENU_POSITION_LEFT) showLayerMenu.position = ARROW_MENU_POS_LEFT;
    if (MENU_POSITION_ == MENU_POSITION_RIGHT) showLayerMenu.position = ARROW_MENU_POS_RIGHT;
    [self addChild:showLayerMenu z:999 tag:kTagArrowMenu];
}


#pragma mark - helper
- (CCSprite *) spriteArrow:(ARROW_TYPE)arrowType
{
    if (MENU_POSITION_ == MENU_POSITION_TOP && arrowType == ARROW_SHOW) return [CCSprite spriteWithFile:@"arrowdown.png"];
    if (MENU_POSITION_ == MENU_POSITION_TOP && arrowType == ARROW_HIDE) return [CCSprite spriteWithFile:@"arrowup.png"];
    if (MENU_POSITION_ == MENU_POSITION_BOTTOM && arrowType == ARROW_SHOW) return [CCSprite spriteWithFile:@"arrowup.png"];
    if (MENU_POSITION_ == MENU_POSITION_BOTTOM && arrowType == ARROW_HIDE) return [CCSprite spriteWithFile:@"arrowdown.png"];
    if (MENU_POSITION_ == MENU_POSITION_LEFT && arrowType == ARROW_SHOW) return [CCSprite spriteWithFile:@"arrowright.png"];
    if (MENU_POSITION_ == MENU_POSITION_LEFT && arrowType == ARROW_HIDE) return [CCSprite spriteWithFile:@"arrowleft.png"];
    if (MENU_POSITION_ == MENU_POSITION_RIGHT && arrowType == ARROW_SHOW) return [CCSprite spriteWithFile:@"arrowleft.png"];
    if (MENU_POSITION_ == MENU_POSITION_RIGHT && arrowType == ARROW_HIDE) return [CCSprite spriteWithFile:@"arrowright.png"];
    return nil;
}

- (CGPoint) spriteArrowMidPoint:(ARROW_TYPE)arrowType
{
    if (MENU_POSITION_ == MENU_POSITION_TOP && arrowType == ARROW_SHOW) return ccp(0.5f, 1);
    if (MENU_POSITION_ == MENU_POSITION_TOP && arrowType == ARROW_HIDE) return ccp(0.5f, 0);
    if (MENU_POSITION_ == MENU_POSITION_BOTTOM && arrowType == ARROW_SHOW) return ccp(0.5f, 0);
    if (MENU_POSITION_ == MENU_POSITION_BOTTOM && arrowType == ARROW_HIDE) return ccp(0.5f, 1);
    if (MENU_POSITION_ == MENU_POSITION_LEFT && arrowType == ARROW_SHOW) return ccp(0, 0.5f);
    if (MENU_POSITION_ == MENU_POSITION_LEFT && arrowType == ARROW_HIDE) return ccp(1, 0.5f);
    if (MENU_POSITION_ == MENU_POSITION_RIGHT && arrowType == ARROW_SHOW) return ccp(1, 0.5f);
    if (MENU_POSITION_ == MENU_POSITION_RIGHT && arrowType == ARROW_HIDE) return ccp(0, 0.5f);
    return CGPointZero;
}

#pragma mark - action
- (void) runArrowMenuAction
{
    if (animation_ == ANIMATION_TYPE_BLINK) [self runArrowMenuBlinkAction];
    if (animation_ == ANIMATION_TYPE_TINT) [self runArrowMenuTintAction];
    if (animation_ == ANIMATION_TYPE_PROGRESS) [self runProgressAction];
}

- (void) runArrowMenuBlinkAction
{
    CCSprite *hideSprite = (CCSprite *)[self getChildByTag:kTagHideLayerSprite];
    CCSprite *showSprite = (CCSprite *)[self getChildByTag:kTagShowLayerSprite];
    [(isShowing_ ? showSprite : hideSprite) stopAllActions];
    (isShowing_ ? showSprite : hideSprite).visible = NO;
    [(isShowing_ ? hideSprite : showSprite) runAction:[CCRepeatForever actionWithAction:[CCBlink actionWithDuration:1.0 blinks:1.0f]]];
}

- (void) runArrowMenuTintAction
{
    CCSprite *hideSprite = (CCSprite *)[self getChildByTag:kTagHideLayerSprite];
    CCSprite *showSprite = (CCSprite *)[self getChildByTag:kTagShowLayerSprite];
    [(isShowing_ ? showSprite : hideSprite) stopAllActions];
    (isShowing_ ? showSprite : hideSprite).visible = NO;
    [(isShowing_ ? hideSprite : showSprite) runAction:[CCRepeatForever actionWithAction:[CCTintTo actionWithDuration:1.0 red:255.0f green:0 blue:0]]];
}

- (void) runProgressAction
{
    CCProgressTimer *hideSpritePT = (CCProgressTimer *)[self getChildByTag:kTagHideLayerSprite];
    CCProgressTimer *showSpritePT = (CCProgressTimer *)[self getChildByTag:kTagShowLayerSprite];
    [hideSpritePT runAction: [CCRepeatForever actionWithAction:[CCProgressTo actionWithDuration:1.0 percent:100]]];
    [showSpritePT runAction: [CCRepeatForever actionWithAction:[CCProgressTo actionWithDuration:1.0 percent:100]]];
}

#pragma mark - selector
- (void) arrowMenuSelector:(id)sender
{
	int selectedIndex = (unsigned int)[sender selectedIndex] + 1;
	if (selectedIndex == 1) [self showSlidingLayer];
	if (selectedIndex == 2) [self hideSlidingLayer];
}

- (void) showSlidingLayer
{
    if (isShowing_) return;
    if (MENU_POSITION_ == MENU_POSITION_TOP) {
        [self runAction:[CCSequence actions:
                                [CCMoveBy actionWithDuration:0.3f position:ccp(0, -layerSize_.height)],
                                [CCCallFuncN actionWithTarget:self selector:@selector(showSlidingLayerOver:)],
                                nil]];
    }
    if (MENU_POSITION_ == MENU_POSITION_BOTTOM) {
        [self runAction:[CCSequence actions:
                                [CCMoveBy actionWithDuration:0.3f position:ccp(0, layerSize_.height)],
                                [CCCallFuncN actionWithTarget:self selector:@selector(showSlidingLayerOver:)],
                                nil]];
    }
    if (MENU_POSITION_ == MENU_POSITION_LEFT) {
        [self runAction:[CCSequence actions:
                                [CCMoveBy actionWithDuration:0.3f position:ccp(layerSize_.width, 0)],
                                [CCCallFuncN actionWithTarget:self selector:@selector(showSlidingLayerOver:)],
                                nil]];
    }
    if (MENU_POSITION_ == MENU_POSITION_RIGHT) {
        [self runAction:[CCSequence actions:
                                [CCMoveBy actionWithDuration:0.3f position:ccp(-layerSize_.width, 0)],
                                [CCCallFuncN actionWithTarget:self selector:@selector(showSlidingLayerOver:)],
                                nil]];
    }
    CCMenu *showLayerMenu = (CCMenu *)[self getChildByTag:kTagArrowMenu];
    showLayerMenu.visible = NO;
    CCProgressTimer *showSpritePT = (CCProgressTimer *)[self getChildByTag:kTagShowLayerSprite];
    showSpritePT.visible = NO;
}

- (void) hideSlidingLayer
{
    if (!isShowing_ ) return;
    if (MENU_POSITION_ == MENU_POSITION_TOP) {
        [self runAction:[CCSequence actions:
                                [CCMoveBy actionWithDuration:0.3f position:ccp(0, layerSize_.height)],
                                [CCCallFuncN actionWithTarget:self selector:@selector(hideSlidingLayerOver:)],
                                nil]];
    }
    if (MENU_POSITION_ == MENU_POSITION_BOTTOM) {
        [self runAction:[CCSequence actions:
                                [CCMoveBy actionWithDuration:0.3f position:ccp(0, -layerSize_.height)],
                                [CCCallFuncN actionWithTarget:self selector:@selector(hideSlidingLayerOver:)],
                                nil]];
    }
    if (MENU_POSITION_ == MENU_POSITION_LEFT) {
        [self runAction:[CCSequence actions:
                                [CCMoveBy actionWithDuration:0.3f position:ccp(-layerSize_.width, 0)],
                                [CCCallFuncN actionWithTarget:self selector:@selector(hideSlidingLayerOver:)],
                                nil]];
    }
    if (MENU_POSITION_ == MENU_POSITION_RIGHT) {
        [self runAction:[CCSequence actions:
                                [CCMoveBy actionWithDuration:0.3f position:ccp(layerSize_.width, 0)],
                                [CCCallFuncN actionWithTarget:self selector:@selector(hideSlidingLayerOver:)],
                                nil]];
    }
    CCMenu *showLayerMenu = (CCMenu *)[self getChildByTag:kTagArrowMenu];
    showLayerMenu.visible = NO;
    CCProgressTimer *hideSpritePT = (CCProgressTimer *)[self getChildByTag:kTagHideLayerSprite];
    hideSpritePT.visible = NO;
}

- (void) showSlidingLayerOver:(id)sender
{
    isShowing_ = YES;
    CCProgressTimer *hideSpritePT = (CCProgressTimer *)[self getChildByTag:kTagHideLayerSprite];
    hideSpritePT.visible = YES;
    CCMenu *showLayerMenu = (CCMenu *)[self getChildByTag:kTagArrowMenu];
    showLayerMenu.visible = YES;
    [self runArrowMenuAction];
    if (delegate_) [delegate_ showSlidingLayerOver];
}

- (void) hideSlidingLayerOver:(id)sender
{
    isShowing_ = NO;
    CCProgressTimer *showSpritePT = (CCProgressTimer *)[self getChildByTag:kTagShowLayerSprite];    
    showSpritePT.visible = YES;
    CCMenu *showLayerMenu = (CCMenu *)[self getChildByTag:kTagArrowMenu];
    showLayerMenu.visible = YES;
    [self runArrowMenuAction];
    if (delegate_) [delegate_ hideSlidingLayerOver];
}

@end
