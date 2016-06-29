//
//  ChatMessageManager.h
//  聊天键盘
//
//  Created by wangguigui on 16/6/2.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMessageManager : NSObject

@property (nonatomic, strong) NSMutableArray * messageList;

-(id)init;

-(void)getChatMessageLists:(void(^)(NSMutableArray *arr))block;
-(void)addChatMessage:(NSString *)messageText completion:(void(^)(NSMutableArray *arr))block;
-(NSString *)getSelectItem:(NSInteger)row section:(NSInteger)section;

@end
