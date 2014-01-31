//
//  MainViewController.m
//  dentaku
//
//  Created by Kazunori OYA on 12/07/25.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import "MainViewController.h"
#import "HistoryViewController.h"
#import "CalculatoEvent.h"


@interface MainViewController ()

@end

@implementation MainViewController

@synthesize selectedIndex = selectedIndex_;

- (void)dealloc
{
    [calc_ release];
    [answerLabel_ release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // 親の画面サイズを取得
        CGRect screenRect = [[UIScreen mainScreen]bounds]; // このサイズを基点に表示位置を計算できそう。。。
        NSLog(@"screenRect x(%f),y(%f),w(%f),h(%f)", 
              screenRect.origin.x, screenRect.origin.y,
              screenRect.size.width, screenRect.size.height);
        
        
        // 初期化
        [self setSelectedIndex:-1];
        calc_ = [[Calc alloc]init];

        event_ = [[CalculatoEvent alloc]init];
        data_ = [CalcMemory sharedInstance];

        // key 情報の初期化(今後ib側の設定を利用するべきか、計算ですべてやるべきかは考え中)
        // 数字
        int i = 0;
        for (; i<= KEYTYPE_9; i++) {
            KeyInfo *pKeyInfo = &keyInfo_[i];
            pKeyInfo->pos = CGPointMake(screenRect.origin.x + 100 + ((i%3) * 60),
                                        screenRect.origin.y + 100 + ((i/3) * 60));
            //NSLog(@"(%d) : pos.x(%f), pos.y(%f)", i, pKeyInfo->pos.x, pKeyInfo->pos.y);
            pKeyInfo->string = [[NSString alloc]initWithFormat:@"%d", i];
            pKeyInfo->keyType = (KEYTYPE)i;
        }

        // その他
        // KEYTYPE_DOT, KEYTYPE_ADD, KEYTYPE_SUB, KEYTYPE_MUL, KEYTYPE_DIV, KEYTYPE_EQ,KEYTYPE_AC,KEYTYPE_C,
        NSArray *arrayString = 
        [NSArray arrayWithObjects:@".", @"+", @"-", @"x", @"/", @"=", @"AC", @"C", nil];

        for (; i<=KEYTYPE_C; i++) {
            KeyInfo *pKeyInfo = &keyInfo_[i];
            int index = i - KEYTYPE_DOT;
            id obj = [arrayString objectAtIndex:index];
            pKeyInfo->pos = CGPointMake(screenRect.origin.x + 100 + ((i%3) * 60),
                                        screenRect.origin.y + 100 + ((i/3) * 60));
            pKeyInfo->string = [[NSString alloc]initWithFormat:@"%@",obj];
            pKeyInfo->keyType = (KEYTYPE)i;
            pKeyInfo++;
        }

        self.navigationItem.title = @"履歴電卓";
        UIBarButtonItem *history = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(historyDidPush)];
                                    
        self.navigationItem.leftBarButtonItem = history;
        //self.navigationItem.rightBarButtonItem = history;
    }
    return self;
}

- (void)historyDidPush
{
    id viewController = [[[HistoryViewController alloc]init]autorelease];
    if( viewController ){
//        [viewController setHistory:[calc_ getCalcHistory]];
        [viewController setHistory:[data_ getHistory]];
        [viewController setHistoryViewDelegate:self];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLog(@"viewDidLoad");
//    answerString_ = [[NSString alloc] initWithFormat:@"0"];
//    numberString_ = [[NSString alloc] initWithFormat:@"0"];

    // Button 配置
    for (int i=0; i<KEYTYPE_MAX; i++) {
        KeyInfo *pKeyInfo = &keyInfo_[i];
        NSString *name = [NSString stringWithFormat:@"%@",pKeyInfo->string];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = i;
        [button setTitle:name forState:UIControlStateNormal];
        [button sizeToFit];
        button.center = CGPointMake(pKeyInfo->pos.x, pKeyInfo->pos.y);

        button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [button addTarget:self action:@selector(buttonDidPush:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
//    // 結果表示
    answerLabel_ = [[UILabel alloc]initWithFrame:CGRectZero];
    answerLabel_.backgroundColor = [UIColor blackColor];
    answerLabel_.textColor = [UIColor whiteColor];
    answerLabel_.textAlignment = UITextAlignmentRight;
    answerLabel_.numberOfLines = 2;
    //answerLabel_.text = [[NSString alloc] initWithFormat:@"%d",number_];
    answerLabel_.text = [[NSString alloc] initWithFormat:@"0\n---test--"];
    answerLabel_.frame = CGRectMake( 10, 20, 300, 50);
    
    [self.view addSubview:answerLabel_];
    
}

- (void)buttonDidPush: (id)sender
{
    
    
    NSLog(@"buttonDidPush tag(%d)", [sender tag]); // どのボタンイベントかが判断できればなんとかなりそう。
    
    KEYTYPE key = [sender tag];
   
    // 入力＆計算
//    [calc_ inputKey:key];
    [event_ inputKey:key];
    

    // 画面更新
    [self updateAnswerLabel];
}

// 表示エリアを更新する
- (void)updateAnswerLabel
{
    // 入力履歴も表示できるようにする
//    NSString *buffer = [NSString stringWithFormat:@"%@\n%@", calc_.displayString, calc_.displayString2];
    
//    NSString *buffer = [NSString stringWithFormat:@"%@\n%@", calc_.displayString, calc_.formulaString];
    NSString *buffer = [NSString stringWithFormat:@"%@\n%@", [event_ displayString], event_.formulaString];
  
    answerLabel_.text = buffer;
    
}

- (void)viewWillAppear:(BOOL)animated
{
#if 0 // プロパティを使ったムリムリ通知
    NSLog(@"selectedIndex[%d]", selectedIndex_);
    if( selectedIndex_ != -1 ){
        [calc_ selectedCalcHistoryIndex: selectedIndex_];
        // 画面更新
        [self updateAnswerLabel];
    }
#endif
}

- (void)selectedHistoryIndex:(int)index
{
    if( index != -1 ){
//        [calc_ selectedCalcHistoryIndex: index];
        [event_ selectedCalcHistoryIndex: index];
        // 画面更新
        [self updateAnswerLabel];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
