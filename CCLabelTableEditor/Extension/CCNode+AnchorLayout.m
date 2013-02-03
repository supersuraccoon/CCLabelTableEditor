#import "CCNode+AnchorLayout.h"

@implementation CCNode(AnchorLayout)

#pragma mark - private methods
- (CGFloat) edgeOfParentNode:(CCNode*)node ofAnchor:(CCNodeAnchorT)anchor
{
    CGSize size = [node contentSize];
    switch (anchor)
    {
        case kCCNodeAnchorTop:
            return size.height * node.scaleY;
            
        case kCCNodeAnchorLeft:
            return 0.0;
            
        case kCCNodeAnchorBottom:
            return 0.0;
            
        case kCCNodeAnchorRight:
            return size.width * node.scaleX;
            
        case kCCNodeAnchorHorizontalCenter:
            return size.width * node.scaleX /2;
            
        case kCCNodeAnchorVerticalCenter:
            return size.height * node.scaleY /2;
            
        default:
            return 0.0;
    }
}


- (CGFloat) edgeOfSiblingNode: (CCNode*)node ofAnchor: (CCNodeAnchorT)anchor
{
    CGPoint nodePosition = [node position];
    CGPoint nodeCenter = CGPointMake(nodePosition.x + (0.5-node.anchorPoint.x) * node.contentSize.width * node.scaleX, nodePosition.y+ (0.5-node.anchorPoint.y) * node.contentSize.height * node.scaleY);
    
    switch (anchor)
    {
        case kCCNodeAnchorTop:
            return nodeCenter.y +0.5 * node.contentSize.height * node.scaleY;
            
        case kCCNodeAnchorLeft:
            return nodeCenter.x -0.5 * node.contentSize.width * node.scaleX;
            
        case kCCNodeAnchorBottom:
            return nodeCenter.y -0.5 * node.contentSize.height * node.scaleY;
            
        case kCCNodeAnchorRight:
            return nodeCenter.x +0.5 * node.contentSize.width * node.scaleX;
            
        case kCCNodeAnchorHorizontalCenter:
            return nodeCenter.x;
            
        case kCCNodeAnchorVerticalCenter:
            return nodeCenter.y;
            
        default:
            break;
    }
    
    return 0.0;
}


