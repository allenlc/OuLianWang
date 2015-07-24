//
//  SettingViewController.h
//  OuLianWang
//
//  Created by 皇室美家 on 15/6/13.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface SettingViewController : UIViewController
@property (strong, nonatomic) UIView *boxView;
@property (nonatomic) BOOL isReading;
@property (strong, nonatomic) CALayer *scanLayer;
@property (strong, nonatomic)  UIView *viewPreview;
@property (strong, nonatomic)  UILabel *lblStatus;
@property (strong, nonatomic)  UIButton *startBtn;
- (void)startStopReading:(id)sender;
-(BOOL)startReading;
-(void)stopReading;
@property (nonatomic, strong) AVCaptureSession *captureSession;
//展示layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@end
