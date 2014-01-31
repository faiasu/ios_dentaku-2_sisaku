//
//  CalcState.m
//  dentaku
//
//  Created by Akihiro FUKUSUMI on 12/08/02.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import "CalcState.h"
#import "CalculatoEvent.h"
#import "Calc.h"
#import "CalcInit.h"

static  CalcState *sharedInstance;

@implementation CalcState

//@synthesize displayString = displayString_;
//@synthesize displayString2 = displayString2_;
//@synthesize formulaString = formulaString_;


- (id)init
{
    self = [super init];
    if( self ){
        data = [CalcMemory sharedInstance];
    }
    return self;
}

-(void)pressedAllClear:(CalculatoEvent*)calc{
    //calc->Status_ = 1;
    [data setNumber:0];
    [data setAnswer:0];
    
    [calc setFormulaString:[[NSString alloc]initWithFormat:@"%g", [data getNumber]]];
    [data setOperationKey:KEYTYPE_MAX];
    [[data getKeybord] clear];
    [calc setDisplayString:@"0"];
    
    [calc setDisplayString2:[NSString stringWithFormat:@"k(%d),n(%g),a(%g)", 
                             [data getAnswer], [data getOperationkey], [data getNumber], [data getAnswer]]];    
    [calc changeState:[CalcInit sharedInstance]];
}

-(void)pressedClear:(CalculatoEvent *)calc{
    // 基本的にはACと同じ動きで。(CalcNumInput時だけ変える)
    [self pressedAllClear:calc];
}

-(void)pressedNum:(CalculatoEvent *)calc{
}

-(void)pressedPlusMinus:(CalculatoEvent *)calc{
}

-(void)pressedKakeruWaru:(CalculatoEvent *)calc{
}

-(void)pressedEqual:(CalculatoEvent *)calc{
}


-(void)pressedHistory:(CalculatoEvent *)calc{    
}

-(void)Calculate:(CalculatoEvent *)calc{
    
    double answer = [data getAnswer];
    double number = [[data getKeybord].numberString doubleValue];

    switch ([data getOperationkey]) {
        case KEYTYPE_ADD:
            answer += number;
            [calc setFormulaString:[[NSString alloc]initWithFormat:@"%@+%g", calc.formulaString, number]];            
            break;
        case KEYTYPE_SUB:
            answer -= number;
            [calc setFormulaString:[[NSString alloc]initWithFormat:@"%@-%g", calc.formulaString, number]];
            break;
        case KEYTYPE_MUL:
            answer *= number;
            [calc setFormulaString:[[NSString alloc]initWithFormat:@"%@*%g", calc.formulaString, number]];
            break;
        case KEYTYPE_DIV:
            if( number != 0 ){
                // 当然zero以外でないと駄目
                answer /= number;
                [calc setFormulaString:[[NSString alloc]initWithFormat:@"%@/%g", calc.formulaString, number]];            }
            break;
        default:
            NSLog(@"何もしない");
            break;
    }
    [data setNumber:number];
    [data setAnswer:answer];
    
    // KEYTYPE_EQ
    if (calc.keyType == KEYTYPE_EQ) {
        [calc setFormulaString:[[NSString alloc]initWithFormat:@"%@=%g", calc.formulaString, [data getAnswer]]];
        [[data getHistory] setCalcData:[[NSString alloc]initWithFormat:@"%@", calc.formulaString]
                           answer:[[NSString alloc]initWithFormat:@"%g", [data getAnswer]]
             ];
        
    }

    [calc setDisplayString:[NSString stringWithFormat:@"%g", [data getAnswer]]];
    
    [calc setDisplayString2:[NSString stringWithFormat:@"k(%d),n(%g),a(%g)",
                             [data getOperationkey], [data getNumber], [data getAnswer]]];
}
+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CalcState alloc]init];
    });
    return sharedInstance;  
}
@end
