//
//  EmojiViewAndMediaView.m
//  聊天键盘
//
//  Created by wangguigui on 16/5/30.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import "EmojiViewAndMediaView.h"

@implementation EmojiViewAndMediaView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addEmojiViewAndMediaView];
    }
    return self;
}

-(void)addEmojiViewAndMediaView
{
    self.emojiView = [[ChatEmojiView alloc]initWithFrame:self.bounds];
    self.emojiView.delegate = self;
    [self addSubview:self.emojiView];
    
    self.mediaView = [[ChatMediaView alloc]initWithFrame:self.bounds];
    self.mediaView.delegate = self;
    [self addSubview:self.mediaView];
}

-(void)chatEmojiViewSendEmoji
{
    [self.delegate sendEmojiMessage];
}

-(void)chatEmojiViewDeleteEmoji
{
    [self.delegate deleteEmojiMessage];
}

-(void)chatEmojiViewSelectEmojiViewName:(NSString *)emojiName
{
    [self.delegate selectEmojiImageWith:emojiName];
}

-(void)chatMediaViewSelectMedia:(NSString *)mediaName
{
    [self.delegate selectMediaSource:mediaName];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
