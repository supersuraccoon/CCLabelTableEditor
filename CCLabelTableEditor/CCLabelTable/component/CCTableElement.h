#import "cocos2d.h"
#import "CCSkinCenter.h"

@interface CCTableElement: CCLayerColor {
    CCSprite* textureSprite;
    CCSkinCenter *skinCenter;
}

-(id) initWithSkin:(CCSkinCenter *)skin;
-(CCElementSkin *) skinElement;

-(void) updateElementContent;
-(void) updateElementPosition;
-(void) updateElementSize;
-(void) updateElementTexture;
-(void) updateElementTextureScale;
-(void) updateElementColor;
-(void) updateElementFrame;

-(BOOL) hitTest:(CGPoint)position;

@property (nonatomic, retain) CCSprite* textureSprite;
@property (nonatomic, retain) CCSkinCenter *skinCenter;

@end

