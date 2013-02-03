#import "cocos2d.h"
#import "CCTableElement.h"
#import "CCSkinCenter.h"

@interface CCTableFooter: CCTableElement {
    int currentPage;
    int totalPage;
}

+(id) footerWithSkin:(CCSkinCenter *)skin;
-(id) initFooterWithSkin:(CCSkinCenter *)skin;
-(void) updateCurrentPage:(int)cPage totalPage:(int)tPage;

@property(nonatomic) int currentPage;
@property(nonatomic) int totalPage;

@end

