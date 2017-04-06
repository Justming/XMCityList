//
//  ViewController.m
//  XMCityList
//
//  Created by hxm on 2017/4/6.
//  Copyright © 2017年 hxm. All rights reserved.
//

#import "ViewController.h"
#import "XMCityList.h"


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,XMCityListDelegate>

@end

@implementation ViewController
{
    
    NSArray * _cityArray;
    XMCityList * _cityList;
    UITableView * _tableView;
    NSArray * _dataSource;
    
    UIScrollView * _scroll;
}

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}


- (void)createUI{
    _cityList = [[XMCityList alloc] init];
    _cityList.delegate = self;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT/2-20)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _cityArray = @[@"黑龙江省",  @"吉林省",  @"辽宁省",  @"北京市",  @"内蒙古自治区",  @"新疆自治区", @"甘肃省",
                  @"天津市", @"河北省",  @"宁夏自治区",  @"青海省",  @"江苏省",  @"河南省",  @"陕西省",  @"上海市",
                  @"西藏自治区",  @"安徽省",  @"湖北省",  @"四川省",  @"重庆市",  @"浙江省",   @"江西省",  @"湖南省",
                  @"贵州省",  @"福建省",  @"云南省",  @"广西自治区", @"广东省", @"山西省",  @"山东省",  @"海南省"];
    _dataSource = [_cityList getCellArrayByArray:_cityArray];
    
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HEIGHT/2, WIDTH, HEIGHT/2)];
    UIView * cityView = [_cityList getCityViewByArray:_cityArray];
    [_scroll addSubview:cityView];
    
    _scroll.contentSize = CGSizeMake(WIDTH, cityView.frame.size.height+20);
    [self.view addSubview:_scroll];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView * sub in cell.contentView.subviews) {
        [sub removeFromSuperview];
    }
    
    for (UILabel * label in _dataSource[indexPath.row]) {
        [cell.contentView addSubview:label];
    }
    
    return cell;
}
#pragma mark - 代理方法，点击事件
- (void)cityItemClicked:(NSInteger)index{
    NSLog(@"你点击了%@", _cityArray[index]);
}

@end
