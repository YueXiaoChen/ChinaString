//
//  ChinaString.h
//  YCUITableViewDemo
//
//  Created by 岳琛 on 15/9/13.
//  Copyright (c) 2015年 岳琛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"

@interface ChinaString : NSObject
@property (nonatomic,copy)NSString * string;
@property (nonatomic,copy)NSString * pinYin;


//返回indexArray
+(NSMutableArray *)IndexArray:(NSArray *)stringArr;


//返回联系人
+(NSMutableArray *)LetterSortArray:(NSArray *)stringArr;


//返回排序后的数组
+(NSMutableArray *)SortArray:(NSArray *)stringArr;


@end
