//
//  MyButton.m
//  MyFreeLimit
//
//  Created by 夏威夷man on 15-4-8.
//  Copyright (c) 2015年 夏威夷man. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)btnClick:(UIButton *)button{
    if (_actionBlock) {
        _actionBlock(self);
    }
}
@end

@implementation MyBarButton

- (instancetype)initWithStyle:(UIBarButtonItemStyle)style
                       tittle:(NSString *)tittle
                       action:(buttonAction)action
{
    self = [super initWithTitle:tittle style:style target:self action:@selector(buttonClick:)];
    _blockAction = action;
    return self;
}

- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem
                                     action:(void(^)(id button))action
{
    self = [super initWithBarButtonSystemItem:systemItem target:self action:@selector(buttonClick:)];
    _blockAction = action;
    return self;
}

- (instancetype)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style action:(void (^)(id))action
{
    self = [super initWithImage:image style:style target:self action:@selector(buttonClick:)];
    _blockAction = action;
    return self;
}


- (void)buttonClick:(id)sender
{
    if (_blockAction) {
        _blockAction(self);
    }
}

@end