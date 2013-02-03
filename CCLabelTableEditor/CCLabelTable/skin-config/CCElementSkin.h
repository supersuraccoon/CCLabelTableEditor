#import "cocos2d.h"
#import "CCTableMacro.h"

typedef enum {
    SKIN_TABLE = 1,
    SKIN_TITLE,
    SKIN_HEADER,
    SKIN_HEADER_CELL,
    SKIN_ROW,
    SKIN_ROW_EVEN,
    SKIN_ROW_CELL,
    SKIN_FOOTER,
    SKIN_GRID,
}SKIN_TYPE;

@interface CCElementSkin : NSObject {
    // element size
    float elementWidth;
    float elementHeight;
    
    // element color
    ccColor3B elementColor;
    float elementOpacity;
    ccColor3B elementColorSelected;
    float elementOpacitySelected;
    
    // texture
    NSString *elementTexture;
    float textureOpacity;
    NSString *elementTextureSelected;
    float textureOpacitySelected;
    
    // font
    NSString *fontName;
    float fontSize;
    ccColor3B fontColor;
    
    // frame
    ccColor3B frameColor;
    float frameWidth;
    float frameOpacity;
    
    //align
    ALIGN_STYLE alignStyle;
}

-(void) initDefaultSkin;
-(void) updateSkinWithDict:(NSMutableDictionary *)skinDict;
-(void) updateConfigWithDict:(NSMutableDictionary *)skinDict;
-(void) parseSkinToDict:(NSMutableDictionary *)skinDict;

-(BOOL) updateElementWidth:(float)width;
-(BOOL) updateElementHeight:(float)height;
-(BOOL) updateFontName:(NSString *)fontName;
-(BOOL) updateFontSize:(float)size;
-(BOOL) updateFontColor:(ccColor3B)color;
-(BOOL) updateElementColor:(ccColor3B)color;
-(BOOL) updateElementColorSelected:(ccColor3B)color;
-(BOOL) updateElementOpacity:(float)opacity;
-(BOOL) updateElementOpacitySelected:(float)opacity;
-(BOOL) updateTexture:(NSString *)textureFile;
-(BOOL) updateTextureSelected:(NSString *)textureFile;
-(BOOL) updateTextureOpacity:(float)opacity;
-(BOOL) updateTextureOpacitySelected:(float)opacity;
-(BOOL) updateFrameWidth:(float)width;
-(BOOL) updateFrameColor:(ccColor3B)color;
-(BOOL) updateFrameOpacity:(float)opacity;
-(BOOL) updateAlign:(ALIGN_STYLE)alignStyle;

@property (nonatomic) float elementWidth;
@property (nonatomic) float elementHeight;
@property (nonatomic) ccColor3B elementColor;
@property (nonatomic) ccColor3B elementColorSelected;
@property (nonatomic) float elementOpacity;
@property (nonatomic) float elementOpacitySelected;
@property (nonatomic, retain) NSString *elementTexture;
@property (nonatomic, retain) NSString *elementTextureSelected;
@property (nonatomic) float textureOpacity;
@property (nonatomic) float textureOpacitySelected;
@property (nonatomic, retain) NSString *fontName;
@property (nonatomic) float fontSize;
@property (nonatomic) ccColor3B fontColor;
@property (nonatomic) ccColor3B frameColor;
@property (nonatomic) float frameWidth;
@property (nonatomic) float frameOpacity;
@property (nonatomic) ALIGN_STYLE alignStyle;

@end

