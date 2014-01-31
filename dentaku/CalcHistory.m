//
//  CalcHistory.m
//  dentaku
//
//  Created by Kazunori OYA on 12/07/28.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import "CalcHistory.h"

@implementation CalcHistory

- (id)init
{
    self = [super init];
    if(self){
        // デフォルトはただの空の箱のみ作成する。
        index_ = 0;
        count_ = 0;
        listMax_ = 0;
        list_ = nil;
    }
    return self;
}

- (id)initWithMax:(int)max
{
    self = [super init];
    if(self){
        [self reset:max];
    }
    return self;
}

- (void)reset:(int)max
{
    if( list_ ){
        free(list_);
        list_ = nil;
    }
    
    list_ = (CalcData *)malloc( sizeof(CalcData) * max);
    if( list_ ){
        // 領域確保できたらば最大値を代入する。
        listMax_ = max;
        memset((void *)list_, 0, sizeof(CalcData) * max); // nil設定
    }
    index_ = 0;
    count_ = 0;
}

- (CalcData *)getCalcData:(int)index
{
    // 無効な場合はnil
    if( (index < 0) && (index >= count_) ){
        return nil;
    }
    int hindex = index_ - index - 1;
    if( hindex < 0 ){
        hindex += listMax_;
    }
    hindex %= listMax_;
    
    NSLog(@"index(%d)=(%d), (%d)/(%d)", index,hindex, index_, listMax_);
    
    return (CalcData*)&list_[hindex];
    
}

- (bool)setCalcData:(NSString *)formula answer:(NSString *)answer
{
    // 最大値がゼロなら登録できない
    if ( listMax_ <= 0 ) {
        return false;
    }
    // リングで保持し続ける。
    CalcData *cdp = (CalcData *)&list_[index_];
    
    // formula を設定
    if ( cdp->formula ){
        [cdp->formula release];
        cdp->formula = nil;
    }
    cdp->formula = formula;
    
    if ( cdp->answer ){
        [cdp->answer release];
        cdp->answer = nil;
    }
    cdp->answer = answer;
    
    index_++;
    index_ %= listMax_;
    if( count_ != listMax_ ){
        count_++;
    }
    
    return true;
}

// 保持数最大値
- (int)getCount
{
    // 最新の保持数
    return count_;
}




@end
