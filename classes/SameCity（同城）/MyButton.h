//
//  MyButton.h
//  MyFreeLimit
//
//  Created by 夏威夷man on 15-4-8.
//  Copyright (c) 2015年 夏威夷man. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^actionBlock)(UIButton *button);
typedef void(^buttonAction)(id button);
@interface MyButton : UIButton
//注意:block属性修饰符必须是copy
@property (copy,nonatomic) void (^actionBlock) (UIButton *button);

@end

@interface MyBarButton : UIBarButtonItem

@property (nonatomic,copy) buttonAction blockAction;

- (instancetype)initWithStyle:(UIBarButtonItemStyle)style
                       tittle:(NSString *)tittle
                       action:(void(^)(id button))action;

- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem
                                     action:(void(^)(id button))action;

- (instancetype)initWithImage:(UIImage *)image
                        style:(UIBarButtonItemStyle)style
                       action:(void(^)(id button))action;
@end
