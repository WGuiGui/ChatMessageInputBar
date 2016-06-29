//
//  ChatEmojiView.h
//  聊天键盘
//
//  Created by wangguigui on 16/5/31.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatEmojiViewDelegate <NSObject>

-(void)chatEmojiViewDeleteEmoji;
-(void)chatEmojiViewSendEmoji;
-(void)chatEmojiViewSelectEmojiViewName:(NSString *)emojiName;

@end

@interface ChatEmojiView : UIView

-(id)initWithFrame:(CGRect)frame;

@property (nonatomic, assign) id<ChatEmojiViewDelegate>delegate;

@end
