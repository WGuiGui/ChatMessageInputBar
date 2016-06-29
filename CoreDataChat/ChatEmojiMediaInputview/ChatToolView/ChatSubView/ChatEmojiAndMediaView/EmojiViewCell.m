//
//  EmojiViewCell.m
//  聊天键盘
//
//  Created by wangguigui on 16/5/31.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import "EmojiViewCell.h"

@implementation EmojiViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(EmojiModel *)model
{
    _model = model;
    self.emojiImage.image = [UIImage imageNamed:model.emojiImageViewName];
}

@end
