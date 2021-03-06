//
//  ViewController.m
//  JTYYTextTestDemo
//
//  Created by wangjintao on 2019/4/5.
//  Copyright © 2019年 wangjintao. All rights reserved.
//

#import "ViewController.h"
#import "EHTPostController.h"
#import "ControllerA.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    [self addObserver];
    
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    self.navigationController.na.vigationBar.hidden= YES;
//    self.fd_prefersNavigationBarHidden = YES;
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//}
- (void)setupSubviews{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"asdfasdf"];
    
    [self.view sendSubviewToBack:self.tableView];
    
}
- (IBAction)didClickPushButton:(UIButton *)sender {
    
    [self.navigationController pushViewController:[ControllerA new] animated:YES];
}

- (void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivedPostSuccessNoti:) name:EHTPostSuccessNotificationName object:nil];
}
- (void)didReceivedPostSuccessNoti:(NSNotification *)noti{
    NSDictionary *dict = noti.userInfo;
    [self.dataArr addObject:dict];
    [self.tableView reloadData];
    NSLog(@"%@",dict);
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"asdfasdf" forIndexPath:indexPath];
    NSDictionary *dict = self.dataArr[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    return cell;
}

- (IBAction)didClickPost:(UIButton *)sender {
    
    [self.navigationController pushViewController:[EHTPostController new] animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
