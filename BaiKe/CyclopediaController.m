//
//  CyclopediaController.m
//  BaiKe
//
//  Created by yons on 13-7-29.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "CyclopediaController.h"
#import "WebSiteViewController.h"
#import "ChapterCell.h"
@interface CyclopediaController ()

@end

@implementation CyclopediaController

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CGRect tempRect = CGRectMake(0.0f, 0.0f, 320.0f, 44.0f);
    UIImageView * textbg = [[UIImageView alloc]  initWithFrame:tempRect];
    textbg.image = [UIImage imageNamed:@"navigationbar_bg.png"];
    [self.view addSubview:textbg];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.textAlignment = UITextAlignmentCenter;
    titleLable.textColor     = RGB(0.0f, 0.0f, 0.0f);
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textColor     = [UIColor whiteColor];
    titleLable.shadowColor   = [UIColor blackColor];//字体为白色时可给他添加黑色的阴影效果
    titleLable.shadowOffset  = CGSizeZero;
    titleLable.font          = [UIFont boldSystemFontOfSize:20.0f];
    titleLable.text = @"看房";
    [titleLable sizeToFit];//在边框变化时改变
    titleLable.center        = CGPointMake(160.0f, 22.0f);
    [self.view addSubview:titleLable];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, 320, self.view.bounds.size.height-45-46) style:UITableViewStylePlain];
    myTable.delegate = self;
    myTable.dataSource = self;
    [self.view addSubview:myTable];
    myArray = [[NSMutableArray alloc] initWithCapacity:16];
    [myArray addObject:@"http://www.anjuke.com"];//安居客 ok
    [myArray addObject:@"http://sf.soufang.com"];//搜房 ok
    [myArray addObject:@"http://www.koofang.com"];//酷房网
    [myArray addObject:@"http://dg.fangdr.com"];//房博士
    [myArray addObject:@"http://house.qq.com"];//腾讯房产资讯 ok
    [myArray addObject:@"http://www.house.sina.com.cn"];//新浪乐居 ok
    [myArray addObject:@"http://www.focus.cn"];//焦点房产网
    
    [myArray addObject:@"http://sh.house.163.com"];//网易房产http://sh.house.163.com
    [myArray addObject:@"http://esf.focus.cn"];//搜狐二手房http://esf.focus.cn
    [myArray addObject:@"http://house.ifeng.com"];//凤凰房产http://house.ifeng.com
    [myArray addObject:@"http://sh.5i5j.com"];//我爱我家http://sh.5i5j.com
    [myArray addObject:@"http://www.homelink.com.cn"];//链家在线http://shanghai.homelink.com.cn ok
    
    [myArray addObject:@"http://www.soufun.com"];//搜房帮http://agent.soufun.com ok
    [myArray addObject:@"http://www.taofw.cn"];///淘房屋http://www.taofw.cn
    [myArray addObject:@"http://sh.loupan.com"];//楼盘网http://sh.loupan.com
    [myArray addObject:@"http://www.house365.com"];//365房产网http://www.house365.com
    [myArray addObject:@"http://sh.taofang.com"];//淘房网http://sh.taofang.com ok
    [myArray addObject:@"http://www.century21cn.com"];//21世纪不动产http://www.century21cn.com
    
    [myArray addObject:@"http://www.centaline.com.cn"];//中原地产http://www.centaline.com.cn
    [myArray addObject:@"http://www.eju.com"];//易居购房网http://www.eju.com
    [myArray addObject:@"http://www.tuitui99.com"];//推推99房产http://www.tuitui99.com
    [myArray addObject:@"http://house.baidu.com/sh/"];//百度乐居http://house.baidu.com/sh/ ok
    [myArray addObject:@"http://sh.fangjia.com"];//房价网http://sh.fangjia.com
    [myArray addObject:@"http://www.fangtan007.com"];//房探网http://www.fangtan007.com

    myNameArrray = [[NSMutableArray alloc] initWithCapacity:16];
    [myNameArrray addObject:@"安居客"];
    [myNameArrray addObject:@"搜房网"];
    [myNameArrray addObject:@"酷房网"];
    [myNameArrray addObject:@"房博士"];
    [myNameArrray addObject:@"腾讯房产资讯"];
    [myNameArrray addObject:@"新浪乐居"];
    [myNameArrray addObject:@"焦点房产网"];
    [myNameArrray addObject:@"网易房产"];
    [myNameArrray addObject:@"搜狐二手房"];
    [myNameArrray addObject:@"凤凰房产"];
    [myNameArrray addObject:@"我爱我家"];
    [myNameArrray addObject:@"链家在线"];
    [myNameArrray addObject:@"搜房帮"];
    [myNameArrray addObject:@"淘房屋"];
    [myNameArrray addObject:@"楼盘网"];
    [myNameArrray addObject:@"365房产网"];
    [myNameArrray addObject:@"淘房网"];
    [myNameArrray addObject:@"21世纪不动产"];
    [myNameArrray addObject:@"中原地产"];
    [myNameArrray addObject:@"易居购房网"];
    [myNameArrray addObject:@"推推99房产"];
    [myNameArrray addObject:@"百度乐居"];
    [myNameArrray addObject:@"房价网"];
    [myNameArrray addObject:@"房探网"];

    /*
    搜房网
    焦点房产网
    新浪乐居
    腾讯房产
    网易房产http://sh.house.163.com
    安居客二手房
    搜狐二手房http://esf.focus.cn
    凤凰房产http://house.ifeng.com
    我爱我家http://sh.5i5j.com
    链家在线http://shanghai.homelink.com.cn
    搜房帮http://agent.soufun.com
    淘房屋http://www.taofw.cn
    楼盘网http://sh.loupan.com
    365房产网http://www.house365.com
    淘房网http://sh.taofang.com
    21世纪不动产http://www.century21cn.com
    中原地产http://www.centaline.com.cn
    易居购房网http://www.eju.com
    推推99房产http://www.tuitui99.com
    百度乐居http://house.baidu.com/sh/
    房价网http://sh.fangjia.com
    房探网http://www.fangtan007.com
    */
	// Do any additional setup after loading the view.
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebSiteViewController *controller = [[WebSiteViewController alloc] init];
    controller.url = [myArray objectAtIndex:[indexPath row]];
    controller.name = [myNameArrray objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:controller animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [myArray count];
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *identify = @"cell";
    ChapterCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    if(cell == nil){
    cell = [[ChapterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    [cell setTitle:[myNameArrray objectAtIndex:[indexPath row]]];
    [cell setDescription:[myArray objectAtIndex:[indexPath row]]];
    return cell;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
