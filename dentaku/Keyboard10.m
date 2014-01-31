//
//  Keyboard10.m
//  dentaku
//
//  Created by Kazunori OYA on 12/07/27.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import "Keyboard10.h"
#import "Key.h"

@implementation Keyboard10

@synthesize numberString = numberString_;

- (id)init
{
    self = [super init];
    if( self ){
        [self clear];
    }
    return self;
}

- (void)dealloc
{
    [self setNumberString:nil]; // これの方がretain,assingともにOKのコード
    [super dealloc];
}


// [0-9.]の入力のみ受け付ける
- (void)inputKey:(KEYTYPE)key
{
    // 数値入力時にクリア要求があれば初期化する
    if( (key >= KEYTYPE_0) && (key <= KEYTYPE_DOT) ){
        if (isRequestClear_) {
            [self clear];
        }
    }
    
    // 小数点の場合の考慮
    if( KEYTYPE_DOT == key ){
        NSRange searchResult = [self.numberString rangeOfString:@"."];
        if(searchResult.location != NSNotFound){
            // DOTが見つかった場合の処理
            // 何もしない
            return;
        }
        [self setNumberString:[[NSString alloc]initWithFormat:@"%@.", self.numberString]];
    }
    
    // 数字の場合のみ考慮する
    if( (key >= KEYTYPE_0) && (key <= KEYTYPE_9) ){
        // 最初がゼロの場合
        NSString *str = nil;
        if( [self.numberString isEqualToString:@"0"] ){
            str = [[NSString alloc ]initWithFormat:@"%d",key];
        }
        else{
            str = [[NSString alloc]initWithFormat:@"%@%d", self.numberString, key];
        }
        [self setNumberString:str]; // 更新
    }

}

- (void)clear
{
    isRequestClear_ = false;
    [self setNumberString:@"0"];
}

- (void)requestClear
{
    isRequestClear_ = true;
}

@end
