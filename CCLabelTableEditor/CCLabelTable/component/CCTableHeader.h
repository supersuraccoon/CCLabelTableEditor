#import "cocos2d.h"
#import "CCTableElement.h"
#import "CCHeaderCell.h"
#import "CCSkinCenter.h"

@interface CCTableHeader: CCTableElement {}

+(id) hearderWithSkin:(CCSkinCenter *)skin;
-(id) initHeaderWithSkin:(CCSkinCenter *)skin;
-(CCHeaderCell *) headerCellFromLocation:(CGPoint)position;

@end

