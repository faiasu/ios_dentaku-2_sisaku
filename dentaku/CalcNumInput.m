//
//  CalcNumInput.m
//  dentaku
//
//  Created by Akihiro FUKUSUMI on 12/08/06.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import "CalcNumInput.h"
#import "CalcOperatorInput.h"
#import "CalculatoEvent.h"
#import "CalcResultOutput.h"

static CalcNumInput *sharedInstance;

@implementation CalcNumInput

-(void)pressedNum:(CalculatoEvent *)calc{

    NSLog(@"buttonDidPush calcState"); // どのボタンイベントかが判断できればなんとかなりそう。
    [[data getKeybord] inputKey:[calc keyType]];
    [calc setDisplayString:[NSString stringWithFormat:@"%@", [data getKeybord].numberString]];

}

-(void)pressedPlusMinus:(CalculatoEvent *)calc{
    [self Calculate:calc];
    [data setOperationKey:[calc keyType]];
    [[data getKeybord]clear];

    [calc changeState:[CalcOperatorInput sharedInstance]];
    
}

-(void)pressedKakeruWaru:(CalculatoEvent *)calc{
    [self pressedPlusMinus:calc];

}

-(void)pressedEqual:(CalculatoEvent *)calc{
    [self Calculate:calc];
    [[data getKeybord]clear];
    [calc changeState:[CalcResultOutput sharedInstance]];
}

-(void)pressedClear:(CalculatoEvent *)calc{
    [[data getKeybord]setNumberString:@"0"];
    [calc setDisplayString:[NSString stringWithFormat:@"%@", [data getKeybord].numberString]];
    [[data getKeybord]clear];
    [calc changeState:[CalcOperatorInput sharedInstance]];
}

-(void)pressedHistory:(CalculatoEvent *)calc{
    
}

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CalcNumInput alloc]init];
    });
    return sharedInstance;  
}

@end
