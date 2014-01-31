

typedef enum {
    KEYTYPE_0=0,
    KEYTYPE_1,
    KEYTYPE_2,
    KEYTYPE_3,
    KEYTYPE_4,
    KEYTYPE_5,
    KEYTYPE_6,
    KEYTYPE_7,
    KEYTYPE_8,
    KEYTYPE_9,

    KEYTYPE_DOT,
    
    KEYTYPE_ADD,
    KEYTYPE_SUB,
    KEYTYPE_MUL,
    KEYTYPE_DIV,
    KEYTYPE_EQ,

    KEYTYPE_AC,
    KEYTYPE_C,
    
    KEYTYPE_MAX,
}KEYTYPE;

typedef struct {
    CGPoint pos;
    KEYTYPE keyType;
    NSString *string;
}KeyInfo;

