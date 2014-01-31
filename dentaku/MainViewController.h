//
//  MainViewController.h
//  dentaku
//
//  Created by Kazunori OYA on 12/07/25.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Key.h"
#import "Keyboard10.h"
#import "Calc.h"
#import "HistoryViewDelegate.h"
#import "CalculatoEvent.h"
#import "CalcState.h"

@interface MainViewController : UIViewController <HistoryViewDelegate>
{
    @private
    KeyInfo keyInfo_[KEYTYPE_MAX];
    Calc *calc_;
    CalcMemory *data_;
    CalculatoEvent *event_;
    UILabel *answerLabel_;
    NSInteger selectedIndex_;
}

@property(nonatomic) NSInteger selectedIndex;

@end
