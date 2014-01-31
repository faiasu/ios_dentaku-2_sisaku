//
//  Calc.m
//  dentaku
//
//  Created by Kazunori OYA on 12/07/27.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import "Calc.h"
#import "Keyboard10.h"

@implementation Calc

@synthesize displayString = displayString_;
@synthesize displayString2 = displayString2_;
@synthesize formulaString = formulaString_;

- (id)init
{
    self = [super init];
    if( self ){
        keyboard_ = [[Keyboard10 alloc]init];
        history_ = [[CalcHistory alloc]initWithMax:CALC_HISTORY_MAX];
        [self clearAll];
    }
    return self;
}

- (CalcHistory*)getCalcHistory
{
    return history_;
}

- (void)clearAll
{
    status_ = CS_INIT;
    lastKey_ = KEYTYPE_MAX;
    number_ = 0;
    answer_ = 0;
    
    [self setFormulaString:[[NSString alloc]initWithFormat:@"%g", number_]];
    
    operationKey_ = KEYTYPE_MAX;
    [keyboard_ clear];
    [self setDisplayString:@"0"];
    
    [self setDisplayString2:[NSString stringWithFormat:@"k(%d),n(%g),a(%g)", 
                             answer_, operationKey_, number_, answer_]];    
}

- (void)selectedCalcHistoryIndex:(NSInteger)selectedIndex
{
    CalcData *cdp = [history_ getCalcData:selectedIndex];
    if (cdp){
        [keyboard_ setNumberString:cdp->answer];
        number_ = [cdp->answer doubleValue];
        status_ = CS_NUMBER;
        [self setDisplayString:[NSString stringWithFormat:@"%@", keyboard_.numberString]];
    }
}


/* keyboard16(16進数入力)等増えても対応できるようにしておく */
- (void)inputKey:(KEYTYPE)key
{
    
    // とりあえず何でも全クリアーしておく
    if ( (KEYTYPE_C == key) || (KEYTYPE_AC == key) ){
        [self clearAll];
        return;
    }
    
    // 数値入力の制御のみ頑張る。
    if ( (KEYTYPE_0 <= key) && (KEYTYPE_DOT >= key) ){
        [keyboard_ inputKey:key];
        [self setDisplayString:[NSString stringWithFormat:@"%@", keyboard_.numberString]];
        status_ = CS_NUMBER;
        return;
    }
    
    // 計算開始
    if ( (key >= KEYTYPE_ADD) && (key <= KEYTYPE_EQ) ){
        [self calcKey:key];
        status_ = CS_CALC;
    }
    return;
}

- (bool)isOperationKey:(KEYTYPE)key
{
    if ( (key >= KEYTYPE_ADD) && (key <= KEYTYPE_DIV)  ){ 
        return true;
    }
    return false;
}

- (void)calcKey:(KEYTYPE)key
{
    
    // 演算キーのみ重複押下した場合。
    if (status_ == CS_CALC) {
        if ( [self isOperationKey:operationKey_] && [self isOperationKey:key] ){
            operationKey_ = key;
            return;
        }
    }
    
    if (status_ == CS_NUMBER ){
        if ( [self isOperationKey:operationKey_] ) {
            number_ = [keyboard_.numberString doubleValue];

        }
    }
    
    switch (operationKey_) {
        case KEYTYPE_ADD:
            answer_ += number_;
        
            [self setFormulaString:[[NSString alloc]initWithFormat:@"%@+%g", formulaString_, number_]];
            break;
        case KEYTYPE_SUB:
            answer_ -= number_;
            
            [self setFormulaString:[[NSString alloc]initWithFormat:@"%@-%g", formulaString_, number_]];
            break;
        case KEYTYPE_MUL:
            answer_ *= number_;

            [self setFormulaString:[[NSString alloc]initWithFormat:@"%@x%g", formulaString_, number_]];
            break;
        case KEYTYPE_DIV:
            if( number_ != 0 ){
                // 当然zero以外でないと駄目
                answer_ /= number_;
                
                [self setFormulaString:[[NSString alloc]initWithFormat:@"%@/%g", formulaString_, number_]];
            }
            break;
        default:
            NSLog(@"何もしない");
            break;
    }

    // 保持
    if (KEYTYPE_EQ != key) {
        // key と 結果を更新
        // 入力値保持
        number_ = [keyboard_.numberString doubleValue];
        //[keyboard requestClear];
        [keyboard_ clear];
        
        if( KEYTYPE_MAX ==  operationKey_ ){
            // 初回ならanswer_に保持
            answer_ = number_;
            [self setFormulaString:[[NSString alloc]initWithFormat:@"%g", number_]];
        }
        operationKey_ = key;
    }
    else {
        // KEYTYPE_EQ
        if ([self isOperationKey:operationKey_]) {
            [keyboard_ clear];
            // 計算式を履歴に登録
            [self setFormulaString:[[NSString alloc]initWithFormat:@"%@=%g", formulaString_, answer_]];
            
            [history_ setCalcData:[[NSString alloc]initWithFormat:@"%@", formulaString_]
                           answer:[[NSString alloc]initWithFormat:@"%g", answer_]
             ];
            
            [self setFormulaString:[[NSString alloc]initWithFormat:@"%g", answer_]];
        }
        else{
            answer_ = [keyboard_.numberString doubleValue];
        }
    }
    

    // 画面更新の準備
    [self setDisplayString:[NSString stringWithFormat:@"%g", answer_]];

    
    [self setDisplayString2:[NSString stringWithFormat:@"k(%d),n(%g),a(%g)",
                             operationKey_, number_, answer_]];

}


@end
