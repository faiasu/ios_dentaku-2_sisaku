//
//  CalcState.h
//  dentaku
//
//  Created by Akihiro FUKUSUMI on 12/08/02.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Key.h"
#import "Keyboard10.h"
#import "CalcHistory.h"
#import "CalcMemory.h"

@class CalculatoEvent;

//#import "CalculatoEvent.h"
@interface CalcState : NSObject
{
    CalcMemory* data;
//    CalcMemory *data_;
//    Keyboard10 *keyboard_; // 10進用
//    CalcHistory *history_;    
}

+ (id)sharedInstance;

-(void)pressedNum:(CalculatoEvent*)calc;
-(void)pressedPlusMinus:(CalculatoEvent*)calc;
-(void)pressedKakeruWaru:(CalculatoEvent*)calc;
-(void)pressedEqual:(CalculatoEvent*)calc;
-(void)pressedClear:(CalculatoEvent*)calc;
-(void)pressedAllClear:(CalculatoEvent*)calc;
-(void)pressedHistory:(CalculatoEvent*)calc;
-(void)Calculate:(CalculatoEvent*)calc;

@end
