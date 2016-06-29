//
//  ChatMediaView.h
//  聊天键盘
//
//  Created by wangguigui on 16/5/31.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatMediaViewDelegate <NSObject>

-(void)chatMediaViewSelectMedia:(NSString *)mediaName;

@end

@interface ChatMediaView : UIView

-(id)initWithFrame:(CGRect)frame;

@property (nonatomic, assign) id<ChatMediaViewDelegate>delegate;

@end
