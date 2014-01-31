//
//  CalcInitOperatorInput.m
//  dentaku
//
//  Created by Akihiro FUKUSUMI on 12/08/06.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import "CalcInitOperatorInput.h"
#import "CalcInitNumInput.h"
#import "CalculatoEvent.h"

static CalcInitOperatorInput *sharedInstance;

@implementation CalcInitOperatorInput

-(void)pressedNum:(CalculatoEvent *)calc{

    [[data getKeybord] inputKey:[calc keyType]];
    [calc setDisplayString:[NSString stringWithFormat:@"%@", [data getKeybord].numberString]];
    [calc changeState:[CalcInitNumInput sharedInstance]];
}

-(void)pressedPlusMinus:(CalculatoEvent *)calc{
    [data setOperationKey:[calc keyType]];
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
        sharedInstance = [[CalcInitOperatorInput alloc]init];
    });
    return sharedInstance;  
}

@end
