#import "cocos2d.h"
#import "CCTableElement.h"
#import "CCSkinCenter.h"

@interface CCTableGrid: CCTableElement {
    int pageMaxRowCount;
}

+(id) gridWithMaxRowCount:(int)maxRowCount skin:(CCSkinCenter *)skin;
-(id) initGridWithMaxRowCount:(int)maxRowCount skin:(CCSkinCenter *)skin;
-(void) updateMaxRowCount:(int)maxRowCount;

@property (nonatomic) int pageMaxRowCount;

@end

