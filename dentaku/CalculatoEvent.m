//
//  CalculatoEvent.m
//  dentaku
//
//  Created by Akihiro FUKUSUMI on 12/08/02.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import "CalculatoEvent.h"
#import "Key.h"
#import "CalcInit.h"
#import "CalcNumInput.h"

@implementation CalculatoEvent
@synthesize displayString = displayString_;
@synthesize displayString2 = displayString2_;
@synthesize formulaString = formulaString_;

@synthesize keyType = keyType_;
- (id)init
{
    self = [super init];
    if( self ){
        // 初期状態の設定
//        [state_ pressedAllClear:self];
        [self changeState:[CalcInit sharedInstance]];
         }
    return self;
}
         
/* keyboard16(16進数入力)等増えても対応できるようにしておく */
// ボタン押下時にここでどのイベントか判断
- (void)inputKey:(KEYTYPE)key
{
    [self setKeyType:key];
            
    if( KEYTYPE_0 <= key & key <= KEYTYPE_DOT){
        [state_ pressedNum:self];
    }
    // +-
    else if(KEYTYPE_ADD == key ||KEYTYPE_SUB == key){
        [state_ pressedPlusMinus:self];
    }
    // ×÷
    else if (KEYTYPE_DIV == key || KEYTYPE_MUL == key){
        [state_ pressedKakeruWaru:self];
    }
    // =
    else if(KEYTYPE_EQ == key){
        [state_ pressedEqual:self];
    }
    // C
    else if(KEYTYPE_C == key){
        [state_ pressedClear:self];
    }
    // AC
    else if (KEYTYPE_AC ==key){
        [state_ pressedAllClear:self];
    }
    return;
}
         
-(void)changeState:(CalcState *)state{
             
    // 状態を遷移させる
    NSLog(@"aaaaaa______%@",NSStringFromClass([state_ class]));
    [state_ release];
    state_ = [state retain];
    NSLog(@"bbbbbb______%@",NSStringFromClass([state_ class]));
}

//これは移動して試しただけ。
- (void)selectedCalcHistoryIndex:(NSInteger)selectedIndex
{
    CalcMemory *data = [CalcMemory sharedInstance];
    CalcData *cdp = [[data getHistory] getCalcData:selectedIndex];
    if (cdp){
        [[data getKeybord] setNumberString:cdp->answer];
        [data setNumber:[cdp->answer doubleValue]];
        [self setDisplayString:[NSString stringWithFormat:@"%@", [data getKeybord].numberString]];
//        [self changeState:[CalcNumInput sharedInstance]];
    }
}
@end
