
//
//  ScanCodeViewController.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/26.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "ScanCodeViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "ScanCodeAnimationView.h"

@interface ScanCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) ScanCodeAnimationView *scanView;

@end

@implementation ScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫一扫";
    
    [self addBackButtonWithClickBlock: nil];
    
    [self setUpSubViews];
}


#pragma mark - UI布局
- (void)setUpSubViews {
    
    if ([self captureAuthStatu]) {
        
        self.scanView = [[ScanCodeAnimationView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - 64)];
        [self.view addSubview: self.scanView];
        
        [self setUpDeviceInputAndOutput];
    }
}

#pragma mark - 照相机权限获取及开启扫描
- (BOOL)captureAuthStatu {
    
    if (TARGET_IPHONE_SIMULATOR) {
        return NO;
    }
    // 必须要当前项目访问相机权限必须通过,所以最好在程序进入当前页面的时候进行一次权限访问的判断
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果"
                                                        message: @"请在iPhone的“设置”-“隐私”-“相机”功能中，找到“某某应用”打开相机访问权限"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [self.view addSubview:alert];
        [alert show];
        return NO;
    }
    return YES;
}

- (void)setUpDeviceInputAndOutput {
    
    if ([self captureAuthStatu]) {
        
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:  AVMediaTypeVideo];
        
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice: device error: nil];

        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        //设置输出流的相关属性
        // 确定输出流的代理和所在的线程,这里代理遵循的就是上面我们在准备工作中提到的第一个代理,至于线程的选择,建议选在主线程,这样方便当前页面对数据的捕获.
        [output setMetadataObjectsDelegate: self queue: dispatch_get_main_queue()];
        //设置扫描区域的大小 rectOfInterest  默认值是CGRectMake(0, 0, 1, 1) 按比例设置
        output.rectOfInterest = CGRectMake(ScanY/SCREENH_HEIGHT,((SCREEN_WIDTH-ScanWidth)/2)/SCREEN_WIDTH,ScanHeight/SCREENH_HEIGHT,ScanWidth/SCREEN_WIDTH);
 
        self.session = [[AVCaptureSession alloc] init];
        //预设适用于高分辨率照片质量的输出
        [self.session setSessionPreset: AVCaptureSessionPresetHigh];
        //添加输入输出流
        if ([self.session canAddInput: input]) {
         
            [self.session addInput: input];
        }
        if ([self.session canAddOutput: output]) {
            
            [self.session addOutput: output];
            //扫描格式
            NSMutableArray *metadataObjectTypes = [NSMutableArray array];
            [metadataObjectTypes addObjectsFromArray:@[
                                                       AVMetadataObjectTypeQRCode,
                                                       AVMetadataObjectTypeEAN13Code,
                                                       AVMetadataObjectTypeEAN8Code,
                                                       AVMetadataObjectTypeCode128Code,
                                                       AVMetadataObjectTypeCode39Code,
                                                       AVMetadataObjectTypeCode93Code,
                                                       AVMetadataObjectTypeCode39Mod43Code,
                                                       AVMetadataObjectTypePDF417Code,
                                                       AVMetadataObjectTypeAztecCode,
                                                       AVMetadataObjectTypeUPCECode,
                                                       ]];
            
            // >= ios 8
            if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
                [metadataObjectTypes addObjectsFromArray:@[AVMetadataObjectTypeInterleaved2of5Code,
                                                           AVMetadataObjectTypeITF14Code,
                                                           AVMetadataObjectTypeDataMatrixCode]];
            }
            //设置扫描格式
            output.metadataObjectTypes= metadataObjectTypes;
        }
        
        //设置输出展示平台AVCaptureVideoPreviewLayer
        // 初始化
        AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession: self.session];
        // 设置Video Gravity,顾名思义就是视频播放时的拉伸方式,默认是AVLayerVideoGravityResizeAspect
        // AVLayerVideoGravityResizeAspect 保持视频的宽高比并使播放内容自动适应播放窗口的大小。
        // AVLayerVideoGravityResizeAspectFill 和前者类似，但它是以播放内容填充而不是适应播放窗口的大小。最后一个值会拉伸播放内容以适应播放窗口.
        // 因为考虑到全屏显示以及设备自适应,这里我们采用fill填充
        preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
        // 设置展示平台的frame
        preview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
        // 因为 AVCaptureVideoPreviewLayer是继承CALayer,所以添加到当前view的layer层
        [self.view.layer insertSublayer: preview atIndex:0];
        //开始
        
        [self.session startRunning];
    }
}

#pragma mark - 扫描结果处理
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
 
    // 判断扫描结果的数据是否存在
    if ([metadataObjects count] >0){
        // 如果存在数据,停止扫描
        [self.session stopRunning];
        [self.scanView stopAnimaion];
        // AVMetadataMachineReadableCodeObject是AVMetadataObject的具体子类定义的特性检测一维或二维条形码。
        // AVMetadataMachineReadableCodeObject代表一个单一的照片中发现机器可读的代码。这是一个不可变对象描述条码的特性和载荷。
        // 在支持的平台上,AVCaptureMetadataOutput输出检测机器可读的代码对象的数组
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];

        NSString *stringValue = metadataObject.stringValue;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果"
                                                        message:stringValue
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [self.view addSubview:alert];
        [alert show];
    }
}


@end
