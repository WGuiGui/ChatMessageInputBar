//
//  ChatMessageToolView.h
//  聊天键盘
//
//  Created by wangguigui on 16/6/1.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatMessageToolViewDelegate <NSObject>

-(void)sendChatMessage:(NSString *)text;

@end

@interface ChatMessageToolView : UIView

@property (nonatomic, assign) id<ChatMessageToolViewDelegate>delegate;

-(id)initWithFrame:(CGRect)frame;
-(void)resetInputSubViewsFrame;
-(void)dropMessageInputView;


@end
