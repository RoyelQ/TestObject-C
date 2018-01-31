
//
//  SpeechMannager.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/29.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "SpeechMannager.h"

#import <Speech/Speech.h>

#import <AVFoundation/AVFoundation.h>

@interface SpeechMannager ()

@property (nonatomic, strong) SFSpeechRecognizer *speechRecognizer;

@property (nonatomic, strong) AVAudioRecorder *recorder;

@end

@implementation SpeechMannager

static SpeechMannager *shareManager = nil;

+ (SpeechMannager *)shareManager {
    
    static dispatch_once_t onceToken;
   
    dispatch_once(&onceToken, ^{
        
        shareManager = [[SpeechMannager alloc] init];
        
        //初始化录音会话
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        NSError *error;
        /**
         类别         当按“静音”或者锁屏是是否静音   是否引起不支持混音的App中断 是否支持录音和播放
         AVAudioSessionCategoryAmbient              是        否         只支持播放
         AVAudioSessionCategoryAudioProcessing      -      都不支持
         AVAudioSessionCategoryMultiRoute           否        是         既可以录音也可以播放
         AVAudioSessionCategoryPlayAndRecord        否     默认不引起      既可以录音也可以播放
         AVAudioSessionCategoryPlayback             否     默认引起       只用于播放
         AVAudioSessionCategoryRecord               否        是         只用于录音
         AVAudioSessionCategorySoloAmbient          是        是         只用于播放
         */
        [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
        NSParameterAssert(!error);
        [audioSession setMode:AVAudioSessionModeMeasurement error:&error];
        NSParameterAssert(!error);
        //    因为AVAudioSession会影响其他App的表现，当自己App的Session被激活，其他App的就会被解除激活，如何要让自己的Session解除激活后恢复其他App Session的激活状态呢？
        [audioSession setActive:YES withOptions: AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
        NSParameterAssert(!error);
        
        //初始化录音设置
        //设置参数
        NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                       [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                       // 音频格式
                                       [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                       //采样位数  8、16、24、32 默认为16
                                       [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                       // 音频通道数 1 或 2
                                       [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                       //录音质量
                                       [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                       nil];
        shareManager.recorder = [[AVAudioRecorder alloc] initWithURL: nil settings:recordSetting error:nil];
        
        if (shareManager.recorder) {
            shareManager.recorder.meteringEnabled = YES;
            [shareManager.recorder prepareToRecord];
        }
 
        //初始化识别器
        NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
       
        if (@available(iOS 10.0, *)) {
            
            shareManager.speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:local];
        }
    });
    
    return shareManager;
}


- (BOOL)microAuthStatu {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            //没有询问是否开启麦克风
             break;
        case AVAuthorizationStatusRestricted:
            //未授权，家长限制
             break;
        case AVAuthorizationStatusDenied:
            //玩家未授权
             break;
        case AVAuthorizationStatusAuthorized:
            //玩家授权
             break;
        default:
            break;
    }
    return NO;
}


- (void)startAudio {
 
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
                        break;
                    default:
                        break;
                }
            });
        }];
    }
}


- (void)startRecongLocal {
    if (@available(iOS 10.0, *)) {
        //此处设置支持的语言

        NSURL *url =[[NSBundle mainBundle] URLForResource:@"录音.m4a" withExtension:nil];
        if (!url) return;
        SFSpeechURLRecognitionRequest *res =[[SFSpeechURLRecognitionRequest alloc] initWithURL:url];

        [self.speechRecognizer recognitionTaskWithRequest:res resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
            if (error) {
                NSLog(@"语音识别解析失败,%@",error);
            }
            else
            {
//                weakSelf.recongLabel.text = result.bestTranscription.formattedString;
            }
        }];
    }
}




@end
