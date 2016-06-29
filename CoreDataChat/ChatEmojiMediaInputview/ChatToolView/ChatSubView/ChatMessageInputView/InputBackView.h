//
//  InputBackView.h
//  聊天键盘
//
//  Created by wangguigui on 16/5/30.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputBackViewDelegate <NSObject>

-(void)resetInputSubViewsFrame;
-(void)sendTextMessage:(NSString *)text;

@end

@interface InputBackView : UIView<UITextViewDelegate>

-(id)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) UIButton * RecordBtn;
@property (nonatomic, strong) UIButton * EmojiBtn;
@property (nonatomic, strong) UIButton * MediaBtn;
@property (nonatomic, strong) UIButton * makeRecordBtn;
@property (nonatomic, strong) UITextView * MessageTextView;

@property (nonatomic, assign) BOOL isClickRecordBtn;
@property (nonatomic, assign) BOOL isClickEmojiBtn;
@property (nonatomic, assign) BOOL isClickMediaBtn;

@property (nonatomic, assign) id<InputBackViewDelegate>delegate;

-(void)setSubViewsImage;

@end
