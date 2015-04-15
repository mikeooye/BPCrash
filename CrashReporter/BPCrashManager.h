//
//  BPCrashManager.h
//  CrashReporter
//
//  Created by mikeooye on 15-4-15.
//  Copyright (c) 2015年 mikeooye. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSException (bpExtension)

@property (readonly, nonatomic) NSString *formatDescription;
@end

@interface BPCrashManager : NSObject

/**
 *  构造方法，单例
 */
+ (instancetype)sharedManager;

/**
 *  注册捕获异常方法
 *
 *  @param callback 捕获异常回调
 */
- (void)startWithCallback:(void(^)(NSException *exception))callback;
/**
 *  回调
 */
@property (copy, nonatomic) void (^callback)(NSException *);

/**
 *  是否打印日志
 */
@property (assign, nonatomic) BOOL enableCrashLog;


@end

