//
//  ChatMessageBaseModel.m
//  聊天键盘
//
//  Created by wangguigui on 16/6/2.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import "ChatMessageBaseModel.h"

@implementation ChatMessageBaseModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"UndefinedKey____%@",key);
}

@end
