//
//  CalcMemory.h
//  dentaku
//
//  Created by Akihiro FUKUSUMI on 12/08/06.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Key.h"
#import "Keyboard10.h"
#import "CalcHistory.h"

@interface CalcMemory : NSObject{
    
    Keyboard10 *keyboard_; // 10進用
    CalcHistory *history_;
    KEYTYPE operationKey_;
    double answer_;
    double number_;
    bool isNumberStringClear_;

}

+ (id)sharedInstance;

-(Keyboard10*)getKeybord;
-(CalcHistory*)getHistory;

-(void)setAnswer:(double)answer;
-(void)setNumber:(double)number;
-(void)setOperationKey:(KEYTYPE)operationkey;

-(double)getAnswer;
-(double)getNumber;
-(KEYTYPE)getOperationkey;

@end
