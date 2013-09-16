//
//  SearchViewController.m
//  BaiKe
//
//  Created by yons on 13-8-7.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "SearchViewController.h"
#import "DBManager.h"
#import "ChapterCell.h"
#import "ReadPageController.h"

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        myArray = [NSMutableArray array];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];


    
    CGRect tempRect = CGRectMake(0.0f, 0.0f, 320.0f, 44.0f);
    UIImageView * textbg = [[UIImageView alloc]  initWithFrame:tempRect];
    textbg.image = [UIImage imageNamed:@"navigationbar_bg.png"];
    [self.view addSubview:textbg];

    search = [[UISearchBar alloc] initWithFrame:CGRectMake(65, 5, 250, 30)];
    search.delegate=self;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationbar_bg.png"]];
    imageView.frame = CGRectMake(0, 0, search.frame.size.width, search.frame.size.height);
    [search insertSubview:imageView atIndex:1];
    search.placeholder = @"请输入您要查找的内容";
    [self.view addSubview:search];
    
    UIButton *listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [listButton setBackgroundImage:[UIImage imageNamed:@"navbuttonnormal.png"] forState:UIControlStateNormal];
    [listButton setFrame:CGRectMake(10.0, 6.0, 50.0, 32.0)];
    [listButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    listButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [listButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:listButton];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, 320, self.view.frame.size.height-45) style:UITableViewStylePlain];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.separatorStyle = 0;
    [self.view addSubview:myTable];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [search becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [search resignFirstResponder];
}

#pragma mark - UITableViewDataSource-UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReadPageController *view = [[ReadPageController alloc] init];
    view.content = [[myArray objectAtIndex:[indexPath row]] objectForKey:@"content"];
    view.title = [[myArray objectAtIndex:[indexPath row]] objectForKey:@"title"];
    [self.navigationController pushViewController:view animated:YES];
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [myArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 static NSString *identify = @"cell";
    ChapterCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    tableView.separatorStyle = 1;
    if(cell == nil){
        cell = [[ChapterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    [cell setTitle:[[myArray objectAtIndex:[indexPath row]] objectForKey:@"title"]];
    [cell setDescription:[[myArray objectAtIndex:[indexPath row]] objectForKey:@"content"]];
    return cell;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [search resignFirstResponder];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{


}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [search resignFirstResponder];
    DBManager *manager = [[DBManager alloc] init];
    [myArray removeAllObjects];
    [myArray addObjectsFromArray:[manager quaryMessageByKeyWords:searchBar.text]];
    [myTable reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    DBManager *manager = [[DBManager alloc] init];
    [myArray removeAllObjects];
    [myArray addObjectsFromArray:[manager quaryMessageByKeyWords:searchBar.text]];
    [myTable reloadData];
}

#pragma mark - pricateMethods
-(void)goBack{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
