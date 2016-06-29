//
//  ChatEmojiView.m
//  聊天键盘
//
//  Created by wangguigui on 16/5/31.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import "ChatEmojiView.h"
#import "EmojiViewCell.h"
#import "EmojiModel.h"

@interface ChatEmojiView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * emojiCollectionView;
@property (nonatomic, strong) NSMutableArray * emojiArray;
@property (nonatomic, strong) UIButton * deleteEmojiBtn;
@property (nonatomic, strong) UIButton * sendEmojiBtn;
@property (nonatomic, strong) UIPageControl * pageControl;

@end

@implementation ChatEmojiView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews
{
    self.emojiArray = [EmojiModel emojiViewArray];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height-40);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    
    self.emojiCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-40) collectionViewLayout:flow];
    self.emojiCollectionView.showsHorizontalScrollIndicator = NO;
    self.emojiCollectionView.showsVerticalScrollIndicator = NO;
    self.emojiCollectionView.pagingEnabled = YES;
    self.emojiCollectionView.delegate = self;
    self.emojiCollectionView.dataSource = self;
    self.emojiCollectionView.backgroundColor = [UIColor whiteColor];
    [self.emojiCollectionView registerNib:[UINib nibWithNibName:@"EmojiViewCell" bundle:nil] forCellWithReuseIdentifier:@"EMOJICELLID"];
    [self addSubview:self.emojiCollectionView];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(100, self.frame.size.height-40, self.frame.size.width-200, 40)];
    self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.currentPage = 0;
    self.pageControl.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.pageControl];
    
    self.sendEmojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendEmojiBtn.frame = CGRectMake(self.frame.size.width-50, self.frame.size.height-40, 50, 40);
    [self.sendEmojiBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendEmojiBtn addTarget:self action:@selector(sendEmojiClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sendEmojiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.sendEmojiBtn];
    
    self.deleteEmojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteEmojiBtn.frame = CGRectMake(self.frame.size.width-50-50, self.frame.size.height-40, 50, 40);
    [self.deleteEmojiBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteEmojiBtn addTarget:self action:@selector(deleteEmojiClick) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteEmojiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.deleteEmojiBtn];
}

-(void)sendEmojiClick
{
    [self.delegate chatEmojiViewSendEmoji];
}

-(void)deleteEmojiClick
{
    [self.delegate chatEmojiViewDeleteEmoji];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.emojiArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EmojiViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EMOJICELLID" forIndexPath:indexPath];
    cell.model = self.emojiArray[indexPath.item];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EmojiViewCell * cell = (EmojiViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.delegate chatEmojiViewSelectEmojiViewName:cell.model.emojiName];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int wnum = 12;
    int hnum = self.emojiCollectionView.frame.size.height/((self.bounds.size.width)/12);
    int contentw = wnum*hnum;
    self.pageControl.numberOfPages = self.emojiArray.count/contentw+1;

    return CGSizeMake((self.bounds.size.width)/12, (self.bounds.size.width)/12);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float number = (scrollView.contentOffset.x)/scrollView.bounds.size.width;
    self.pageControl.currentPage = (int)ceilf(number);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
