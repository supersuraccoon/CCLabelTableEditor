#import "HelloWorldLayer.h"
#import "AppDelegate.h"
#import "UIAlertView+Blocks.h"
#import "CCMenu+Items.h"

@implementation HelloWorldLayer
@synthesize headerTitleArray;
@synthesize columnWidthArray;
@synthesize titleString;

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init {
	if( (self=[super init]) ) {
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"CCLabelTable Demo" fontName:@"Marker Felt" fontSize:32];
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		label.position =  ccp( winSize.width /2 , winSize.height/2 );
		[self addChild:label];
        [self initData];
        [self initSlidingMenu];
        [self initSystemFontArray];
        [self initResourceImageArray];
    }
	return self;
}

-(void) initData {
    dataArray = [[CCArray alloc] init];
    self.headerTitleArray = [[NSArray alloc] init];
    self.columnWidthArray = [[NSArray alloc] init];
	targetSkin = 1;
	targetProperty = 1;
    isNormalState = YES;
}

-(void) initSlidingMenu {
    CGSize winSize = [CCDirector sharedDirector].winSize;
	[CCMenuItemFont setFontSize:16.0f];
    // menu - bottom
    CCSlidingMenuLayer *bLayer = [[CCSlidingMenuLayer alloc] initWithTarget:nil position:MENU_POSITION_BOTTOM size:CGSizeMake(winSize.width, 40) frameColor:ccc4(128, 128, 0, 255) frameBgColor:ccc4(0, 0, 0, 200) animation:ANIMATION_TYPE_BLINK];
    [self addChild:bLayer];
    CCMenuItemFont *loadTableMI = [CCMenuItemFont itemWithString:@"Load Table" target:self selector:@selector(loadTable:)];
	CCMenuItemFont *loadSkinMI = [CCMenuItemFont itemWithString:@"Load Skin" target:self selector:@selector(loadSkin:)];
	CCMenuItemFont *saveTableSkinMI = [CCMenuItemFont itemWithString:@"Save Table" target:self selector:@selector(saveTableSkin:)];
    CCMenuItemFont *createTableMI = [CCMenuItemFont itemWithString:@"Create Table" target:self selector:@selector(createTable:)];
    CCMenuItemFont *removeTableMI = [CCMenuItemFont itemWithString:@"Remove Table" target:self selector:@selector(removeTable:)];
    CCMenuItemFont *touchFlagMI = [CCMenuItemFont itemWithString:@"Touch Flag" target:self selector:@selector(touchFlag:)];
	bottomMenu = [CCMenu menuWithItems:createTableMI, loadTableMI, loadSkinMI, saveTableSkinMI, removeTableMI, touchFlagMI, nil];
	bottomMenu.position = ccp(winSize.width / 2, 20);
	[bottomMenu alignItemsHorizontallyWithPadding:15.0f];
	[bLayer addChild:bottomMenu z:1];

    // menu - top
    [CCMenuItemFont setFontSize:20.0f];
	CCSlidingMenuLayer *tLayer = [[CCSlidingMenuLayer alloc] initWithTarget:nil position:MENU_POSITION_TOP size:CGSizeMake(winSize.width, 40) frameColor:ccc4(128, 128, 0, 255) frameBgColor:ccc4(0, 0, 0, 200) animation:ANIMATION_TYPE_BLINK];
	[self addChild:tLayer];
	CCMenuItemToggle *skinTypeToggleMI = [CCMenuItemToggle itemWithTarget:self
                                                                 selector:@selector(changeSkinTypeSelector:)
                                                                    items:
                                          [CCMenuItemFont itemWithString:@"Table"],
                                          [CCMenuItemFont itemWithString:@"Title"],
                                          [CCMenuItemFont itemWithString:@"Header"],
                                          [CCMenuItemFont itemWithString:@"HeaderCell"],
                                          [CCMenuItemFont itemWithString:@"Row"],
                                          [CCMenuItemFont itemWithString:@"Row Even"],
                                          [CCMenuItemFont itemWithString:@"Cell"],
                                          [CCMenuItemFont itemWithString:@"Footer"],
                                          [CCMenuItemFont itemWithString:@"Grid"],
                                          nil];
	CCMenuItemToggle *stateToggleMI = [CCMenuItemToggle itemWithTarget:self
                                                           selector:@selector(changeStateSelector:)
                                                              items:
                                       [CCMenuItemFont itemWithString:@"Normal"],
                                       [CCMenuItemFont itemWithString:@"Selected"],
                                       nil];
    CCMenuItemToggle *propertyToggleMI = [CCMenuItemToggle itemWithTarget:self
                                                                 selector:@selector(changePropertySelector:)
                                                                    items:
                                          [CCMenuItemFont itemWithString:@"Element Width"],
                                          [CCMenuItemFont itemWithString:@"Element Height"],
                                          [CCMenuItemFont itemWithString:@"Font Name"],
                                          [CCMenuItemFont itemWithString:@"Font Size"],
                                          [CCMenuItemFont itemWithString:@"Font Color"],
                                          [CCMenuItemFont itemWithString:@"Element Opacity"],
                                          [CCMenuItemFont itemWithString:@"Element Color"],
                                          [CCMenuItemFont itemWithString:@"Texture Opacity"],
                                          [CCMenuItemFont itemWithString:@"Element Texture"],
                                          [CCMenuItemFont itemWithString:@"Frame Color"],
                                          [CCMenuItemFont itemWithString:@"Frame Width"],
                                          [CCMenuItemFont itemWithString:@"Frame Opacity"],
                                          [CCMenuItemFont itemWithString:@"Align Style"],
                                          nil];
	CCMenuItemToggle *confirmToggleMI = [CCMenuItemToggle itemWithTarget:self
                                                                selector:@selector(toolPopupSelector:)
                                                                   items:
                                         [CCMenuItemFont itemWithString:@"Change"],
                                         [CCMenuItemFont itemWithString:@"OK"],
                                         nil];
	skinTypeToggleMI.tag = 1;
	propertyToggleMI.tag = 2;
    stateToggleMI.tag = 3;
	confirmToggleMI.tag = 4;
    topMenu = [CCMenu menuWithItems:skinTypeToggleMI, propertyToggleMI, stateToggleMI, confirmToggleMI, nil];
	topMenu.position = ccp(winSize.width / 2, winSize.height - 20);
	[topMenu alignItemsHorizontallyWithPadding:30.0f];
	[tLayer addChild:topMenu z:1 tag:0];
    
	[self updateConfirmMennu];
}

