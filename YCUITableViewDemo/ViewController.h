//
//  ViewController.h
//  YCUITableViewDemo
//
//  Created by 岳琛 on 15/9/13.
//  Copyright (c) 2015年 岳琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *indexArray;
//设置每个section下的cell内容
@property(nonatomic,strong)NSMutableArray *LetterResultArr;

@end

