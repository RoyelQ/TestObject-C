

//
//  AudioViewController.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/29.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "AudioViewController.h"

#import <Speech/Speech.h>

#import <AVFoundation/AVFoundation.h>

@interface AudioViewController () <SFSpeechRecognizerDelegate>

@property (nonatomic, strong) SFSpeechRecognizer *speechRecognizer;

@property (nonatomic, strong) UILabel *recongLabel;
@property (nonatomic,strong) AVAudioEngine *audioEngine;
@property (nonatomic,strong) SFSpeechRecognitionTask *recognitionTask;
@property (nonatomic,strong) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
@end

@implementation AudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"语音识别";
    [self addBackButtonWithClickBlock: nil];

 
    [self speechRecongAuth];

}











- (void)speechRecongAuth {
    
    if (@available(iOS 10.0, *)) {
        //仅iOS 10.0以上支持语音识别
        [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                switch (status) {
                    case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                        //用户未选择授权
                        
                        
                        break;
                    case SFSpeechRecognizerAuthorizationStatusDenied:
                        //用户拒绝授权
                        
                        
                        break;
                    case SFSpeechRecognizerAuthorizationStatusRestricted:
                        //语音识别权限受到限制
                        

                        break;
                    case SFSpeechRecognizerAuthorizationStatusAuthorized:
                        //用户允许语音识别权限
                        [self creatButton];
                        break;
                    default:
                        break;
                }
            });
        }];
    }
}

- (void)creatButton {
    
    __block NSInteger clickCount = 0;
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = CGRectMake(80, 100, 160, 40);
    [button setTitle: @"开始识别" forState: UIControlStateNormal];
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 4;
    button.layer.borderColor = Seperator_line_color.CGColor;
    button.layer.masksToBounds = YES;
    [self.view addSubview: button];
    [button addAction:^{
        
        [self startRecongAudio];

//        clickCount ++;
//        if (clickCount%2 == 0) {
//
//            [self startRecongAudio];
//        }else {
//
//            [self startRecongLocal];
//        }
        
    }];
    
    
    self.recongLabel = [[UILabel alloc] initWithFrame: CGRectMake(80, 160, 160, 200)];
    self.recongLabel.numberOfLines = 0;
    self.recongLabel.textColor = Main_text_color_gray;
    self.recongLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview: self.recongLabel];
    
    
    __weak AudioViewController *weakSelf = self;
    NSLocale *local =[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    if (@available(iOS 10.0, *)) {
        
        weakSelf.speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale: local];
        weakSelf.speechRecognizer.delegate = weakSelf;

    } else {

    }
}


- (void)startRecongAudio {
    
    
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error;
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    NSParameterAssert(!error);
    [audioSession setMode:AVAudioSessionModeMeasurement error:&error];
    NSParameterAssert(!error);
    [audioSession setActive:YES withOptions: AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    NSParameterAssert(!error);
    
_recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    NSAssert(inputNode, @"录入设备没有准备好");
    NSAssert(_recognitionRequest, @"请求初始化失败");
    _recognitionRequest.shouldReportPartialResults = YES;
    __weak typeof(self) weakSelf = self;
    _recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:_recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        BOOL isFinal = NO;
        if (result) {
             isFinal = result.isFinal;
        }
        if (error || isFinal) {
            [self.audioEngine stop];
            [inputNode removeTapOnBus:0];
            strongSelf.recognitionTask = nil;
            strongSelf.recognitionRequest = nil;
        }
        
    }];
    
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    //在添加tap之前先移除上一个  不然有可能报"Terminating app due to uncaught exception 'com.apple.coreaudio.avfaudio',"之类的错误
    [inputNode removeTapOnBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (strongSelf.recognitionRequest) {
           
            [strongSelf.recognitionRequest appendAudioPCMBuffer:buffer];
        }
    }];
    
    [self.audioEngine prepare];
    [self.audioEngine startAndReturnError:&error];
    NSParameterAssert(!error);
    self.recongLabel.text = @"正在录音。。。";
}

- (AVAudioEngine *)audioEngine{
    if (!_audioEngine) {
        _audioEngine = [[AVAudioEngine alloc] init];
    }
    return _audioEngine;
}


- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available  {
    
    
}


- (void)startRecongLocal {
    if (@available(iOS 10.0, *)) {
        //此处设置支持的语言
        NSLocale *local =[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        SFSpeechRecognizer *localRecognizer =[[SFSpeechRecognizer alloc] initWithLocale:local];
        NSURL *url =[[NSBundle mainBundle] URLForResource:@"录音.m4a" withExtension:nil];
        if (!url) return;
        SFSpeechURLRecognitionRequest *res =[[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
        __weak typeof(self) weakSelf = self;
        [localRecognizer recognitionTaskWithRequest:res resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
            if (error) {
                NSLog(@"语音识别解析失败,%@",error);
            }
            else
            {
                weakSelf.recongLabel.text = result.bestTranscription.formattedString;
            }
        }];
    }
}


@end
