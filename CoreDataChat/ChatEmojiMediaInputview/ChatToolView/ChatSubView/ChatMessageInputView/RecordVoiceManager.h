//
//  RecordVoiceManager.h
//  聊天键盘
//
//  Created by wangguigui on 16/6/1.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordVoiceManager : NSObject

+(RecordVoiceManager *)shareInstance;

-(void)startRecordVoiceWithPath:(NSString *)path;
-(void)stopRecordVoice;
-(void)cancelRecordVoice;

@end
