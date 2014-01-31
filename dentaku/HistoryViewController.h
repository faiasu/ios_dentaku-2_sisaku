//
//  HistoryViewController.h
//  dentaku
//
//  Created by Kazunori OYA on 12/07/25.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalcHistory.h"
#import "HistoryViewDelegate.h"

@interface HistoryViewController : UITableViewController
{
    CalcHistory *history_;
    id<HistoryViewDelegate> historyViewDelegate_;
}

@property (nonatomic,assign) id<HistoryViewDelegate> historyViewDelegate;

- (void)setHistory:(CalcHistory*)history;

@end
