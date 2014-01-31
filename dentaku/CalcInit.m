//
//  CalcInit.m
//  dentaku
//
//  Created by Akihiro FUKUSUMI on 12/08/02.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import "CalcInit.h"
#import "CalculatoEvent.h"
#import "CalcInitNumInput.h"
#import "CalcInitOperatorInput.h"

static CalcInit *sharedInstance;

@implementation CalcInit

-(void)pressedNum:(CalculatoEvent *)calc{

    [[data getKeybord] inputKey:[calc keyType]];
    [calc setDisplayString:[NSString stringWithFormat:@"%@", [data getKeybord].numberString]];
    
    // 状態遷移（初期数値）
    [calc changeState:[CalcInitNumInput sharedInstance]];
}

-(void)pressedPlusMinus:(CalculatoEvent *)calc{
    [data setOperationKey:[calc keyType]];

    // 状態遷移（初期符号）
    [calc changeState:[CalcInitOperatorInput sharedInstance]];
}

-(void)pressedKakeruWaru:(CalculatoEvent *)calc{
    
}

-(void)pressedEqual:(CalculatoEvent *)calc{
    
}

-(void)pressedHistory:(CalculatoEvent *)calc{
    
}

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CalcInit alloc]init];
    });
    return sharedInstance;  
}

@end
