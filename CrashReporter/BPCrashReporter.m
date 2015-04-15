//
//  BPCrashReporter.m
//  CrashReporter
//
//  Created by mikeooye on 15-4-15.
//  Copyright (c) 2015年 mikeooye. All rights reserved.
//

#import "BPCrashReporter.h"

@implementation BPCrashReporter

- (BOOL)saveCrashLog:(NSString *)log toFilepath:(NSURL *)filePath
{
    NSParameterAssert(filePath);
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if ([fileMgr fileExistsAtPath:filePath.path]) {
        
        //将闪退日志添加到文件末尾，一定要文件存在为前提
        NSFileHandle *fileHandler = [NSFileHandle fileHandleForWritingAtPath:filePath.path];
        [fileHandler seekToEndOfFile];
        [fileHandler writeData:[log dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandler closeFile];
        return YES;
    }else{

        //若文件不存在，创建文件并写入内容
        NSError *error = nil;
        BOOL success = [log writeToURL:filePath atomically:NO encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"error: %@", error);
        }
        return success;
    }
}

- (BOOL)clearFileAtPath:(NSURL *)path
{
    NSParameterAssert(path);
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    if ([mgr fileExistsAtPath:path.absoluteString]) {
        
        NSError *error = nil;
        BOOL success = [mgr removeItemAtURL:path error:&error];
        
        if (error) {
            NSLog(@"%s, error: %@", __PRETTY_FUNCTION__, error);
        }
        return success;
    }
    
    return NO;
}

- (NSString *)crashLogAtPath:(NSURL *)path
{
    NSError *error = nil;
    NSString *log = [NSString stringWithContentsOfURL:path encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        NSLog(@"error: %@", error);
        return nil;
    }
    return log;
}
@end
