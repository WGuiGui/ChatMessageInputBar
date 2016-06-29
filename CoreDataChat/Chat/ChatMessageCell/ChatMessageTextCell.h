//
//  ChatMessageTextCell.h
//  聊天键盘
//
//  Created by wangguigui on 16/6/2.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatMessageTextCell : UITableViewCell

@property (nonatomic, strong) UILabel * nickNameLabel;
@property (nonatomic, strong) UIImageView * avatarImageView;

@property (nonatomic, strong) UILabel * textMsgLabel;

@end