#ifndef CCLabelTableEditor_CCTableMacro_h
#define CCLabelTableEditor_CCTableMacro_h

typedef enum {
    kStyleAlignLeft = 1,
    kStyleAlignCenter,
}ALIGN_STYLE;

#define    kTagHeader                     1000
#define    kTagRow                        2000
#define    kTagTitle                      3000
#define    kTagTitleLabel                 4000
#define    kTagFooterLabel                5000
#define    kTagGridLine                   6000
#define    kTagFooter                     7000
#define    kTagTableArea                  8000
#define    kTagHeaderCell                 9000
#define    kTagFrame                      10000
#define    kTagRowCell                    11000

#define    TITLTE_LENGTH_LIMIT            100
#define    HEADER_NAME_LENGTH_LIMIT       30
#define    HEADER_NAME_LENGTH_LIMIT       30
#define    CELL_LENGTH_LIMIT              50

#endif
