//
//  AudioFileManager.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/29.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FileManagerType){
    FileManagerTypeAudio = 0,           //录音
    FileManagerTypeMedia = 1,           //视频
    FileManagerTypeMusic = 2,           //音乐
    FileManagerTypePic = 3,             //图片
    FileManagerTypeFile = 4,            //文件
    FileManagerTypeSqlLite = 5,         //数据库
    FileManagerTypeOther= 6,            //其他
};

@interface AudioFileManager : NSObject

@property (nonatomic, assign) FileManagerType fileType;

+ (AudioFileManager *)shareManager;

//创建文件夹或目录
- (NSString *)crearFileFolder:(NSString *)fileName fileType:(FileManagerType)fileType contents:(NSData *)contents;

//删除文件
- (void)deleteFile:(NSString *)fileName fileType:(FileManagerType)fileType;
- (void)deleteFile:(NSString *)path;

//文件内容读、写
- (BOOL)writeToFile:(NSString *)fileName fileType:(FileManagerType)fileType contents:(NSData *)contents;
- (NSData *)contentOfFile:(NSString *)fileName fileType:(FileManagerType)fileType;

//获取文件属性
- (void)fileAttriutes:(NSString *)fileName fileType:(FileManagerType)fileType;

//文件夹路径
- (NSString *)fileFolderPath:(FileManagerType)fileType;


@end
