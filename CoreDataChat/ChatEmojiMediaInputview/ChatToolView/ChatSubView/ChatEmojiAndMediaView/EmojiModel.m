//
//  EmojiModel.m
//  聊天键盘
//
//  Created by wangguigui on 16/5/31.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import "EmojiModel.h"

@implementation EmojiModel

+ (NSMutableArray*)emojiViewArray
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"expressionImage_custom" ofType:@"plist"];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSMutableArray * array = [NSMutableArray array];
    
    for(NSString *key in [dic allKeys])
    {
        NSMutableDictionary * subDic = [NSMutableDictionary dictionary];
        subDic[key] = [dic objectForKey:key];
        EmojiModel * model = [[EmojiModel alloc]init];
        model.emojiName = key;
        model.emojiImageViewName = subDic[key];
        [array addObject:model];
    }
    
    return array;
}

@end
