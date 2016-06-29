//
//  ChatMediaView.m
//  聊天键盘
//
//  Created by wangguigui on 16/5/31.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import "ChatMediaView.h"

@interface ChatMediaView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * mediaCollectionView;
@property (nonatomic, strong) NSMutableArray * mediaArray;

@end

@implementation ChatMediaView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self getMediaArray];
        [self addSubViews];
    }
    return self;
}

-(void)getMediaArray
{
    self.mediaArray = [NSMutableArray array];
    
    NSDictionary * photoDic = [NSDictionary dictionaryWithObject:@"Photo" forKey:@"照片"];
    NSDictionary * videoDic = [NSDictionary dictionaryWithObject:@"Video" forKey:@"视频"];
    NSDictionary * recordVideoDic = [NSDictionary dictionaryWithObject:@"Record_Video" forKey:@"小视频"];
    NSDictionary * DocumentDic = [NSDictionary dictionaryWithObject:@"Documents" forKey:@"文件"];
    NSDictionary * CameraDic = [NSDictionary dictionaryWithObject:@"Camera" forKey:@"拍照"];
    NSDictionary * locationDic = [NSDictionary dictionaryWithObject:@"Location" forKey:@"位置"];
    
    [self.mediaArray addObject:photoDic];
    [self.mediaArray addObject:videoDic];
    [self.mediaArray addObject:recordVideoDic];
    [self.mediaArray addObject:DocumentDic];
    [self.mediaArray addObject:CameraDic];
    [self.mediaArray addObject:locationDic];
}

-(void)addSubViews
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    
    self.mediaCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flow];
    self.mediaCollectionView.showsHorizontalScrollIndicator = NO;
    self.mediaCollectionView.showsVerticalScrollIndicator = NO;
    self.mediaCollectionView.pagingEnabled = YES;
    self.mediaCollectionView.delegate = self;
    self.mediaCollectionView.dataSource = self;
    self.mediaCollectionView.backgroundColor = [UIColor whiteColor];
    [self.mediaCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
    
    [self addSubview:self.mediaCollectionView];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mediaArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];

    NSDictionary * dic = self.mediaArray[indexPath.item];
    
    UIImageView * mediaImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:dic[dic.allKeys[0]]]];
    mediaImageView.frame = CGRectMake((self.frame.size.width/320)*12, 8, cell.contentView.frame.size.width-(self.frame.size.width/320)*24, cell.contentView.frame.size.height-25);
    [cell.contentView addSubview:mediaImageView];
    
    UILabel * mediaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.contentView.frame.size.height-20, cell.contentView.frame.size.width, 20)];
    mediaLabel.font = [UIFont systemFontOfSize:12];
    mediaLabel.textAlignment = NSTextAlignmentCenter;
    mediaLabel.text = dic.allKeys[0];
    [cell.contentView addSubview:mediaLabel];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = self.mediaArray[indexPath.item];
    [self.delegate chatMediaViewSelectMedia:dic.allKeys[0]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.bounds.size.width)/3, (self.bounds.size.height)/2);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
