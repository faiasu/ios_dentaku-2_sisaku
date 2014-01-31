//
//  Keyboard10.h
//  dentaku
//
//  Created by Kazunori OYA on 12/07/27.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Key.h"

@interface Keyboard10 : NSObject
{
    NSString *numberString_;
    bool isRequestClear_;
}

@property(nonatomic,retain) NSString *numberString;

- (void)inputKey:(KEYTYPE)key;
- (void)clear;
- (void)requestClear;

@end
