//
//  ViewController.m
//  UITextViewHideBug
//
//  Created by HAYAKAWA TOMOAKI on 2014/03/13.
//  Copyright (c) 2014年 hayatomo.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize textView;

- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // toolbar
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,44.f)];
    toolbar.delegate = self;
    UIBarButtonItem *insertBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushedInsertBtn:)];
    NSArray *elements = [NSArray arrayWithObjects:insertBtn, nil];
    [toolbar setItems:elements];

    textView = [[MyTextView alloc] init];
    textView.delegate = self;
    textView.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height);
    textView.font = [UIFont systemFontOfSize:20];
    textView.inputAccessoryView = toolbar;
    textView.text = @"iOS7で下記のバグを解消しました。\n・文字挿入時に改行以降が隠れてしまう。（下の＋ボタン）\n・最後の行が隠れてしまう。\n\n";
    
    [self.view addSubview:textView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [textView becomeFirstResponder];
}

- (void)pushedInsertBtn:(id)sender
{
    NSString *insertStr = @"これは挿入された文字です。改行以降が隠れなくなりました。";
    NSRange range_ = textView.selectedRange;
    NSString *firstHalfString = [textView.text substringToIndex:range_.location];
    NSString *secondHalfString = [textView.text substringFromIndex:range_.location];
    textView.scrollEnabled = NO;  // turn off scrolling
    textView.text = [NSString stringWithFormat: @"%@%@%@",
                             firstHalfString,
                             insertStr,
                             secondHalfString];
    range_.location += [insertStr length];
    textView.selectedRange = range_;
    textView.scrollEnabled = YES;  // turn scrolling back on.
 

    // 文字挿入時に改行以降が隠れてしまうiOS7バグの対策
    textView.scrollEnabled =NO;
    textView.scrollEnabled =YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUIKeyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUIKeyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    return YES;
}
- (void)onUIKeyboardWillShowNotification:(NSNotification *)notification
{
    // adjust textview-height
    CGRect bounds = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    textView.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - bounds.size.height - 20);
}

- (void)onUIKeyboardWillHideNotification:(NSNotification *)notification
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
