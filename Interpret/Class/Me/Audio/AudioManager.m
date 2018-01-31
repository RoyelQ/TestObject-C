//
//  AudioManager.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/29.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "AudioManager.h"

@interface AudioManager ()

@property (nonatomic, strong) NSDictionary *recordSetting;

@end
 
@implementation AudioManager

static AudioManager *shareManager = nil;

+ (AudioManager *)shareManager {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        shareManager = [[AudioManager alloc] init];
        
        [shareManager microAuthStatu];
        
    });
    return shareManager;
}

- (void)microAuthStatu {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            //没有询问是否开启麦克风
            {
                [AVCaptureDevice requestAccessForMediaType: AVMediaTypeAudio completionHandler:^(BOOL granted) {
                    if (granted) {
                        [self audioSetting];
                    }
                }];
            }
            break;
        case AVAuthorizationStatusRestricted:
            //麦克风访问权限受限制
            break;
        case AVAuthorizationStatusDenied:
            //用户拒绝授权麦克风
            break;
        case AVAuthorizationStatusAuthorized:
            //用户授权使用麦克风权限
            [self audioSetting];
            break;
        default:
            break;
    }
}

- (void)audioSetting {
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
    self.recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
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

    
}

- (void)startAudio:(NSString *)fileName {
    
    self.recorder = [[AVAudioRecorder alloc] initWithURL: [NSURL URLWithString: [[AudioFileManager shareManager] crearFileFolder: fileName fileType: FileManagerTypeAudio contents: nil]] settings: self.recordSetting error:nil];
    
    if (self.recorder) {
        
        self.recorder.meteringEnabled = YES;
       
        [self.recorder prepareToRecord];
    }
    [self.recorder record];
}

- (void)stopAudio {
    
    if ([self.recorder isRecording]) {
       
        [self.recorder stop];
    }
}

- (void)playAudio:(NSString *)fileName {
    
    if (self.recorder) {
      
        [self.recorder stop];
    }

    
}

//AVAudioPlayer

- (IBAction)PlayRecord:(id)sender {
    
    NSLog(@"播放录音");
    [self.recorder stop];
    
    if ([self.player isPlaying])return;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl error:nil];
    
    
    
    NSLog(@"%li",self.player.data.length/1024);
    
    
    
    [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.player play];
    
    
    
    
}
@end
