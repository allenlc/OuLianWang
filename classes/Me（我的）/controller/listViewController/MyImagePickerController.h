//
//  MyImagePickerController.h
//  OuLianWang
//
//  Created by allenariel on 15/7/2.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyImagePickerController : UIImagePickerController
@property(nonatomic,copy)void(^pickBlick)();

@end
