#import "NSArray+Comparison.h"

@implementation NSArray (Comparison)
- (BOOL) allObjectsIdenticalWith:(NSArray *)anotherArray {
    if ([self count] != [anotherArray count]) return NO;
    for (int i = 0; i < [self count]; i++) {
        //if ([self objectAtIndex:i] != [anotherArray objectAtIndex:i]) return NO;
        if ([[self objectAtIndex:i] isEqualToString:[anotherArray objectAtIndex:i]]) return NO;
    }
    return YES;
}
@end

