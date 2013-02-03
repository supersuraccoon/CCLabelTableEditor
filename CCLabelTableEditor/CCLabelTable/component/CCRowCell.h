#import "cocos2d.h"
#import "CCTableElement.h"
#import "CCSkinCenter.h"

@interface CCRowCell: CCTableElement {
    float cellWidth;
    NSString *cellString;
}

+(id) cellWithWidth:(float)width cellString:(NSString *)string skin:(CCSkinCenter *)skin;
-(id) initCellWithWidth:(float)width cellString:(NSString *)string skin:(CCSkinCenter *)skin;
-(void) updateWidth:(float)width;
-(void) updateContentWithString:(NSString *)string;

@property(nonatomic) float cellWidth;
@property(nonatomic, retain) NSString *cellString;

@end

