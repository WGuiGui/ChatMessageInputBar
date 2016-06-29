//
//  ChatMessageToolView.m
//  聊天键盘
//
//  Created by wangguigui on 16/6/1.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import "ChatMessageToolView.h"
#import "EmojiViewAndMediaView.h"
#import "InputBackView.h"
#import "EmojiModel.h"

@interface ChatMessageToolView()<InputBackViewDelegate,EmojiViewAndMediaViewDelegate>

@property (nonatomic, strong) EmojiViewAndMediaView * emojiMediaBackView;
@property (nonatomic, strong) InputBackView * inputBack;
@property (nonatomic, assign) CGFloat selfH;
@property (nonatomic, assign) CGFloat inputTextViewH;
@property (nonatomic, assign) CGFloat selfW;
@property (nonatomic, assign) CGFloat keyBoardH;

@end

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

@implementation ChatMessageToolView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _selfH = frame.size.height;
        _selfW = frame.size.width;
        _inputTextViewH = 50;
        
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews
{
    self.inputBack = [[InputBackView alloc]initWithFrame:CGRectMake(0, 0, _selfW, _inputTextViewH)];
    self.inputBack.delegate = self;
    self.inputBack.MessageTextView.textColor = [UIColor blackColor];
    [self addSubview:self.inputBack];
    
    self.emojiMediaBackView = [[EmojiViewAndMediaView alloc]initWithFrame:CGRectMake(0, _inputTextViewH, _selfW, _selfH-_inputTextViewH)];
    self.emojiMediaBackView.delegate = self;
    [self addSubview:self.emojiMediaBackView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 设置输入框和表情视图及多功能视图的frame
-(void)resetInputSubViewsFrame
{
    [self setEmojiAndMediaViewFrame];
}

-(void)dropMessageInputView
{
    CGRect selfFrame = self.frame;
    CGRect EmojiAndMediaFrame = self.emojiMediaBackView.frame;
    CGRect emojiViewFrame = self.emojiMediaBackView.emojiView.frame;
    CGRect mediaViewFrame = self.emojiMediaBackView.mediaView.frame;
    CGRect InputFrame = self.inputBack.frame;
    
    selfFrame.origin.y = screenH-_inputTextViewH;
    EmojiAndMediaFrame.origin.y = _inputTextViewH;
    InputFrame.origin.y = 0;
    emojiViewFrame.origin.y = 0;
    mediaViewFrame.origin.y = 0;
    [UIView animateWithDuration:0.25 animations:^{
       
        [self setFrame:selfFrame];
        [self.emojiMediaBackView.emojiView setFrame:emojiViewFrame];
        [self.emojiMediaBackView.mediaView setFrame:mediaViewFrame];
        [self.inputBack setFrame:InputFrame];
        [self.emojiMediaBackView setFrame:EmojiAndMediaFrame];
        [self endEditing:YES];
    }];
    [self postNotificationForFrame];
}

-(void)setEmojiAndMediaViewFrame
{
    CGRect selfFrame = self.frame;
    CGRect EmojiAndMediaFrame = self.emojiMediaBackView.frame;
    CGRect emojiViewFrame = self.emojiMediaBackView.emojiView.frame;
    CGRect mediaViewFrame = self.emojiMediaBackView.mediaView.frame;
    CGRect InputFrame = self.inputBack.frame;
    if (self.inputBack.isClickRecordBtn) {
        EmojiAndMediaFrame.origin.y = 50;
        InputFrame.origin.y = 0;
        selfFrame.origin.y = screenH-_inputTextViewH;
    } else {
        if (self.inputBack.isClickEmojiBtn || self.inputBack.isClickMediaBtn) {
            InputFrame.origin.y = 0;
            EmojiAndMediaFrame.origin.y = _inputTextViewH;
            selfFrame.origin.y = screenH-_selfH;
            if (self.inputBack.isClickEmojiBtn) {
                emojiViewFrame.origin.y = 0;
                mediaViewFrame.origin.y = EmojiAndMediaFrame.size.height;
            } else if (self.inputBack.isClickMediaBtn) {
                emojiViewFrame.origin.y = EmojiAndMediaFrame.size.height;
                mediaViewFrame.origin.y = 0;
            }
        }
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.inputBack setFrame:InputFrame];
        [self.emojiMediaBackView setFrame:EmojiAndMediaFrame];
        [self.emojiMediaBackView.emojiView setFrame:emojiViewFrame];
        [self.emojiMediaBackView.mediaView setFrame:mediaViewFrame];
        [self setFrame:selfFrame];
    }];
    [self postNotificationForFrame];
}

