//
//  RecordVoiceManager.m
//  聊天键盘
//
//  Created by wangguigui on 16/6/1.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import "RecordVoiceManager.h"
#import <AVFoundation/AVFoundation.h>

@interface RecordVoiceManager()<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    AVAudioRecorder * recorder;
    NSURL * recordUrl;
    NSTimer * timer;
}

@end

@implementation RecordVoiceManager

static RecordVoiceManager * shareManager = nil;
+(RecordVoiceManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc]init];
    });
    return shareManager;
}

-(void)startRecordVoiceWithPath:(NSString *)path
{
    NSMutableDictionary * recordSetting = [NSMutableDictionary dictionary];
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44110] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    
//    NSDateFormatter * fm = [[NSDateFormatter alloc]init];
//    [fm setDateFormat:@"yyyy-MM-dd-hh-mm-ss"];
//    NSDate * date = [NSDate date];
//    NSString * dateString = [fm stringFromDate:date];
//    NSString * dateStr = [NSString stringWithFormat:@"%@",dateString];
    NSString * fileString = [NSString stringWithFormat:@"%@/Library/SaveRecord",NSHomeDirectory()];

    if (![[NSFileManager defaultManager]fileExistsAtPath:fileString]) {
        NSError *err = nil;
        if ([[NSFileManager defaultManager] createDirectoryAtPath:fileString withIntermediateDirectories:YES attributes:nil error:&err])
        {
            recordUrl = [NSURL fileURLWithPath:path];
        } else {
            NSLog(@"录音失败");
            return;
        }
    } else {
        recordUrl = [NSURL fileURLWithPath:path];
    }
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *setCategoryError = nil;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&setCategoryError];
    
    if(setCategoryError){
        NSLog(@"%@",[setCategoryError description]);
        return;
    }
    
    recorder = [[AVAudioRecorder alloc]initWithURL:recordUrl settings:recordSetting error:nil];
    recorder.delegate = self;
    [recorder setMeteringEnabled:YES];
    [recorder record];
}

-(void)stopRecordVoice
{
    [recorder stop];
    
    NSLog(@"停止录音");
    AVURLAsset* audioAsset =[AVURLAsset URLAssetWithURL:recordUrl options:nil];
    CMTime audioDuration = audioAsset.duration;
    float audioDurationSeconds =CMTimeGetSeconds(audioDuration);
    
    if (audioDurationSeconds>=1) {
        NSLog(@"录音保存路径%@",recordUrl);
        NSLog(@"录音时长%f",audioDurationSeconds);
    } else {
        NSLog(@"录音时长小于一秒");
    }
}

-(void)cancelRecordVoice
{
    NSLog(@"取消录音");
    [recorder stop];
    if (recordUrl) {
        NSString * recordFilePath = [NSString stringWithFormat:@"%@",recordUrl];
        NSArray * arr = [recordFilePath componentsSeparatedByString:@"/Library/SaveRecord/"];
        if (arr.count == 2) {
            NSString * recordPath = [NSString stringWithFormat:@"%@/Library/SaveRecord/%@",NSHomeDirectory(),arr[1]];
            if ([[NSFileManager defaultManager]fileExistsAtPath:recordPath]) {
                if ([[NSFileManager defaultManager] removeItemAtPath:recordPath error:nil]) {
                    NSLog(@"录音删除成功");
                }
            }
        }
    }
}

@end
