//
//  ViewController.m
//  CrashReporter
//
//  Created by mikeooye on 15-4-15.
//  Copyright (c) 2015年 mikeooye. All rights reserved.
//

#import "ViewController.h"
#import "BPCrashReporter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)raiseException:(id)sender {
    
    NSArray *arr = @[];
    NSLog(@"arr out of range: %@", [arr objectAtIndex:1]);
}
- (IBAction)showLog:(id)sender {
    
    UITextView *tv = [[UITextView alloc] initWithFrame:self.view.bounds];
    tv.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:tv];
    
    BPCrashReporter *cr = [[BPCrashReporter alloc] init];
    tv.text = [cr crashLogAtPath:CrashLogFilepath()];
    tv.editable = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTextView:)];
    [tv addGestureRecognizer:tap];
}

- (void)didTapTextView:(UITapGestureRecognizer *)tapGes
{
    [tapGes.view removeFromSuperview];
}
@end
