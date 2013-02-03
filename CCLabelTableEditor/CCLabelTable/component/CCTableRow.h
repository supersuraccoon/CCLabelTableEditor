#import "cocos2d.h"
#import "CCTableElement.h"
#import "CCSkinCenter.h"
#import "CCRowCell.h"

@interface CCTableRow: CCTableElement {
    NSArray *rowStringArray;
    BOOL isSelected;
}

+(id) rowWithRowStringArray:(NSArray *)rowArray skin:(CCSkinCenter *)skin;
-(id) initRowWithRowStringArray:(NSArray *)rowArray skin:(CCSkinCenter *)skin;
-(void) updateRowStringArray:(NSArray *)rowArray;

-(CCRowCell *) cellFromLocation:(CGPoint)position;

-(void) createRowCell;
-(void) selectRowEffect;
-(void) unselectRowEffect;

@property (nonatomic) BOOL isSelected;
@property (nonatomic, retain) NSArray *rowStringArray;

@end