-(void)postNotificationForFrame
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"InputBarFrameChanged" object:self userInfo:[NSDictionary dictionaryWithObject:[NSValue valueWithCGRect:self.frame] forKey:@"ToolFrame"]];
}

-(void)sendTextMessage:(NSString *)text
{
    [self.delegate sendChatMessage:text];
}

#pragma mark - EmojiAndMediaViewDelegate
-(void)sendEmojiMessage
{
    if (!self.inputBack.MessageTextView.text.length) {
        return;
    }
    [self.delegate sendChatMessage:self.inputBack.MessageTextView.text];
    self.inputBack.MessageTextView.text = nil;
}

-(void)deleteEmojiMessage
{
    if (!self.inputBack.MessageTextView.text.length) {
        return;
    }
    NSMutableArray * emojiNameArray = [NSMutableArray array];
    for (EmojiModel * model in [EmojiModel emojiViewArray]) {
        [emojiNameArray addObject:model.emojiName];
    }
    
    NSMutableString * str = [NSMutableString stringWithString:self.inputBack.MessageTextView.text];
    NSString * tempString3 = [str substringWithRange:NSMakeRange(str.length-3, 3)];
    NSString * tempString4 = [str substringWithRange:NSMakeRange(str.length-4, 4)];
    NSString * tempString5 = [str substringWithRange:NSMakeRange(str.length-5, 5)];
    if (str.length>=5) {
        if ([emojiNameArray containsObject:tempString5]) {
            [str deleteCharactersInRange:NSMakeRange(str.length-5, 5)];
        } else if ([emojiNameArray containsObject:tempString4]){
            [str deleteCharactersInRange:NSMakeRange(str.length-4, 4)];
        } else if ([emojiNameArray containsObject:tempString3]) {
            [str deleteCharactersInRange:NSMakeRange(str.length-3, 3)];
        } else {
            [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
        }
        
    } else if (str.length == 4) {
        if ([emojiNameArray containsObject:tempString4]){
            [str deleteCharactersInRange:NSMakeRange(str.length-4, 4)];
        } else if ([emojiNameArray containsObject:tempString3]) {
            [str deleteCharactersInRange:NSMakeRange(str.length-3, 3)];
        } else {
            [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
        }
    } else if (str.length == 3) {
        if ([emojiNameArray containsObject:tempString3]) {
            [str deleteCharactersInRange:NSMakeRange(str.length-3, 3)];
        } else {
            [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
        }
    } else {
        [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
    }
    self.inputBack.MessageTextView.text = str;
}

-(void)selectEmojiImageWith:(NSString *)emojiName
{
    NSString * messageText = [NSString stringWithFormat:@"%@%@",self.inputBack.MessageTextView.text,emojiName];
    [self.inputBack.MessageTextView setText:messageText];
}

-(void)selectMediaSource:(NSString *)mediaSourceName
{
    if ([mediaSourceName isEqualToString:@"照片"]) {
        
    } else if ([mediaSourceName isEqualToString:@"小视频"]) {
        
    } else if ([mediaSourceName isEqualToString:@"拍照"]) {
        
    } else if ([mediaSourceName isEqualToString:@"视频"]) {
        
    } else if ([mediaSourceName isEqualToString:@"文件"]) {
        
    } else if ([mediaSourceName isEqualToString:@"位置"]) {
        
    }
    NSLog(@"%@",mediaSourceName);
}

#pragma mark - 对键盘的监控
-(void)keyBoardWillShow:(NSNotification *)noti
{
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect selfFrame = self.frame;

    CGRect InputFrame = self.inputBack.frame;
    CGRect EmojiAndMediaFrame = self.emojiMediaBackView.frame;
    InputFrame.origin.y = 0;
    EmojiAndMediaFrame.origin.y = _selfH+_inputTextViewH;
    self.keyBoardH = keyboardFrame.origin.y-_selfH;
    selfFrame.origin.y = keyboardFrame.origin.y-_inputTextViewH;
    [UIView animateWithDuration:0.25 animations:^{
        [self.inputBack setFrame:InputFrame];
        [self.emojiMediaBackView setFrame:EmojiAndMediaFrame];
        [self setFrame:selfFrame];
    }];
}

-(void)keyBoardWillHidden:(NSNotification *)noti
{
    [self setEmojiAndMediaViewFrame];
}

@end
