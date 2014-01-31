//
//  Calc.h
//  dentaku
//
//  Created by Kazunori OYA on 12/07/27.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Key.h"
#import "Keyboard10.h"
#import "CalcHistory.h"


#define CALC_HISTORY_MAX (50)

typedef enum {
    CS_INIT = 0,
    CS_NUMBER,
    CS_CALC,
    
    CS_MAX,
}CSTATUS;


@interface Calc : NSObject
{
    int status_;
    KEYTYPE lastKey_;
    Keyboard10 *keyboard_; // 10進用
    NSString *displayString_; // 表示用
    NSString *displayString2_;
    NSString *formulaString_; // 計算式保持用
    CalcHistory *history_;
    KEYTYPE operationKey_;
    double answer_;
    double number_;
    bool isNumberStringClear_;
}

@property(nonatomic,retain)NSString *displayString;
@property(nonatomic,retain)NSString *displayString2;
@property(nonatomic,retain)NSString *formulaString;

- (void)inputKey:(KEYTYPE)key;
- (CalcHistory *)getCalcHistory;
- (void)selectedCalcHistoryIndex:(NSInteger)selectedIndex;


@end
