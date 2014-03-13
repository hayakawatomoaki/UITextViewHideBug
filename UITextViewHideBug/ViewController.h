//
//  ViewController.h
//  UITextViewHideBug
//
//  Created by HAYAKAWA TOMOAKI on 2014/03/13.
//  Copyright (c) 2014年 hayatomo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextView.h"

@interface ViewController : UIViewController<UIToolbarDelegate, UITextViewDelegate>

@property (nonatomic) MyTextView *textView;
@property (nonatomic) UIBarButtonItem *insertBtn;

@end
