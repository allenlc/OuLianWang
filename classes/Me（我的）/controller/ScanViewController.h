//
//  ScanViewController.h
//  QRCoderWinthSystem
//
//  Created by mac on 15/4/29.
//  Copyright (c) 2015年 zhang jian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController : UIViewController
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong,nonatomic) AVCaptureDevice * device;
@property (strong,nonatomic) AVCaptureDeviceInput * input;
@property (strong,nonatomic) AVCaptureMetadataOutput * output;
@property (strong,nonatomic) AVCaptureSession * session;
@property (strong,nonatomic) AVCaptureVideoPreviewLayer * previewLayer;
@property (nonatomic, retain) UIImageView * line;
@end
