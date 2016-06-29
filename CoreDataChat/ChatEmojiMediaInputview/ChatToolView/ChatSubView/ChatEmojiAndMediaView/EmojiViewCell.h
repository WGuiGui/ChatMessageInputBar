//
//  EmojiViewCell.h
//  聊天键盘
//
//  Created by wangguigui on 16/5/31.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmojiModel.h"

@interface EmojiViewCell : UICollectionViewCell

@property (nonatomic, strong) EmojiModel * model;
@property (nonatomic, weak) IBOutlet UIImageView * emojiImage;

@end
