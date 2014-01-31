//
//  CalcResultOutput.m
//  dentaku
//
//  Created by Akihiro FUKUSUMI on 12/08/06.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import "CalcResultOutput.h"
#import "CalcNumInput.h"
#import "CalcOperatorInput.h"
#import "CalculatoEvent.h"


static CalcResultOutput *sharedInstance;

@implementation CalcResultOutput

-(void)pressedNum:(CalculatoEvent *)calc{

    NSLog(@"buttonDidPush calcState"); // どのボタンイベントかが判断できればなんとかなりそう。
    [self pressedAllClear:calc];
    [[data getKeybord] inputKey:[calc keyType]];
    [calc setDisplayString:[NSString stringWithFormat:@"%@", [data getKeybord].numberString]];

}

-(void)pressedPlusMinus:(CalculatoEvent *)calc{
    [data setOperationKey:[calc keyType]];
    [calc changeState:[CalcOperatorInput sharedInstance]];
    
}

-(void)pressedKakeruWaru:(CalculatoEvent *)calc{
    [data setOperationKey:[calc keyType]];
    [calc changeState:[CalcOperatorInput sharedInstance]];
    
}

-(void)pressedEqual:(CalculatoEvent *)calc{
    
}

-(void)pressedHistory:(CalculatoEvent *)calc{
    
}
//-(void)pressedAllClear:(CalculatoEvent *)calc{
//}

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CalcResultOutput alloc]init];
    });
    return sharedInstance;  
}

@end
