//
//  AudioManager.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/29.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Speech/Speech.h>

#import <AVFoundation/AVFoundation.h>

#import "AudioFileManager.h"

@interface AudioManager : NSObject

@property (nonatomic, strong) AVAudioRecorder *recorder;

+ (AudioManager *)shareManager;


@end
