//
//  PopupWindowView.m
//  RainyMood
//
//  Created by RaulStudio on 16/1/12.
//  Copyright © 2016年 RaulStudio. All rights reserved.
//

#import "PopupWindowView.h"

@implementation PopupWindowView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.5;
    
    [self layoutSubviews];
    
    return self;
}


- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    if (newWindow != nil) {
        
    }
    else
    {
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.left.with.offset(8);
        make.top.with.offset(20);
    }];
}

- (void)closeWindow
{
    [self removeFromSuperview];
}


- (UIButton *)btnClose
{
    if (_btnClose == nil) {
        _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnClose setBackgroundImage:[UIImage imageNamed:@"btn_close_n"] forState:UIControlStateNormal];
        [_btnClose setBackgroundImage:[UIImage imageNamed:@"btn_close_p"] forState:UIControlStateHighlighted];
        [_btnClose addTarget:self action:@selector(closeWindow) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnClose];
    }
    return _btnClose;
}

@end
