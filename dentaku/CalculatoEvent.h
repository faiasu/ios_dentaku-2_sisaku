//
//  CalculatoEvent.h
//  dentaku
//
//  Created by Akihiro FUKUSUMI on 12/08/02.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Key.h"
#import "Keyboard10.h"
#import "CalcHistory.h"
#import "CalcState.h"
#import "CalcMemory.h"

@interface CalculatoEvent : NSObject
{
    CalcState *state_;
    KEYTYPE keyType_;
    NSString *displayString_; // 表示用
    NSString *displayString2_;
    NSString *formulaString_; // 計算式保持用

}
@property(nonatomic)KEYTYPE keyType;
@property(nonatomic,retain)NSString *displayString;
@property(nonatomic,retain)NSString *displayString2;
@property(nonatomic,retain)NSString *formulaString;

- (void)inputKey:(KEYTYPE)key;
-(void)changeState:(CalcState*)state;
- (void)selectedCalcHistoryIndex:(NSInteger)selectedIndex;
@end
