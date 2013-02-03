#import "cocos2d.h"
#import "CCTableElement.h"
#import "CCTableRow.h"
#import "CCRowCell.h"
#import "CCSkinCenter.h"

@interface CCTableArea: CCTableElement {
    int rowsInTabeArea;
}

+(id) tableAreaWithSkin:(CCSkinCenter *)skin;
-(id) initWithSkin:(CCSkinCenter *)skin;

-(void) updateRows:(NSArray *)rowsStringArray;
-(void) removeAllRows;
-(void) updateRowsPosition;

-(CCTableRow *) rowFromLocation:(CGPoint)position;

-(void) selectRow:(CCTableRow *)tableRow;
-(void) unselectRow:(CCTableRow *)tableRow;
-(void) selectAllRows;
-(void) unselectAllRows;
-(NSMutableArray *) selectedRows;
@property(nonatomic) int rowsInTabeArea;

@end