#pragma mark - public methods
- (void) addAnchor:(CCNodeAnchorT)selfEdge referTo:(CCNode *)referNode edge:(CCNodeAnchorT)edge margin:(CGFloat)margin
{
    CGPoint oldPositon = [self position];
    CGFloat centerX = 0.0;
    CGFloat centerY = 0.0;
    CGFloat selfWidth = self.contentSize.width *self.scaleX;
    CGFloat selfHeight = self.contentSize.height *self.scaleY;
    
    if (self.parent == referNode)
    {
        //parent-child relationship
        switch (selfEdge)
        {
            case kCCNodeAnchorTop:
                centerY = [self edgeOfParentNode: referNode ofAnchor: edge] - margin - selfHeight / 2;
                self.position =CGPointMake(oldPositon.x, centerY + (self.anchorPoint.y -0.5) * selfHeight);
                break;
                
            case kCCNodeAnchorLeft:
                centerX = [self edgeOfParentNode: referNode ofAnchor: edge] + margin + selfWidth / 2;
                self.position =CGPointMake(centerX + (self.anchorPoint.x -0.5) * selfWidth, oldPositon.y);
                break;
                
            case kCCNodeAnchorBottom:
                centerY = [self edgeOfParentNode: referNode ofAnchor: edge] + margin + selfHeight / 2;
                self.position =CGPointMake(oldPositon.x, centerY + (self.anchorPoint.y -0.5) * selfHeight);
                break;
                
            case kCCNodeAnchorRight:
                centerX = [self edgeOfParentNode: referNode ofAnchor: edge] - margin - selfWidth / 2;
                self.position =CGPointMake(centerX + (self.anchorPoint.x -0.5) * selfWidth, oldPositon.y);
                break;
                
            case kCCNodeAnchorHorizontalCenter:
                centerX = [self edgeOfParentNode: referNode ofAnchor: edge];
                self.position =CGPointMake(centerX + (self.anchorPoint.x -0.5) * selfWidth, oldPositon.y);
                break;
                
            case kCCNodeAnchorVerticalCenter:
                centerY = [self edgeOfParentNode: referNode ofAnchor: edge];
                self.position =CGPointMake(oldPositon.x, centerY + (self.anchorPoint.y -0.5) * selfHeight);
                break;
                
            case kCCNodeAnchorCenterIn:
                centerX = [self edgeOfParentNode: referNode ofAnchor:kCCNodeAnchorHorizontalCenter];
                centerY = [self edgeOfParentNode: referNode ofAnchor:kCCNodeAnchorVerticalCenter];
                self.position =CGPointMake(centerX + (self.anchorPoint.x -0.5) * selfWidth, centerY + (self.anchorPoint.y -0.5) * selfHeight);
                break;
                
            default:
                break;
        }
    }
    else if (self.parent == referNode.parent)
    {
        //two nodes are siblings
        switch (selfEdge)
        {
            case kCCNodeAnchorTop:
                centerY = [self edgeOfSiblingNode: referNode ofAnchor: edge] - margin - selfHeight / 2;
                self.position =CGPointMake(oldPositon.x, centerY + (self.anchorPoint.y -0.5) * selfHeight);
                break;
                
            case kCCNodeAnchorLeft:
                centerX = [self edgeOfSiblingNode: referNode ofAnchor: edge] + margin + selfWidth / 2;
                self.position =CGPointMake(centerX + (self.anchorPoint.x -0.5) * selfWidth, oldPositon.y);
                break;
                
            case kCCNodeAnchorBottom:
                centerY = [self edgeOfSiblingNode: referNode ofAnchor: edge] + margin + selfHeight / 2;
                self.position =CGPointMake(oldPositon.x, centerY + (self.anchorPoint.y -0.5) * selfHeight);
                break;
                
            case kCCNodeAnchorRight:
                centerX = [self edgeOfSiblingNode: referNode ofAnchor: edge] - margin - selfWidth / 2;
                self.position =CGPointMake(centerX + (self.anchorPoint.x -0.5) * selfWidth, oldPositon.y);
                break;
                
            case kCCNodeAnchorHorizontalCenter:
                centerX = [self edgeOfSiblingNode: referNode ofAnchor: edge];
                self.position =CGPointMake(centerX + (self.anchorPoint.x -0.5) * selfWidth, oldPositon.y);
                break;
                
            case kCCNodeAnchorVerticalCenter:
                centerY = [self edgeOfSiblingNode: referNode ofAnchor: edge];
                self.position =CGPointMake(oldPositon.x, centerY + (self.anchorPoint.y -0.5) * selfHeight);
                break;
                
            case kCCNodeAnchorCenterIn:
                centerX = [self edgeOfSiblingNode: referNode ofAnchor:kCCNodeAnchorHorizontalCenter];
                centerY = [self edgeOfSiblingNode: referNode ofAnchor:kCCNodeAnchorVerticalCenter];
                self.position =CGPointMake(centerX + (self.anchorPoint.x -0.5) * selfWidth, centerY + (self.anchorPoint.y -0.5) * selfHeight);
                break;
                
            default:
                break;
        }
    }
    else
    {
        //not allowed
        NSAssert(NO, @"The two nodes must be parent-child or siblings!");
    }
}


- (void) centerIn:(CCNode *)outerNode
{
    //[self addAnchor:kCCNodeAnchorCenterIn: outerNode edge:kCCNodeAnchorCenterIn:0];
}

- (void) addAnchor:(CCNodeAnchorT)selfEdge    
           referTo:(CCNode *)referNode
              edge:(CCNodeAnchorT)edge
           percent:(CGFloat)percent
{
    CGFloat referWidth = referNode.contentSize.width *referNode.scaleX;
    CGFloat referHeight = referNode.contentSize.height *referNode.scaleY;
    
    if (self.parent != referNode)
        NSAssert(NO, @"The two nodes must be parent-child");
    
    CGFloat margin = 0;
    if(selfEdge==kCCNodeAnchorLeft || selfEdge==kCCNodeAnchorRight) // X
    {
        margin = percent * referWidth;
    }
    else if(selfEdge==kCCNodeAnchorTop || selfEdge==kCCNodeAnchorBottom) //Y
    {
        margin = percent * referHeight;
    }
    [self addAnchor:selfEdge referTo:referNode edge:edge margin:margin];
} 

@end