-(void) initSystemFontArray {
	fontNameArray = [[CCArray alloc] init];
	NSArray *fontNames;
	for (NSString *family in [UIFont familyNames]) {
		fontNames = [UIFont fontNamesForFamilyName:family];
		for (NSString *fontName in fontNames) {
			[fontNameArray addObject:fontName];
		}
	}
}

-(void) initResourceImageArray {
	resourceImageArray = [[CCArray alloc] init];
	for (NSString *tString in [[NSBundle mainBundle] pathsForResourcesOfType:@".png" inDirectory:@""]) {
		if ([tString hasSuffix:@".png"]) {
			[resourceImageArray addObject:[[tString componentsSeparatedByString:@"/"] lastObject]];
		}
	}
	[resourceImageArray addObject:@"Remove Texture"];
}

-(void) dealloc {
	[super dealloc];
}

#pragma mark - CCSlidingMenuLayer bottom
-(CCArray *)listUserTables {
    CCArray *skinArray = [[CCArray alloc] init];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSArray *dirContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[documentPath stringByAppendingFormat:@"/"] error:nil];
    for (NSString *tString in dirContent) {
        if ([tString hasSuffix:@".table"]) {
            [skinArray addObject:tString];
            CCLOG(@"%@", tString);
        }
    }
    return skinArray;
}

-(void) touchFlag:(id)sender {
    [self showDropDownBoxWithRect:CGRectMake(0, 0, 200, 0) length:200 dataSource:[NSArray arrayWithObjects:
                                                                                  @"Edit Title(ON)",
                                                                                  @"Edit Title(OFF)",
                                                                                  @"Edit Header(ON)",
                                                                                  @"Edit Header(OFF)",
                                                                                  @"Adjust Column(ON)",
                                                                                  @"Adjust Column(OFF)",
                                                                                  @"Edit Cell(ON)",
                                                                                  @"Edit Cell(OFF)",
                                                                                  nil] tag:DP_TOUCH_FLAG];
}

