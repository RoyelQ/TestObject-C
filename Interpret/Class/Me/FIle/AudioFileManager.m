
//
//  AudioFileManager.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/29.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "AudioFileManager.h"

#import "QJAlertSimple.h"
/*
 * App所产生的数据都存在于自己的沙盒中，一般沙盒都有3个文件：Documents、Library和tmp。
 *
 * Documents：这个目录存放用户数据。存放用户可以管理的文件；iTunes备份和恢复的时候会包括此目录。
 * Library:主要使用它的子文件夹,我们熟悉的NSUserDefaults就存在于它的子目录中。
 * Library/Caches:存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除,“删除缓存”一般指的就是清除此目录下的文件。
 * Library/Preferences:NSUserDefaults的数据存放于此目录下。
 * tmp:App应当负责在不需要使用的时候清理这些文件，系统在App不运行的时候也可能清理这个目录。
 *
 * 所有新建文件夹目录均存储在Documents目录下
 * 文件命名格式为 文件名称.文件类型
 */

@interface AudioFileManager ()

@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation AudioFileManager

static AudioFileManager *shareManager = nil;

+ (AudioFileManager *)shareManager {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        shareManager = [[AudioFileManager alloc] init];
        
        shareManager.fileManager = [NSFileManager defaultManager];
        
    });
    
    return shareManager;
}


#pragma mark - 文件操作 存、删、属性
//创建文件夹或目录
- (NSString *)crearFileFolder:(NSString *)fileName fileType:(FileManagerType)fileType contents:(NSData *)contents {

    NSString * path = [NSString stringWithFormat:@"%@/%@", [self fileFolderPath: fileType], fileName];

    if ([self.fileManager fileExistsAtPath: path]) {
 
        [QJAlertSimple alertViewControllerWithAlertTitle: @"提示" alertMessage: @"文件(夹)已存在，是否替换" cancelTitle: @"取消" confirmTitle: @"替换" cancelHandler: nil confirmHandler:^{
            
            [self.fileManager removeItemAtPath: path error: nil];

            [self.fileManager createFileAtPath: path contents: contents attributes: nil];

        } alertFinishHandler: nil];
    }else {
        
        [self.fileManager createFileAtPath: path contents: contents attributes: nil];
    }
    return path;
}
//删除文件
- (void)deleteFile:(NSString *)fileName fileType:(FileManagerType)fileType {
    
    NSString * path = [NSString stringWithFormat:@"%@/%@", [self fileFolderPath: fileType], fileName];
    
    if ([self.fileManager fileExistsAtPath: path]) {

        [self.fileManager removeItemAtPath: path error: nil];

    }
}
- (void)deleteFile:(NSString *)path {
    
    if ([self.fileManager fileExistsAtPath: path]) {
        
        [self.fileManager removeItemAtPath: path error: nil];
        
    }
}
//文件内容读、写
- (BOOL)writeToFile:(NSString *)fileName fileType:(FileManagerType)fileType contents:(NSData *)contents  {
    
    NSString * path = [NSString stringWithFormat:@"%@/%@", [self fileFolderPath: fileType], fileName];

    return [contents writeToFile: path atomically: YES];
}

- (NSData *)contentOfFile:(NSString *)fileName fileType:(FileManagerType)fileType {
    
    NSString * path = [NSString stringWithFormat:@"%@/%@", [self fileFolderPath: fileType], fileName];

    return (NSData *)[NSString stringWithContentsOfFile: path encoding: NSUTF8StringEncoding error: nil];
}

//获取文件属性
- (void)fileAttriutes:(NSString *)fileName fileType:(FileManagerType)fileType  {
    
    NSString * path = [NSString stringWithFormat:@"%@/%@", [self fileFolderPath: fileType], fileName];

    NSDictionary *fileAttributes = [self.fileManager attributesOfItemAtPath:path error:nil];
    
    NSArray *keys;
    
    id key, value;
    
    keys = [fileAttributes allKeys];
    
    NSInteger count = [keys count];
    
    for (int i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];  //获取文件名
        
        value = [fileAttributes objectForKey: key];  //获取文件属性
    }
}

#pragma mark - 获取沙盒中目的路径
//沙盒路径
- (NSString *)sandBoxPath {
    
    return NSHomeDirectory();
}
//Documents路径
- (NSString *)documentPath {

    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}
//Library路径
- (NSString *)libraryPath {
    
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];

}
//Library/Caches路径
- (NSString *)cachesPath {
    
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}
//tmp路径
- (NSString *)tmpPath {
    
    return NSTemporaryDirectory();
}
//文件夹路径
- (NSString *)fileFolderPath:(FileManagerType)fileType {
    
    NSString *foldlePath = @"其他";
    switch (fileType) {
        case FileManagerTypeAudio:
            foldlePath = @"录音";
            break;
        case FileManagerTypeMedia:
            foldlePath = @"视频";
            break;
        case FileManagerTypeMusic:
            foldlePath = @"音乐";
            break;
        case FileManagerTypePic:
            foldlePath = @"图片";
            break;
        case FileManagerTypeFile:
            foldlePath = @"文件";
            break;
        case FileManagerTypeSqlLite:
            foldlePath = @"数据库";
            break;
        case FileManagerTypeOther:
            foldlePath = @"其他";
            break;
        default:
            break;
    }
    return [NSString stringWithFormat:@"%@/%@", [self documentPath], foldlePath];
}



@end
