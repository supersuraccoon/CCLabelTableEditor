#import "NSString+FontSize.h"

@implementation NSString(FontSize)
-(float) stringWidthWithFont:(NSString *)fontName fontSize:(float)fontSize {
	CGSize fontDim = [self sizeWithFont:[UIFont fontWithName:fontName size:fontSize]];
	return fontDim.width;
}

-(float) stringHeightWithFont:(NSString *)fontName fontSize:(float)fontSize {
	CGSize fontDim = [self sizeWithFont:[UIFont fontWithName:fontName size:fontSize]];
	return fontDim.height;
}

- (NSString *) stringWithLimit:(int)length ellipsis:(NSString *)ellipsisString
{
    if ([self length] <= length) return self;
    return [NSString stringWithFormat:@"%@%@", [self substringToIndex:length], ellipsisString];
}

- (NSString *) stringWithLimit:(int)width ellipsis:(NSString *)ellipsisString fontName:(NSString *)fontName fontSize:(CGFloat)fontSize
{
    float stringWidth = [self stringWidthWithFont:fontName fontSize:fontSize];
    if (stringWidth <= width) return self;
    int maxIndex;
    for (maxIndex = 0; maxIndex < [self length]; maxIndex ++) {
        NSString *tempString = [NSString stringWithFormat:@"%@%@", [self substringWithRange:NSMakeRange(0, maxIndex)], ellipsisString];
        float stringWidth = [tempString stringWidthWithFont:fontName fontSize:fontSize];
        if (stringWidth > width) break;
    }
    return [NSString stringWithFormat:@"%@%@", [self substringToIndex:maxIndex], ellipsisString];
}

@end