-(void) loadTable:(id)sender {
    [self showDropDownBoxWithRect:CGRectMake(0, 0, 200, 0) length:200 dataSource:[[self listUserTables] getNSArray] tag:DP_TABLE];
}

-(void) loadSkin:(id)sender {
    [self showDropDownBoxWithRect:CGRectMake(0, 0, 200, 0) length:200 dataSource:[[self listUserTables] getNSArray] tag:DP_SKIN];
}

-(void) saveTableSkin:(id)sender {
	void(^saveSkinBlock)(NSString *text) = ^(NSString *text) {if ([text length] > 0) [labelTable exportTableSkinToFile:text];};
	YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"Table name"
																		  content:@""
																		 maxCount:20
																			block:saveSkinBlock];
	
	[popupTextView showInView:[[CCDirector sharedDirector] view]];
}

-(void) createTable:(id)sender {
	YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"Title Name Here"
																		  content:@""
																		 maxCount:20
																			block:nil];
    popupTextView.tag = 1;
	popupTextView.delegate = self;
	[popupTextView showInView:[[CCDirector sharedDirector] view]];
}

- (void)popupTextView:(YIPopupTextView*)textView didDismissWithText:(NSString*)text {
    if (textView.tag == 1) {
		if ([text length] <= 0) return;
        self.titleString = text;
        YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"Headers (divide by ',')"
                                                                              content:@""
                                                                             maxCount:200
                                                                                block:nil];
        popupTextView.tag = 2;
        popupTextView.delegate = self;
        [popupTextView showInView:[[CCDirector sharedDirector] view]];
    }
    else if (textView.tag == 2) {
		if ([text length] <= 0) return;
        self.headerTitleArray = [text componentsSeparatedByString:@","];
        YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"Column Width (divide by ',')"
                                                                              content:@""
                                                                             maxCount:200
                                                                                block:nil];
        popupTextView.tag = 3;
        popupTextView.delegate = self;
        [popupTextView showInView:[[CCDirector sharedDirector] view]];
    }
    else {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        if ([text length] <= 0) return;
        self.columnWidthArray = [text componentsSeparatedByString:@","];
        if ([self.columnWidthArray count] != [self.headerTitleArray count]) return;
        labelTable = [CCLabelTable tableWithDataSource:self
                                                 color:ccc4(200, 200, 0, 0)
                                                 width:400
                                                height:120
                                                 title:self.titleString
                                                header:self.headerTitleArray
                                           columnWidth:self.columnWidthArray];
        labelTable.position = ccp(winSize.width / 2, winSize.height / 2 - 20);
        [self addChild:labelTable];
    }
}

-(void) removeTable:(id)sender {
    if (labelTable) {
        [labelTable removeFromParentAndCleanup:YES];
        labelTable = nil;
    }
}

