//
//  DBManager.m
//  BaiKe
//
//  Created by yons on 13-8-6.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"

@implementation DBManager

-(NSArray *)quaryKeywordAndDescription{
    NSMutableArray *array = [NSMutableArray array];
  FMDatabase *db = [FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"DB" ofType:@"sqlite"]];
    //    db= [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        return nil;
    }
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM keyword"];
    rs = [db executeQuery:@"SELECT * FROM keyword"];
    while ([rs next]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dic setValue:[rs stringForColumn:@"title"] forKey:@"title"];
        [dic setValue:[rs stringForColumn:@"content"] forKey:@"content"];
        [array addObject:dic];
        NSLog(@"%@ %@", [dic objectForKey:@"ID"], [rs stringForColumn:@"title"]);
    }
    [rs close];
    return array;
}
-(NSArray *)quaryQuestionAndDescription{
    NSMutableArray *array = [NSMutableArray array];
    FMDatabase *db = [FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"DB" ofType:@"sqlite"]];
    //    db= [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        return nil;
    }
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM question"];
    rs = [db executeQuery:@"SELECT * FROM question"];
    while ([rs next]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dic setValue:[rs stringForColumn:@"title"] forKey:@"title"];
        [dic setValue:[rs stringForColumn:@"content"] forKey:@"content"];
        [array addObject:dic];
        NSLog(@"%@ %@", [dic objectForKey:@"ID"], [rs stringForColumn:@"title"]);
    }
    [rs close];
    return array;
}
-(NSArray *)quaryCompanyAndDescription{
    NSMutableArray *array = [NSMutableArray array];
    FMDatabase *db = [FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"DB" ofType:@"sqlite"]];
    //    db= [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        return nil;
    }
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM company"];
    rs = [db executeQuery:@"SELECT * FROM company"];
    while ([rs next]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dic setValue:[rs stringForColumn:@"title"] forKey:@"title"];
        [dic setValue:[rs stringForColumn:@"content"] forKey:@"content"];
        [array addObject:dic];
        NSLog(@"%@ %@", [dic objectForKey:@"ID"], [rs stringForColumn:@"title"]);
    }
    [rs close];
    return array;
}
-(NSArray *)quaryMessageByKeyWords:(NSString *)keyword{
    NSMutableArray *array = [NSMutableArray array];
    FMDatabase *db = [FMDatabase databaseWithPath:[[NSBundle mainBundle]pathForResource:@"DB" ofType:@"sqlite"]];
    //    db= [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        return nil;
    }
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM company"];
    NSString *str =[NSString stringWithFormat:@"SELECT * FROM keyword WHERE title LIKE  '%@%@%@'",@"%", keyword, @"%"];
    rs = [db executeQuery:str];
    while ([rs next]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dic setValue:[rs stringForColumn:@"title"] forKey:@"title"];
        [dic setValue:[rs stringForColumn:@"content"] forKey:@"content"];
        [array addObject:dic];
        NSLog(@"%@ %@", [dic objectForKey:@"ID"], [rs stringForColumn:@"title"]);
    }
    
    str = [NSString stringWithFormat:@"SELECT * FROM company WHERE title LIKE  '%@%@%@'",@"%", keyword, @"%"];
    rs = [db executeQuery:str];
    while ([rs next]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dic setValue:[rs stringForColumn:@"title"] forKey:@"title"];
        [dic setValue:[rs stringForColumn:@"content"] forKey:@"content"];
        [array addObject:dic];
        NSLog(@"%@ %@", [dic objectForKey:@"ID"], [rs stringForColumn:@"title"]);
    }
    
    str = [NSString stringWithFormat:@"SELECT * FROM question WHERE title LIKE  '%@%@%@'",@"%", keyword, @"%"];
    rs = [db executeQuery:str];
    while ([rs next]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dic setValue:[rs stringForColumn:@"title"] forKey:@"title"];
        [dic setValue:[rs stringForColumn:@"content"] forKey:@"content"];
        [array addObject:dic];
        NSLog(@"%@ %@", [dic objectForKey:@"ID"], [rs stringForColumn:@"title"]);
    }
    
    str = [NSString stringWithFormat:@"SELECT * FROM keyword WHERE content LIKE  '%@%@%@'",@"%", keyword, @"%"];
    rs = [db executeQuery:str];
    while ([rs next]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dic setValue:[rs stringForColumn:@"title"] forKey:@"title"];
        [dic setValue:[rs stringForColumn:@"content"] forKey:@"content"];
        [array addObject:dic];
        NSLog(@"%@ %@", [dic objectForKey:@"ID"], [rs stringForColumn:@"title"]);
    }
    
    str=[NSString stringWithFormat:@"SELECT * FROM keyword WHERE content LIKE  '%@%@%@'",@"%", keyword, @"%"];
    rs = [db executeQuery:str];
    while ([rs next]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dic setValue:[rs stringForColumn:@"title"] forKey:@"title"];
        [dic setValue:[rs stringForColumn:@"content"] forKey:@"content"];
        [array addObject:dic];
        NSLog(@"%@ %@", [dic objectForKey:@"ID"], [rs stringForColumn:@"title"]);
    }
    
    str = [NSString stringWithFormat:@"SELECT * FROM question WHERE content LIKE  '%@%@%@'",@"%", keyword, @"%"];
    rs = [db executeQuery:str];
    while ([rs next]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [dic setValue:[rs stringForColumn:@"title"] forKey:@"title"];
        [dic setValue:[rs stringForColumn:@"content"] forKey:@"content"];
        [array addObject:dic];
        NSLog(@"%@ %@", [dic objectForKey:@"ID"], [rs stringForColumn:@"title"]);
    }
    [rs close];
    return array;
}

@end
