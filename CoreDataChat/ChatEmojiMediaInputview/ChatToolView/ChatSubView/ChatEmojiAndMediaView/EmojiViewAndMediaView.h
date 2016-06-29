//
//  EmojiViewAndMediaView.h
//  聊天键盘
//
//  Created by wangguigui on 16/5/30.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatEmojiView.h"
#import "ChatMediaView.h"

@protocol EmojiViewAndMediaViewDelegate <NSObject>

-(void)sendEmojiMessage;
-(void)deleteEmojiMessage;
-(void)selectEmojiImageWith:(NSString *)emojiName;
-(void)selectMediaSource:(NSString *)mediaSourceName;

@end

@interface EmojiViewAndMediaView : UIView<ChatEmojiViewDelegate,ChatMediaViewDelegate>

-(id)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) ChatEmojiView * emojiView;
@property (nonatomic, strong) ChatMediaView * mediaView;

@property (nonatomic, assign) id<EmojiViewAndMediaViewDelegate>delegate;

@end
