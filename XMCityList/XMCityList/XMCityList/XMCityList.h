//
//  XMCityList.h
//  XMCityList
//
//  Created by hxm on 2017/4/6.
//  Copyright © 2017年 hxm. All rights reserved.
//

/*
 
    使用方法很简单
    1.导入头文件
    2.创建对象
    3.调用下面的对象方法得到view或数组
    4.添加到指定视图中即可
    5.若要获取点击事件，请设置代理并重写代理方法
 
    github地址：https://github.com/Justming/XMCityList.git
 
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol XMCityListDelegate <NSObject>

//点击item事件  index为item的tag值
- (void)cityItemClicked:(NSInteger)index;

@end

@interface XMCityList : NSObject

@property (nonatomic, strong) id <XMCityListDelegate> delegate;



//通过城市名称数组创建view
- (UIView *)getCityViewByArray:(NSArray *)array;

//通过城市名称数组创建二维数组，可用于在cell中添加视图，每个一维数组中存放的是一个cell的数据源，把其中的所有cell直接添加到cell中即可，不过这种情况不太常用，兴趣使然写了一下
- (NSArray *)getCellArrayByArray:(NSArray *)array;



@end
