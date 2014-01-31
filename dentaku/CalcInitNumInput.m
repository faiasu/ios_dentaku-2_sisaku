//
//  CalcInitNumInput.m
//  dentaku
//
//  Created by Akihiro FUKUSUMI on 12/08/05.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import "CalcInitNumInput.h"
#import "CalcOperatorInput.h"
#import "CalculatoEvent.h"

static CalcInitNumInput *sharedInstance;

@implementation CalcInitNumInput

-(void)pressedNum:(CalculatoEvent *)calc{

    [[data getKeybord] inputKey:[calc keyType]];
    [calc setDisplayString:[NSString stringWithFormat:@"%@", [data getKeybord].numberString]];
    
}

-(void)pressedPlusMinus:(CalculatoEvent *)calc{
    // 初期数値入力からの遷移時はanswerに表示してる数字入れたりが必要
    [data setAnswer:[[data getKeybord].numberString doubleValue]];
    [calc setFormulaString:[[NSString alloc]initWithFormat:@"%g", [data getAnswer]]];            
    [data setOperationKey:[calc keyType]];
    [[data getKeybord]clear];
    
    [calc changeState:[CalcOperatorInput sharedInstance]];
}

-(void)pressedKakeruWaru:(CalculatoEvent *)calc{
    [self pressedPlusMinus:calc];
}

-(void)pressedEqual:(CalculatoEvent *)calc{
    
}

-(void)pressedHistory:(CalculatoEvent *)calc{
    
}

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CalcInitNumInput alloc]init];
    });
    return sharedInstance;  
}

@end
