//
//  CalcOperatorInput.m
//  dentaku
//
//  Created by Akihiro FUKUSUMI on 12/08/06.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import "CalcOperatorInput.h"
#import "CalculatoEvent.h"
#import "CalcNumInput.h"

static CalcOperatorInput *sharedInstance;

@implementation CalcOperatorInput

-(void)pressedNum:(CalculatoEvent *)calc{

    [[data getKeybord] inputKey:[calc keyType]];
    [calc setDisplayString:[NSString stringWithFormat:@"%@", [data getKeybord].numberString]];
    [calc changeState:[CalcNumInput sharedInstance]];
    
}

-(void)pressedPlusMinus:(CalculatoEvent *)calc{
    [data setOperationKey:[calc keyType]];
    
}

-(void)pressedKakeruWaru:(CalculatoEvent *)calc{
    [data setOperationKey:[calc keyType]];
}

-(void)pressedEqual:(CalculatoEvent *)calc{
    
}

-(void)pressedHistory:(CalculatoEvent *)calc{
    
}

-(void)pressedClear:(CalculatoEvent *)calc{
    
}


+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CalcOperatorInput alloc]init];
    });
    return sharedInstance;  
}

@end