#pragma mark - popup
-(void) toolPopupSelector:(id)sender {
	switch(targetProperty) {
        case TC_FONT_NAME: {
			[self showDropDownBoxWithRect:CGRectMake(0, 0, 200, 0) length:200 dataSource:[fontNameArray getNSArray] tag:DP_FONT_NAME];
        }
            break;
        case TC_ELEMENT_WIDTH: {
			CGSize winSize = [CCDirector sharedDirector].winSize;
            [self showSliderWithRect:CGRectMake(winSize.width / 2 - 100, 50, 200, 10) min:5 max:winSize.width value:labelTable.skinCenter.tableAreaSkin.elementWidth];
		}
        	break;
        case TC_ELEMENT_HEIGHT: {
			CGSize winSize = [CCDirector sharedDirector].winSize;
			[self showSliderWithRect:CGRectMake(winSize.width / 2 - 100, 50, 200, 10) min:5 max:winSize.height value:labelTable.skinCenter.tableAreaSkin.elementHeight];
        }
            break;
        case TC_FONT_SIZE: {
			CGSize winSize = [CCDirector sharedDirector].winSize;
			[self showSliderWithRect:CGRectMake(winSize.width / 2 - 100, 50, 200, 10) min:5 max:96 value:16.0f];
		}
            break;
        case TC_FRAME_WIDTH: {
			CGSize winSize = [CCDirector sharedDirector].winSize;
			[self showSliderWithRect:CGRectMake(winSize.width / 2 - 100, 50, 200, 10) min:0 max:20.0f value:1.0f];
        }
            break;
        case TC_FRAME_COLOR:
        case TC_FONT_COLOR:
        case TC_ELEMENT_COLOR: {
            [self showColorPicker];
        }
            break;
        case TC_ALIGN_STYLE: {
			[self showDropDownBoxWithRect:CGRectMake(0, 0, 200, 0) length:200 dataSource:[NSArray arrayWithObjects:@"Left", @"Center", nil] tag:DP_ALIGN_STYLE];
        }
            break;
        case TC_TEXTURE_OPACITY:
        case TC_FRAME_OPACITY:
        case TC_ELEMENT_OPACITY: {
			CGSize winSize = [CCDirector sharedDirector].winSize;
			[self showSliderWithRect:CGRectMake(winSize.width / 2 - 100, 50, 200, 10) min:0 max:255.0f value:255.0f];
        }
            break;
        case TC_ELEMENT_TEXTURE: {
			[self showDropDownBoxWithRect:CGRectMake(0, 0, 200, 0) length:200 dataSource:[resourceImageArray getNSArray] tag:DP_TEXTURE];
        }
            break;
        default:
            break;
    }
    if ([sender selectedIndex] == 1) {
        [bottomMenu disableAllMenuItem];
        [topMenu disableMenuItem:1];
        [topMenu disableMenuItem:2];
    }
    else {
        [bottomMenu enableAllMenuItem];
        [topMenu enableAllMenuItem];
    }
}

-(void) showDropDownBoxWithRect:(CGRect)rect length:(float)length dataSource:(NSArray *)dataSource tag:(int)tag {
	if (dropDown) {
		[dropDown hideDropDown:CGRectZero];
		[dropDown release];
		dropDown = nil;
	}
	else {
		dropDown = [[NIDropDown alloc] init];
		[[CCDirector sharedDirector].view addSubview:dropDown];
		dropDown.delegate = self;
		dropDown.tag = tag;
		[dropDown showDropDown:rect :&length :dataSource];
	}
}

-(void) showSliderWithRect:(CGRect)rect min:(float)min max:(float)max value:(float)value {
	if (mSlider) {
		[mSlider removeFromSuperview];
		[mSlider release];
		mSlider = nil;
		[self removeChildByTag:789 cleanup:YES];
	}
	else {
		mSlider = [[UISlider alloc] initWithFrame:rect];
		mSlider.minimumValue = min;
		mSlider.maximumValue = max;
		mSlider.value = value;
		[[CCDirector sharedDirector].view addSubview:mSlider];
		[mSlider addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
		CCLabelTTF *valueLabel = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:16];
		[self addChild:valueLabel z:1 tag:789];
	}
}

-(void) showColorPicker {
	if (!sdColourWheel) {
		sdColourWheel = [[SDColourWheel alloc] initColourWheel];
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		sdColourWheel.position = ccp(winSize.width - sdColourWheel.contentSize.width / 2,
									 winSize.height - sdColourWheel.contentSize.height / 2);
		sdColourWheel.delegate = self;
        [self addChild:sdColourWheel];
	}
	else {
		[labelTable enableGesture:YES];
		[self removeChild:sdColourWheel cleanup:YES];
        [sdColourWheel release];
        sdColourWheel = nil;
	}
}

#pragma mark - sdColourWheel delegate
-(void) colourChanged:(RGBType)colour {
	ccColor3B color = ccc3(colour.r * 255, colour.g * 255, colour.b * 255);
	if (targetProperty == TC_FONT_COLOR) {
	    [labelTable updateFontColor:color type:targetSkin];
	}
	if (targetProperty == TC_FRAME_COLOR) {
	    [labelTable updateFrameColor:color type:targetSkin];
	}
	if (targetProperty == TC_ELEMENT_COLOR) {
	    [labelTable updateElementColor:color type:targetSkin state:isNormalState];
	}
}

