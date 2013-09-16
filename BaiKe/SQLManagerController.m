//
//  SQLManagerController.m
//  BaiKe
//
//  Created by yons on 13-8-1.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "SQLManagerController.h"

@interface SQLManagerController ()

@end

@implementation SQLManagerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //创建数据库文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"DB.sqlite"];
    NSLog(@"%@",dbPath);
//    db= [FMDat abase databaseWithPath:[[NSBundle mainBundle]pathForResource:@"Test" ofType:@"sqlite"]];
    db= [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        return ;
    }
//    //创建表
//    [db executeUpdate:@"CREATE TABLE Users(Name text, Age integer)"];
//    //插入数据
//    [db executeUpdate:@"INSERT INTO Users(Name, Age) VALUES(?, ?)", @"Eric", [NSNumber numberWithInt:25]]  ;
//    //更新数据
//    [db executeUpdate:@"UPDATE Users SET Name = ? WHERE Name = ? ",@"Michael", @"jianzhong"];
//    //
//    // [db executeUpdate:@"DELETE FROM Users WHERE Name = ?", @"Michael"];
//    
//    //查询数据
//    FMResultSet *rs = [db executeQuery:@"SELECT * FROM Users"];
//    rs = [db executeQuery:@"SELECT * FROM Users WHERE Age = ?", @"25"];
//    while ([rs next]){
//        NSLog(@"%@ %@", [rs stringForColumn:@"Name"], [rs stringForColumn:@"Age"]);
//    }
//    [rs close];
    
    
    but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame = CGRectMake(0, 0, 320, 40);
    [but addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    [but setTitle:@"创建表" forState:UIControlStateNormal];
    but.tag = 109;
    [self.view addSubview:but];
    but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame = CGRectMake(0, 100, 320, 40);
    but.tag = 101;
    [but addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    [but setTitle:@"插入数据" forState:UIControlStateNormal];
    [self.view addSubview:but];
    but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame = CGRectMake(0, 200, 320, 40);
    but.tag = 102;
    [but addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    [but setTitle:@"更新数据" forState:UIControlStateNormal];
    [self.view addSubview:but];
    but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame = CGRectMake(0, 300, 320, 40);but.tag=103;
    [but addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    [but setTitle:@"删除数据" forState:UIControlStateNormal];
    [self.view addSubview:but];
    but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame = CGRectMake(0, 400, 320, 40);but.tag=104;
    [but addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    [but setTitle:@"查询数据" forState:UIControlStateNormal];
    [self.view addSubview:but];

	// Do any additional setup after loading the view.
}
-(void)click:(id)sender{
    UIButton *bu = (UIButton *)sender;
    NSLog(@"%d",bu.tag);
    if(bu.tag == 109){
        [db executeUpdate:@"CREATE TABLE question(ID integer, title text, content text)"];
    }
    if(bu.tag == 101){
        NSString *str = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"question" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSMutableArray *myArray = [[NSMutableArray alloc] initWithCapacity:16];
        [myArray addObjectsFromArray:[str componentsSeparatedByString:@"==="]];
        for (int i =0; i<[myArray count]; i++) {
            NSLog(@"%d6666>>>>>>>>>>>%@",[myArray count], [myArray objectAtIndex:i]);
            [db executeUpdate:@"INSERT INTO question(Id, title, content) VALUES(?, ?, ?)", [NSNumber numberWithInt:i], [[[myArray objectAtIndex:i] componentsSeparatedByString:@"=="]objectAtIndex:0], [[[myArray objectAtIndex:i] componentsSeparatedByString:@"=="]objectAtIndex:1]];
        }
    }
    if(bu.tag==102){
        [db executeUpdate:@"UPDATE knoledge SET Name = ? WHERE Name = ? ", @"Michael", @"Eric"];
    }
    
    if(bu.tag==103){
        [db executeUpdate:@"DELETE FROM knoledge WHERE Name = ?", @"Michael"];
    }
    
    if(bu.tag==104){
          FMResultSet *rs = [db executeQuery:@"SELECT * FROM question"];
           rs = [db executeQuery:@"SELECT * FROM question WHERE ID > ?", @"0"];
          while ([rs next]){
               NSLog(@"%@ %@", [rs stringForColumn:@"ID"], [rs stringForColumn:@"title"]);
          }
          [rs close];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self setTitle:@"设置数据库"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
