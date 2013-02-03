@interface NSString(FontSize)

-(float) stringWidthWithFont:(NSString *)fontName fontSize:(float)fontSize;
-(float) stringHeightWithFont:(NSString *)fontName fontSize:(float)fontSize;
- (NSString *) stringWithLimit:(int)length ellipsis:(NSString *)ellipsisString;
- (NSString *) stringWithLimit:(int)width ellipsis:(NSString *)ellipsisString fontName:(NSString *)fontName fontSize:(CGFloat)fontSize;
@end