#pragma mark - slider
-(void) updateValue:(id)slider {
	float value = mSlider.value;
	UIImageView *imageView = [mSlider.subviews objectAtIndex:2];
	CGRect theRect = [[CCDirector sharedDirector].view convertRect:imageView.frame fromView:imageView.superview];
	CCLabelTTF *valueLabel = (CCLabelTTF *)[self getChildByTag:789];
	[valueLabel setString:[NSString stringWithFormat:@"%0.1f", value]];
	valueLabel.position = ccp(theRect.origin.x, [CCDirector sharedDirector].winSize.height - 40);
	if (targetProperty == TC_FONT_SIZE) {
	    [labelTable updateFontSize:value type:targetSkin];
	}
	if (targetProperty == TC_FRAME_WIDTH) {
	    [labelTable updateFrameWidth:value type:targetSkin];
	}
	if (targetProperty == TC_FRAME_OPACITY) {
	    [labelTable updateFrameOpacity:value type:targetSkin];
	}
	if (targetProperty == TC_ELEMENT_OPACITY) {
	    [labelTable updateElementOpacity:value type:targetSkin state:isNormalState];
	}
	if (targetProperty == TC_TEXTURE_OPACITY) {
	    [labelTable updateTextureOpacity:value type:targetSkin state:isNormalState];
	}
    if (targetProperty == TC_ELEMENT_WIDTH) {
	    [labelTable updateElementWidth:value type:targetSkin];
	}
    if (targetProperty == TC_ELEMENT_HEIGHT) {
	    [labelTable updateElementHeight:value type:targetSkin];
	}
}

#pragma mark - CCSlidingMenuLayer top
-(void) updateConfirmMennu {
    [topMenu enableMenuItem:4];
    if (targetSkin == SKIN_TABLE) {
        [topMenu disableMenuItem:3];
        if (targetProperty == TC_FONT_NAME ||
            targetProperty == TC_FONT_SIZE ||
            targetProperty == TC_FONT_COLOR ||
            targetProperty == TC_ALIGN_STYLE) {
            [topMenu disableMenuItem:4];
        }
    }
    if (targetSkin == SKIN_TITLE) {
        [topMenu disableMenuItem:3];
        if (targetProperty == TC_ELEMENT_WIDTH ||
            targetProperty == TC_ELEMENT_HEIGHT) {
            [topMenu disableMenuItem:4];
        }
    }
    if (targetSkin == SKIN_HEADER) {
        [topMenu disableMenuItem:3];
        if (targetProperty == TC_ELEMENT_WIDTH ||
            targetProperty == TC_ELEMENT_HEIGHT) {
            [topMenu disableMenuItem:4];
        }
    }
    if (targetSkin == SKIN_HEADER_CELL) {
        [topMenu disableMenuItem:3];
        if (targetProperty == TC_ELEMENT_WIDTH ||
            targetProperty == TC_ELEMENT_HEIGHT ||
            targetProperty == TC_FONT_NAME ||
            targetProperty == TC_FONT_SIZE ||
            targetProperty == TC_FONT_COLOR ||
            targetProperty == TC_FRAME_COLOR ||
            targetProperty == TC_FRAME_WIDTH ||
            targetProperty == TC_FRAME_OPACITY ||
            targetProperty == TC_ALIGN_STYLE) {
            [topMenu disableMenuItem:4];
        }
    }
    if (targetSkin == SKIN_ROW) {
        [topMenu enableMenuItem:3];
        if (targetProperty == TC_ELEMENT_WIDTH ||
            targetProperty == TC_ELEMENT_HEIGHT ||
            targetProperty == TC_FRAME_COLOR ||
            targetProperty == TC_FRAME_WIDTH ||
            targetProperty == TC_FRAME_OPACITY) {
            [topMenu disableMenuItem:4];
        }
    }
    if (targetSkin == SKIN_ROW_EVEN) {
        [topMenu disableMenuItem:3];
        if (targetProperty == TC_ELEMENT_WIDTH ||
            targetProperty == TC_ELEMENT_HEIGHT ||
            targetProperty == TC_FONT_NAME ||
            targetProperty == TC_FONT_SIZE ||
            targetProperty == TC_FONT_COLOR ||
            targetProperty == TC_FRAME_COLOR ||
            targetProperty == TC_FRAME_WIDTH ||
            targetProperty == TC_FRAME_OPACITY ||
            targetProperty == TC_ALIGN_STYLE) {
            [topMenu disableMenuItem:4];
        }
    }
    if (targetSkin == SKIN_ROW_EVEN) {
        [topMenu disableMenuItem:3];
        if (targetProperty == TC_ELEMENT_WIDTH ||
            targetProperty == TC_ELEMENT_HEIGHT ||
            targetProperty == TC_FONT_NAME ||
            targetProperty == TC_FONT_SIZE ||
            targetProperty == TC_FONT_COLOR ||
            targetProperty == TC_FRAME_COLOR ||
            targetProperty == TC_FRAME_WIDTH ||
            targetProperty == TC_FRAME_OPACITY ||
            targetProperty == TC_ALIGN_STYLE) {
            [topMenu disableMenuItem:4];
        }
    }
    if (targetSkin == SKIN_ROW_CELL) {
        [topMenu disableMenuItem:3];
        if (targetProperty == TC_ELEMENT_WIDTH ||
            targetProperty == TC_ELEMENT_HEIGHT ||
            targetProperty == TC_FONT_NAME ||
            targetProperty == TC_FONT_SIZE ||
            targetProperty == TC_FONT_COLOR ||
            targetProperty == TC_FRAME_COLOR ||
            targetProperty == TC_FRAME_WIDTH ||
            targetProperty == TC_FRAME_OPACITY ||
            targetProperty == TC_ALIGN_STYLE) {
            [topMenu disableMenuItem:4];
        }
    }
    if (targetSkin == SKIN_GRID) {
        [topMenu disableMenuItem:3];
        if (targetProperty == TC_ELEMENT_WIDTH ||
            targetProperty == TC_ELEMENT_HEIGHT ||
            targetProperty == TC_FONT_NAME ||
            targetProperty == TC_FONT_SIZE ||
            targetProperty == TC_FONT_COLOR ||
            targetProperty == TC_ELEMENT_TEXTURE ||
            targetProperty == TC_TEXTURE_OPACITY ||
            targetProperty == TC_ALIGN_STYLE) {
            [topMenu disableMenuItem:4];
        }
    }
}

