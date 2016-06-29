//
//  InputBackView.m
//  聊天键盘
//
//  Created by wangguigui on 16/5/30.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import "InputBackView.h"
#import "RecordVoiceManager.h"
#import "EmojiModel.h"

typedef enum : NSUInteger {
    BtnTypeRecord=100,
    BtnTypeEmoji,
    BtnTypeMedia,
} BtnType;

@implementation InputBackView

#define BtnGap 3
#define BtnW 50

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isClickEmojiBtn = NO;
        self.isClickMediaBtn = NO;
        self.isClickRecordBtn = NO;

        [self addSubViews];
        [self setSubViewsImage];
    }
    return self;
}

-(void)addSubViews
{
    CGFloat SelfW = self.frame.size.width;
    CGFloat SelfH = self.frame.size.height;
    self.backgroundColor = [UIColor purpleColor];
    
    self.RecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.RecordBtn addTarget:self action:@selector(inputButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.RecordBtn.tag = BtnTypeRecord;
    self.RecordBtn.backgroundColor = [UIColor whiteColor];
    self.RecordBtn.frame = CGRectMake(BtnGap, BtnGap, BtnW, SelfH-BtnGap*2);
    
    self.EmojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.EmojiBtn addTarget:self action:@selector(inputButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.EmojiBtn.tag = BtnTypeEmoji;
    self.EmojiBtn.backgroundColor = [UIColor whiteColor];
    self.EmojiBtn.frame = CGRectMake(SelfW-BtnGap*2-BtnW*2, BtnGap, BtnW, SelfH-BtnGap*2);
    
    self.MediaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.MediaBtn addTarget:self action:@selector(inputButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.MediaBtn.tag = BtnTypeMedia;
    self.MediaBtn.backgroundColor = [UIColor whiteColor];
    self.MediaBtn.frame = CGRectMake(SelfW-BtnGap-BtnW, BtnGap, BtnW, SelfH-BtnGap*2);
    
    self.MessageTextView = [[UITextView alloc]initWithFrame:CGRectMake(BtnGap*2+BtnW, BtnGap, SelfW-BtnGap*5-BtnW*3, SelfH-BtnGap*2)];
    self.MessageTextView.delegate = self;
    self.MessageTextView.returnKeyType = UIReturnKeySend;
    self.MessageTextView.backgroundColor = [UIColor lightGrayColor];
    
    self.makeRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.makeRecordBtn.frame = self.MessageTextView.frame;
    [self.makeRecordBtn setTitle:@"开始录音" forState:UIControlStateNormal];
    [self.makeRecordBtn setTitle:@"松开发送" forState:UIControlStateHighlighted];
    [self.makeRecordBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.makeRecordBtn addTarget:self action:@selector(startRecordClick) forControlEvents:UIControlEventTouchDown];
    [self.makeRecordBtn addTarget:self action:@selector(stopRecordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.makeRecordBtn addTarget:self action:@selector(cancelRecordClick) forControlEvents:UIControlEventTouchUpOutside];
    self.makeRecordBtn.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.MessageTextView];
    [self addSubview:self.makeRecordBtn];
    [self addSubview:self.RecordBtn];
    [self addSubview:self.EmojiBtn];
    [self addSubview:self.MediaBtn];
    
    self.makeRecordBtn.hidden = YES;
    
    for (UIView * view in self.subviews) {
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 3;
    }
}

-(void)setSubViewsImage
{
    if (self.isClickRecordBtn) {
        [self.RecordBtn setImage:[UIImage imageNamed:@"Keyboard_Normal"] forState:UIControlStateNormal];
        [self.RecordBtn setImage:[UIImage imageNamed:@"Keyboard_Hightlighted"] forState:UIControlStateHighlighted];
    } else {
        [self.RecordBtn setImage:[UIImage imageNamed:@"Voice_Normal"] forState:UIControlStateNormal];
        [self.RecordBtn setImage:[UIImage imageNamed:@"Voice_Hightlighted"] forState:UIControlStateHighlighted];
    }
    if (self.isClickEmojiBtn) {
        [self.EmojiBtn setImage:[UIImage imageNamed:@"Keyboard_Normal"] forState:UIControlStateNormal];
        [self.EmojiBtn setImage:[UIImage imageNamed:@"Keyboard_Hightlighted"] forState:UIControlStateHighlighted];
    } else {
        [self.EmojiBtn setImage:[UIImage imageNamed:@"Emoji_Btn_Normal"] forState:UIControlStateNormal];
        [self.EmojiBtn setImage:[UIImage imageNamed:@"Emoji_Btn_Hightlighted"] forState:UIControlStateHighlighted];
    }
    if (self.isClickMediaBtn) {
        [self.MediaBtn setImage:[UIImage imageNamed:@"Keyboard_Normal"] forState:UIControlStateNormal];
        [self.MediaBtn setImage:[UIImage imageNamed:@"Keyboard_Hightlighted"] forState:UIControlStateHighlighted];
    } else {
        [self.MediaBtn setImage:[UIImage imageNamed:@"Accessory_Normal"] forState:UIControlStateNormal];
        [self.MediaBtn setImage:[UIImage imageNamed:@"Accessory_Hightlighted"] forState:UIControlStateHighlighted];
    }
}

#pragma mark - 录音
-(void)startRecordClick
{
    [[RecordVoiceManager shareInstance] startRecordVoiceWithPath:[NSString stringWithFormat:@"%@/Library/SaveRecord/wff.aac",NSHomeDirectory()]];
}

-(void)stopRecordClick
{
    [[RecordVoiceManager shareInstance] stopRecordVoice];
}

-(void)cancelRecordClick
{
    [[RecordVoiceManager shareInstance] cancelRecordVoice];
}

-(void)inputButtonClick:(UIButton *)btn
{
    switch (btn.tag) {
        case BtnTypeRecord:
            self.isClickEmojiBtn = NO;
            self.isClickMediaBtn = NO;
            self.isClickRecordBtn = !self.isClickRecordBtn;
            self.makeRecordBtn.hidden = !self.isClickRecordBtn;
            break;
        case BtnTypeEmoji:
            self.isClickRecordBtn = NO;
            self.isClickMediaBtn = NO;
            self.makeRecordBtn.hidden = YES;
            self.isClickEmojiBtn = !self.isClickEmojiBtn;
            break;
        case BtnTypeMedia:
            self.isClickRecordBtn = NO;
            self.isClickEmojiBtn = NO;
            self.makeRecordBtn.hidden = YES;
            self.isClickMediaBtn = !self.isClickMediaBtn;
            break;
        default:
            break;
    }
    if (self.isClickRecordBtn || self.isClickEmojiBtn || self.isClickMediaBtn) {
        [self.MessageTextView resignFirstResponder];
    } else {
        [self.MessageTextView becomeFirstResponder];
    }

    [self setSubViewsImage];
    [self.delegate resetInputSubViewsFrame];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.isClickRecordBtn = NO;
    self.isClickEmojiBtn = NO;
    self.isClickMediaBtn = NO;
    self.makeRecordBtn.hidden = YES;
    
    [self.delegate resetInputSubViewsFrame];
    [self setSubViewsImage];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if (self.MessageTextView.text.length) {
            [self.delegate sendTextMessage:self.MessageTextView.text];
            self.MessageTextView.text = nil;
            return NO;
        } else {
            return NO;
        }
    } else {
        if (text.length == 0) {
            [self deleteMessageText];
            return YES;
        } else {
            if (self.MessageTextView.text.length>300) {
                self.MessageTextView.text = [self.MessageTextView.text substringToIndex:300];
                NSLog(@"超过规定的字数");
                return NO;
            } else {
                return YES;
            }
            return YES;
        }
    }
}

-(void)deleteMessageText
{
    NSMutableArray * emojiArray = [EmojiModel emojiViewArray];
    NSMutableArray * emojiNameArr = [NSMutableArray array];
    for (EmojiModel * model in emojiArray) {
        [emojiNameArr addObject:model.emojiName];
    }
    
    NSMutableString * messageTextString = [NSMutableString stringWithString:self.MessageTextView.text];
    if (messageTextString.length && [[messageTextString substringWithRange:NSMakeRange(messageTextString.length-1, 1)] isEqualToString:@"]"]) {
        if (messageTextString.length>=5) {
            
            NSString * subStr5 = [messageTextString substringFromIndex:messageTextString.length-5];
            NSString * subStr4 = [messageTextString substringFromIndex:messageTextString.length-4];
            NSString * subStr3 = [messageTextString substringFromIndex:messageTextString.length-3];
            if ([subStr5 hasPrefix:@"["] && [emojiNameArr containsObject:subStr5]) {
                [messageTextString deleteCharactersInRange:NSMakeRange(messageTextString.length-5, 4)];
            } else if ([subStr4 hasPrefix:@"["] && [emojiNameArr containsObject:subStr4]){
                [messageTextString deleteCharactersInRange:NSMakeRange(messageTextString.length-4, 3)];
            } else if ([subStr3 hasPrefix:@"["] && [emojiNameArr containsObject:subStr3]) {
                [messageTextString deleteCharactersInRange:NSMakeRange(messageTextString.length-3, 2)];
            } else {
                [messageTextString deleteCharactersInRange:NSMakeRange(messageTextString.length-1, 1)];
            }
            
        } else if (messageTextString.length>=4) {
            NSString * subStr4 = [messageTextString substringFromIndex:messageTextString.length-4];
            NSString * subStr3 = [messageTextString substringFromIndex:messageTextString.length-3];
            if ([subStr4 hasPrefix:@"["] && [emojiNameArr containsObject:subStr4]) {
                [messageTextString deleteCharactersInRange:NSMakeRange(messageTextString.length-4, 3)];
            } else if([subStr3 hasPrefix:@"["] && [emojiNameArr containsObject:subStr3]){
                [messageTextString deleteCharactersInRange:NSMakeRange(messageTextString.length-3, 2)];
            } else {
                [messageTextString deleteCharactersInRange:NSMakeRange(messageTextString.length-1, 1)];
            }
        } else if (messageTextString.length>=3) {
            NSString * subStr3 = [messageTextString substringFromIndex:messageTextString.length-3];
            if ([subStr3 hasPrefix:@"["] && [emojiNameArr containsObject:subStr3]) {
                [messageTextString deleteCharactersInRange:NSMakeRange(messageTextString.length-3, 2)];
            } else {
                [messageTextString deleteCharactersInRange:NSMakeRange(messageTextString.length-1, 1)];
            }
        } else{
            [messageTextString deleteCharactersInRange:NSMakeRange(messageTextString.length-1, 1)];
        }
    }
    
    self.MessageTextView.text = messageTextString;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
