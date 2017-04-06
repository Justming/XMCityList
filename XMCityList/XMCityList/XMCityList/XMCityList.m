//
//  XMCityList.m
//  XMCityList
//
//  Created by hxm on 2017/4/6.
//  Copyright © 2017年 hxm. All rights reserved.
//

#import "XMCityList.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XMCityList ()

@property (nonatomic, assign) CGFloat leading;          //屏幕留白宽度
@property (nonatomic, assign) CGFloat margin;           //label内边距
@property (nonatomic, assign) CGFloat itemSpace;        //label列间距
@property (nonatomic, assign) CGFloat lineSpace;        //行间距
@property (nonatomic, strong) UIFont * font;            //字体
@property (nonatomic, strong) UIColor * textColor;      //字体颜色
@property (nonatomic, strong) UIColor * borderColor;    //边框颜色
@property (nonatomic, strong) UIColor * bgColor;        //label背景颜色
@property (nonatomic, assign) CGFloat borderWidth;      //边框宽度


@end


@implementation XMCityList

- (instancetype)init{
    
    if (self = [super init]) {
        _leading = 10;
        _margin = 20;
        _itemSpace = 10;
        _lineSpace = 10;
        _font = [UIFont systemFontOfSize:12];
        _textColor = [UIColor lightGrayColor];
        _borderColor = [UIColor lightGrayColor];
        _bgColor = [UIColor whiteColor];
        _borderWidth = 1;
        
    }
    return self;
}

/**
 通过城市名称来创建一个视图,默认为全屏宽，起始点为（0，0）
 @param array 城市名称数组
 @return 城市列表view
 */
- (UIView *)getCityViewByArray:(NSArray *)array{
    
    UIView * cityView = [UIView new];
    
    CGFloat lastX = _leading;
    CGFloat lastY = _leading;
    for (int i=0; i<array.count; i++) {
        
        UILabel * label = [self createLabelByContent:array[i]];
        label.tag = i;
        
        if (lastX+label.bounds.size.width > WIDTH-_leading ) {
            
            lastX = _leading;
            lastY = lastY + CGRectGetHeight(label.frame) + _lineSpace;
            label.frame = CGRectMake(lastX, lastY, label.bounds.size.width, label.bounds.size.height);
            
        }else{
            
            label.frame = CGRectMake(lastX, lastY, label.bounds.size.width, label.bounds.size.height);
        }
        lastX = CGRectGetMaxX(label.frame) + _itemSpace;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem:)];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
        
        [cityView addSubview:label];
    }
    
    cityView.frame = CGRectMake(0, 0, WIDTH, lastY+_leading*2);

    return cityView;
}



/**
 适用于在cell中添加，每一个一维数组代表一行，一维数组中存放的是label，直接添加到cell中即可
 
 @param array c
 @return 返回二维数组，
 */
- (NSArray *)getCellArrayByArray:(NSArray *)array{
    
    NSMutableArray * cellArray = [NSMutableArray new];
    NSMutableArray * labelArray = [NSMutableArray new];
    int j = 0;
    CGFloat lastX = 0;
    for (int i=0; i<array.count; i++) {
        
        UILabel * label = [self createLabelByContent:array[i]];
        
        if (lastX+_itemSpace+label.bounds.size.width >WIDTH-_leading ) {
            j = 0;
            i--;
            lastX = 0;
            [cellArray addObject:labelArray];
            labelArray = [NSMutableArray new];
            continue;
        }
        label.frame = CGRectMake(lastX+_itemSpace, _lineSpace, label.bounds.size.width, label.bounds.size.height);
        lastX = CGRectGetMaxX(label.frame);
        j++;
        label.tag = i;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem:)];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
        [labelArray addObject:label];
        if (i == array.count-1) {
            [cellArray addObject:labelArray];
        }
        
    }
    return cellArray;
    
}

/**
 通过content来创建label
 @param content label的内容
 @return label
 */
- (UILabel *)createLabelByContent:(NSString *)content{
    
    UILabel * label = [UILabel new];
    label.textColor = _textColor;
    label.font = _font;
    label.text = content;
    [label sizeToFit];
    
    label.layer.borderColor = _borderColor.CGColor;
    label.layer.borderWidth = _borderWidth;
    label.layer.cornerRadius = 3;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = _bgColor;
    label.frame = CGRectMake(0, 0, label.bounds.size.width+_margin, label.bounds.size.height+_margin);
    
    return label;
}

- (void)tapItem:(UITapGestureRecognizer *)tap{
    
    [self.delegate cityItemClicked:tap.view.tag];
}


@end