-(void) changeSkinTypeSelector:(id)sender {
    targetSkin = [sender selectedIndex] + 1;
    [self updateConfirmMennu];
}

-(void) changePropertySelector:(id)sender {
    targetProperty = [sender selectedIndex] + 1;
    [self updateConfirmMennu];
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender selectedString:(NSString *)selectedString {
    if (sender.tag == DP_TABLE) {
        if (labelTable) {
            [labelTable removeFromParentAndCleanup:YES];
            [labelTable release];
        }
        CGSize winSize = [CCDirector sharedDirector].winSize;
        labelTable = [CCLabelTable tableWithDataSource:self tableSkinFile:selectedString];
        labelTable.position = ccp(winSize.width / 2, winSize.height / 2 - 20);
        [self addChild:labelTable];
        [labelTable reloadTableContent];
        [dropDown hideDropDown:CGRectZero];
		[dropDown release];
		dropDown = nil;
    }
    if (sender.tag == DP_SKIN) {
        [labelTable updateTableSkin:selectedString];
        [dropDown hideDropDown:CGRectZero];
		[dropDown release];
		dropDown = nil;
    }
	if (sender.tag == DP_TEXTURE) {
		if ([selectedString isEqualToString:@"Remove Texture"]) selectedString = @"";
	    [labelTable updateElementTexture:selectedString type:targetSkin state:isNormalState];
	}
	if (sender.tag == DP_FONT_NAME) {
	    [labelTable updateFontName:selectedString type:targetSkin];
	}
	if (sender.tag == DP_ALIGN_STYLE) {
		ALIGN_STYLE alignStyle = [selectedString isEqualToString:@"Left"] ? kStyleAlignLeft : kStyleAlignCenter;
        [labelTable updateAlign:alignStyle type:targetSkin];
	}
    if (sender.tag == DP_TOUCH_FLAG) {
        // to be done
    }
}

#pragma mark - CCLabelTable delegate
-(int) tableRowCount {
	return [dataArray count];
}

-(NSArray *) rowStringArrayAtIndex:(int)rowIndex {
    NSMutableArray *rowStringArray = [[NSMutableArray alloc] initWithArray:[dataArray objectAtIndex:rowIndex]];
    [rowStringArray insertObject:[NSString stringWithFormat:@"%d", rowIndex + 1] atIndex:0];
    return rowStringArray;
}

-(void) tablePageUpdate:(int)currentPage totalPage:(int)totalPage {}
-(void) rowSelected:(int)rowIndex rowsSelected:(CCArray *)selectedRowArray {}

-(BOOL) insertRowBefore:(int)rowIndex {
    NSMutableArray *rowStringArray = [NSMutableArray arrayWithObjects:
                                      [NSString stringWithFormat:@"+before %d", rowIndex],
                                      @"Male",
                                      [NSString stringWithFormat:@"%d", rowIndex],
                                      @"+before",
                                      nil];
    [dataArray insertObject:rowStringArray atIndex:rowIndex - 1];
    return YES;
}

-(BOOL) insertRowAfter:(int)rowIndex {
    NSMutableArray *rowStringArray = [NSMutableArray arrayWithObjects:
                                      [NSString stringWithFormat:@"+after %d", rowIndex],
                                      @"Male",
                                      [NSString stringWithFormat:@"%d", rowIndex],
                                      @"+after",
                                      nil];
    [dataArray insertObject:rowStringArray atIndex:rowIndex];
    return YES;
}

-(void) updateTitleString:(NSString *)oldTitleString {
	void(^updateTitleStringBlock)(NSString *text) =
	^(NSString *text) {
		if ([text length] > 0) [labelTable updateTitleString:text];
	};
    YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"Header Name"
                                                                          content:oldTitleString
                                                                         maxCount:TITLTE_LENGTH_LIMIT
                                                                            block:updateTitleStringBlock];
    
    [popupTextView showInView:[[CCDirector sharedDirector] view]];
}

