//
//  ChatMessageBaseModel.h
//  聊天键盘
//
//  Created by wangguigui on 16/6/2.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMessageBaseModel : NSObject

@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSString * AvatarName;
@property (nonatomic, strong) NSString * messageText;
@property (nonatomic, strong) NSString * messageImageThumbnailPath;
@property (nonatomic, strong) NSString * messageImageOriginalPath;

@property (nonatomic, strong) NSString * messageVideoThumbnailPath;
@property (nonatomic, strong) NSString * messageVideoPath;

@property (nonatomic, strong) NSString * messageVoicePath;

@property (nonatomic, strong) NSString * messageLocationName;

@end
