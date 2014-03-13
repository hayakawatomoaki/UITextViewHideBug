//
//  MyTextView.m
//  UITextViewHideBug
//
//  Created by HAYAKAWA TOMOAKI on 2014/03/13.
//  Copyright (c) 2014年 hayatomo.com. All rights reserved.
//

#import "MYTextView.h"

@implementation MyTextView

- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }    
    return self;
}

- (void)scrollRangeToVisible:(NSRange)range
{
    [super scrollRangeToVisible:range];
    
    // 最後の行が隠れてしまうiOS7バグの対応
    if(SYSTEM_VERSION_LESS_THAN(@"7.0")){
    } else {
        if ( (self.layoutManager.extraLineFragmentTextContainer != nil) && (self.selectedRange.location == range.location) )
        {
            CGRect caretRect = [self caretRectForPosition:self.selectedTextRange.start];
            [self scrollRectToVisible:caretRect animated:YES];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
