//
//  ChatViewController.m
//  聊天键盘
//
//  Created by wangguigui on 16/6/2.
//  Copyright © 2016年 topsci. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatMessageToolView.h"
#import "ChatMessageManager.h"

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,ChatMessageToolViewDelegate>

@property (nonatomic, strong) UITableView * chatTableView;
@property (nonatomic, strong) NSMutableArray * chatLists;
@property (nonatomic, strong) ChatMessageToolView * toolView;
@property (nonatomic, strong) ChatMessageManager* manager;

@end

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

@implementation ChatViewController

-(NSMutableArray *)chatLists
{
    if (!_chatLists) {
        _chatLists = [NSMutableArray array];
    }
    return _chatLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"聊天";
    self.manager = [[ChatMessageManager alloc]init];
    
    [self getChatList];
    [self createChatTableView];
    [self addChatMessageToolView];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toolViewFrame:) name:@"InputBarFrameChanged" object:self.toolView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"InputBarFrameChanged" object:self.toolView];
}

-(void)addNewMessage
{
    __block UITableView * selfTableView = self.chatTableView;
    [self.manager addChatMessage:@"自动添加的消息sdlkvjklsjadkfj" completion:^(NSMutableArray *arr) {
        [selfTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.manager.messageList.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [selfTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.manager.messageList.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }];
}

-(void)addChatMessageToolView
{
    self.toolView = [[ChatMessageToolView alloc]initWithFrame:CGRectMake(0, screenH-50, screenW, 150+50)];
    self.toolView.delegate = self;
    [self.view addSubview:self.toolView];
}

-(void)toolViewFrame:(NSNotification *)noti
{
    CGRect toolViewFrame = [noti.userInfo[@"ToolFrame"] CGRectValue];
    CGRect frame = self.chatTableView.frame;
    
    frame.origin.y = 64;
    frame.size.height = CGRectGetMinY(toolViewFrame)-64;

    [UIView animateWithDuration:0.25 animations:^{
    
        [self.chatTableView setFrame:frame];
        if (self.manager.messageList.count) {
            [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.manager.messageList.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }];
}

-(void)sendChatMessage:(NSString *)text
{
    NSLog(@"要发送的消息是___%@",text);
    __block UITableView * selfTableView = self.chatTableView;
    [self.manager addChatMessage:text completion:^(NSMutableArray *arr) {
        [selfTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.manager.messageList.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [selfTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.manager.messageList.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }];
}

-(void)createChatTableView
{
    self.chatTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screenW, screenH-50-64) style:UITableViewStylePlain];
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    self.chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.chatTableView];
    if (self.manager.messageList.count) {
        [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.manager.messageList.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

-(void)getChatList
{
    [self.manager getChatMessageLists:^(NSMutableArray *arr) {
        if (arr.count) {
            [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.manager.messageList.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.manager.messageList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.manager.messageList[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = [self.manager getSelectItem:indexPath.row section:indexPath.section];
    NSLog(@"选中了%@",str);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.toolView.frame.origin.y<screenH-50) {
        [self.toolView dropMessageInputView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
