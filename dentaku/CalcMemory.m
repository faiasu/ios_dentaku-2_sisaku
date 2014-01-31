//
//  CalcMemory.m
//  dentaku
//
//  Created by Akihiro FUKUSUMI on 12/08/06.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//
#define CALC_HISTORY_MAX (50)
#import "CalcMemory.h"

static CalcMemory *sharedInstance;

@implementation CalcMemory

- (id)init
{
    self = [super init];
    if( self ){
        keyboard_ = [[Keyboard10 alloc]init];
        history_ = [[CalcHistory alloc]initWithMax:CALC_HISTORY_MAX];
    }
    return self;
}

-(void)setAnswer:(double)answer{
    answer_ = answer;
}

-(void)setNumber:(double)number{
    number_ = number;
}

-(void)setOperationKey:(KEYTYPE)operationkey{
    operationKey_ = operationkey;
}

-(double)getAnswer{
    return answer_;
}

-(double)getNumber{
    return number_;
}

-(KEYTYPE)getOperationkey{
    return operationKey_;
}

-(Keyboard10*)getKeybord{
    return keyboard_;
}

-(CalcHistory*)getHistory{
    return history_;
}
+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CalcMemory alloc]init];
    });
    return sharedInstance;  
}

@end
