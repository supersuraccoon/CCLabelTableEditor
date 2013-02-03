CCLabelTableEditor
==================
Intro:
A label control in written in cocos2d with fully gesutre support.

What's in CCLabeLTable:
CCLabeLTable
- CCLabelTable + CCLabelTableMacro
 - Component
   - CCTableTitle
   - CCTableHeader
   - CCHeaderCell
   - CCTableArea
   - CCTableRow
   - CCRowCell
   - CCTableFooter
   - CCTableGrid
   - CCTableElement
   - CCTableElementCenter
 - skin + config
   - CCTitleSkin
   - CCHeaderSkin
   - CCHeaderCellSkin
   - CCTableAreaSkin
   - CCRowSkin
   - CCRowEvenSkin
   - CCFooterSkin
   - CCGridSkin
   - CCElementSkin
   - CCSkinCenter
   
What's (else) in CCLabeLTableEditor- ColorPicker- CCSlidingMenuLayer (origin)- CCGeometrySprite (origin)- NIDropDown (little modification)- YIPopupTextView (little modification)- UIAlertView-Blocks- CCMenu+Items (origin)- CCNode+AnchorLayout- CCNode+SFGestureRecognizers (little modification)- NSString+FontSize (origin)

Gesture support:
- Swipe Left (one finger) - Next Page
- Swipe Right (one finger) - Pre Page
- Swipe Left (two finger) - Last Page
- Swipe Right (two finger) - First Page
- Swipe Up (on a row) - Insert row before selected row
- Swipe Down (on a row) - Insert row after selected row
- Single Tap (on a row) - Select (highlight) a row
- Double Tap (on a row) - Delete selected row
- Long Press (on title) - Edit title content
- Long Press (on a header cell) - Edit header cell content
- Pan (on header cell) - Adjust column width