-(void) updateHeaderCell:(int)headerCellIndex oldHeaderString:(NSString *)oldHeaderName {
    void(^updateHeaderNameBlock)(NSString *text) =
    ^(NSString *text) {
        if ([text length] > 0) {
            [labelTable updateHeaderNameAt:headerCellIndex name:text];
        }
    };
    YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"Header Name"
                                                                          content:oldHeaderName
                                                                         maxCount:HEADER_NAME_LENGTH_LIMIT
                                                                            block:updateHeaderNameBlock];
    
    [popupTextView showInView:[[CCDirector sharedDirector] view]];
}

-(void) updateCell:(int)cellIndex atRow:(int)rowIndex oldCellString:(NSString *)oldCellString {
    void(^updateCellBlock)(NSString *text) =
    ^(NSString *text) {
        if ([text length] > 0) {
            NSMutableArray *rowStringArray = [dataArray objectAtIndex:rowIndex - 1];
            [rowStringArray replaceObjectAtIndex:cellIndex - 2 withObject:text];
            [dataArray replaceObjectAtIndex:rowIndex - 1 withObject:rowStringArray];
            [labelTable reloadTableContent];
        }
    };
    YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"Cell Info"
                                                                          content:oldCellString
                                                                         maxCount:CELL_LENGTH_LIMIT
                                                                            block:updateCellBlock];
    [popupTextView showInView:[[CCDirector sharedDirector] view]];
}

-(void) removeRowAt:(int)rowIndex {
	RIButtonItem *confirmItem = [RIButtonItem itemWithLabel:@"YES"];
	confirmItem.action = ^ {
		[dataArray removeObjectAtIndex:rowIndex - 1];
        [labelTable reloadTableContent];
	};
	RIButtonItem *cancelItem = [RIButtonItem itemWithLabel:@"NO"];
	cancelItem.action = nil;
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                        message:[NSString stringWithFormat:@"Delete Row%d?", rowIndex]
                                               cancelButtonItem:cancelItem
                                               otherButtonItems:confirmItem, nil];
	[alertView show];
	[alertView release];
}
@end
