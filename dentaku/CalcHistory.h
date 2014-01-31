//
//  CalcHistory.h
//  dentaku
//
//  Created by Kazunori OYA on 12/07/28.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    NSString *formula;
    NSString *answer;
}CalcData;


@interface CalcHistory : NSObject
{
    int index_; // 今のindex
    int count_; // 保持数
    int listMax_;   // listの最大値
    CalcData *list_;
}

- (id)initWithMax:(int)max;
- (CalcData *)getCalcData:(int)index; // 無効な場合はnil
- (bool)setCalcData:(NSString *)formula answer:(NSString *)answer;
- (int)getCount; // 最新の保持数


@end
