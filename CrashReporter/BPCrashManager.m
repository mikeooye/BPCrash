//
//  BPCrashManager.m
//  CrashReporter
//
//  Created by mikeooye on 15-4-15.
//  Copyright (c) 2015年 mikeooye. All rights reserved.
//

#import "BPCrashManager.h"

@class BPCrashManager;

void unCaughtExceptionHandler(NSException *exception) {
    
    BPCrashManager *manager = [BPCrashManager sharedManager];
    BOOL enableLog = [manager enableCrashLog];
    
    if (enableLog) {
        NSLog(@"crash info:\n %@", exception.formatDescription);
    }
    
    if (manager.callback) {
        manager.callback(exception);
    }
}


@implementation NSException (bpExtension)

- (NSString *)formatDescription
{
    NSString *fmtDate = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterLongStyle];
    
    NSString *fmt = @"\n\nDate:\n%@\nCrash:\n%@\nStack Trace\n%@\n";
    NSString *fmtDesc = [NSString stringWithFormat:fmt,
                         fmtDate, self.description, self.callStackSymbols];
    return fmtDesc;
}
@end

@implementation BPCrashManager

+ (instancetype)sharedManager
{
    static BPCrashManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[BPCrashManager allocWithZone:NULL] init];
    });
    return _manager;
}

- (void)startWithCallback:(void (^)(NSException *))callback
{
    self.callback = callback;
    NSSetUncaughtExceptionHandler(&unCaughtExceptionHandler);
}
@end
