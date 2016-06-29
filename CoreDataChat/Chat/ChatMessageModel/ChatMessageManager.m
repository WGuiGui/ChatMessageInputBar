//
//  ChatMessageManager.m
//  聊天键盘
//
//  Created by wangguigui on 16/6/2.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import "ChatMessageManager.h"
#import "AppDelegate.h"
#import "Message.h"
#import <CoreData/CoreData.h>

@interface ChatMessageManager()
{
    AppDelegate * app;
}

@end

@implementation ChatMessageManager

-(id)init
{
    self = [ super init];
    if (self) {
        
        app = [UIApplication sharedApplication].delegate;
        self.messageList = [NSMutableArray array];
    }
    return self;
}

-(void)addChatMessage:(NSString *)messageText completion:(void(^)(NSMutableArray *arr))block
{
    Message * msg = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:app.managedObjectContext];
    msg.text = messageText;
    if ([app.managedObjectContext save:nil]) {
        [self.messageList addObject:messageText];
        block(self.messageList);
    }
}

-(void)getChatMessageLists:(void(^)(NSMutableArray *arr))block
{
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Message"];
    NSArray * arr = [app.managedObjectContext executeFetchRequest:request error:nil];
    if (arr.count) {
        for (Message* msg in arr) {
            [self.messageList addObject:msg.text];
        }
    }

    if (self.messageList.count) {
        block(self.messageList);
    } else {
        block(nil);
    }
}

//获取根据row获取一个数组中的model
-(NSString *)getSelectItem:(NSInteger)row section:(NSInteger)section
{
    return self.messageList[row];
}

@end
