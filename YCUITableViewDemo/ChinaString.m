//
//  ChinaString.m
//  YCUITableViewDemo
//
//  Created by 岳琛 on 15/9/13.
//  Copyright (c) 2015年 岳琛. All rights reserved.
//

#import "ChinaString.h"

@implementation ChinaString



//过滤指定字符串  里面的制定字符根据自己需要添加
+(NSString *)RemoveSpecialCharacter:(NSString *)str
{
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、 ~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€"]];
    if (urgentRange.location != NSNotFound)
    {
        return [self RemoveSpecialCharacter:[str stringByReplacingCharactersInRange:urgentRange withString:@""]];
    }
    return str;
}


//返回排序好的字符拼音
+(NSMutableArray *)ReturnSortChineseArray:(NSArray *)stringArr
{
    //获取字符串中 文字的首字母拼音 与字符串共同存放
    NSMutableArray * chineseStringArray=[NSMutableArray array];
    for (int i = 0 ; i<[stringArr count]; i++)
    {
        ChinaString * chinaString=[[ChinaString alloc]init];
        chinaString.string=[NSString stringWithString:[stringArr objectAtIndex:i]];
        
        if (chinaString.string == nil)
        {
            chinaString.string=@"";
        }
        
        //去除空格和回车
        chinaString.string=[chinaString.string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //递归过滤指定字符串  RemoveSpecialCharacter
        chinaString.string=[ChinaString RemoveSpecialCharacter:chinaString.string];
        
        //判断首字符是否为字母
        NSString * regex=@"[A-Za-z]";
        NSPredicate * predicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        if ([predicate evaluateWithObject:chinaString.string])
        {
            //首字母大写
            chinaString.pinYin=[chinaString.string uppercaseString];
            
        }
        else
        {
            if (![chinaString.string isEqualToString:@""])
            {
                NSString *pinYinResult=[NSString string];
                for(int j=0;j<chinaString.string.length;j++)
                {
                    NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chinaString.string characterAtIndex:j])]uppercaseString];
                    
                    pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
                }
                chinaString.pinYin=pinYinResult;
            }
            else
            {
                chinaString.pinYin=@"";
            }
        }
        [chineseStringArray addObject:chinaString];
        
    }
    
    //按照拼音首字母对string
    //按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringArray sortUsingDescriptors:sortDescriptors];
    return chineseStringArray;
    
}





#pragma mark - 返回索引
+(NSMutableArray *)IndexArray:(NSArray *)stringArr
{
    NSMutableArray *tempArray = [self ReturnSortChineseArray:stringArr];
    NSMutableArray *A_Result=[NSMutableArray array];
    NSString *tempString ;
    
    for (NSString* object in tempArray)
    {
        NSString *pinyin = [((ChinaString*)object).pinYin substringToIndex:1];
        //不同
        if(![tempString isEqualToString:pinyin])
        {
             NSLog(@"IndexArray----->%@",pinyin);
            [A_Result addObject:pinyin];
            tempString = pinyin;
        }
    }
    return A_Result;

}



#pragma mark - 返回联系人
+(NSMutableArray *)LetterSortArray:(NSArray *)stringArr
{
    NSMutableArray *tempArray = [self ReturnSortChineseArray:stringArr];
    NSMutableArray *LetterResult=[NSMutableArray array];
    NSMutableArray *item = [NSMutableArray array];
    NSString *tempString ;
    //拼音分组
    for (NSString* object in tempArray) {
        
        NSString *pinyin = [((ChinaString*)object).pinYin substringToIndex:1];
        NSString *string = ((ChinaString*)object).string;
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            //分组
            item = [NSMutableArray array];
            [item  addObject:string];
            [LetterResult addObject:item];
            //遍历
            tempString = pinyin;
        }else//相同
        {
            [item  addObject:string];
        }
    }
    return LetterResult;

}



#pragma mark - 返回字母排序后的数组
+(NSMutableArray *)SortArray:(NSArray *)stringArr
{
    NSMutableArray *tempArray = [self ReturnSortChineseArray:stringArr];
    
    //把排序好的内容从ChineseString类中提取出来
    NSMutableArray *result=[NSMutableArray array];
    for(int i=0;i<[stringArr count];i++)
    {
        [result addObject:((ChinaString*)[tempArray objectAtIndex:i]).string];
        NSLog(@"SortArray----->%@",((ChinaString*)[tempArray objectAtIndex:i]).string);
    }
    return result;

}




@end
