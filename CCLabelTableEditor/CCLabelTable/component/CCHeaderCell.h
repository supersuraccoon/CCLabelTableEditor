#import "cocos2d.h"
#import "CCTableElement.h"
#import "CCSkinCenter.h"

@interface CCHeaderCell: CCTableElement {
    float cellWidth;
    NSString *cellString;
}

+(id) cellWithWidth:(float)width cellString:(NSString *)string skin:(CCSkinCenter *)skin;
-(id) initCellWithWidth:(float)width cellString:(NSString *)string skin:(CCSkinCenter *)skin;
-(void) updateContentWithString:(NSString *)string;
-(void) updateElementContent;
-(void) updateWidth:(float)width;

@property(nonatomic) float cellWidth;
@property(nonatomic, retain) NSString *cellString;

@end

