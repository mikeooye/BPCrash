//
//  BPCrashReporter.h
//  CrashReporter
//
//  Created by mikeooye on 15-4-15.
//  Copyright (c) 2015年 mikeooye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPCrashReporter : NSObject

/**
 *  将闪退日志保存到文件中
 *
 *  @param log      异常信息
 *  @param filePath 文件路劲
 *
 *  @return 成功或失败
 */
- (BOOL)saveCrashLog:(NSString *)log toFilepath:(NSURL *)filePath;

/**
 *  删除文件
 *
 *  @param path 文件路径
 *
 *  @return 成功或失败
 */
- (BOOL)clearFileAtPath:(NSURL *)path;

/**
 *  日志文件中的内容
 *
 *  @param path 文件路径
 *
 *  @return 内容
 */
- (NSString *)crashLogAtPath:(NSURL *)path;
@end

/**
 *  @return 闪退日志路径获取
 */
static inline NSURL *CrashLogFilepath(void){
    
    NSURL *docPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *path = [docPath URLByAppendingPathComponent:@"crash_log.txt"];
    return path;
}