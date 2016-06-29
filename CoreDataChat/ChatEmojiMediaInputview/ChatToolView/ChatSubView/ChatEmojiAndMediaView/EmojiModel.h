//
//  EmojiModel.h
//  聊天键盘
//
//  Created by wangguigui on 16/5/31.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmojiModel : NSObject

@property (nonatomic, strong) NSString * emojiName;
@property (nonatomic, strong) NSString * emojiImageViewName;

+ (NSMutableArray*)emojiViewArray;

@end
