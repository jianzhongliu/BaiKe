//
//  SelectValueController.m
//  BaiKe
//
//  Created by yons on 13-7-30.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "SelectValueController.h"

@interface SelectValueController ()

@end

@implementation SelectValueController
@synthesize delegate=_delegate;
@synthesize myArray=_myArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _myArray=[[NSMutableArray alloc]initWithCapacity:16];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect tempRect = CGRectMake(0.0f, 0.0f, 320.0f, 44.0f);
    UIImageView * textbg = [[UIImageView alloc]  initWithFrame:tempRect];
    textbg.image = [UIImage imageNamed:@"navigationbar_bg.png"];
    [self.view addSubview:textbg];
    
    myTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 45, 320, self.view.bounds.size.height-44) style:UITableViewStylePlain];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
	// Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_delegate returnSelectedValues:[_myArray objectAtIndex:[indexPath row]]];
    [self dismissModalViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_myArray count];
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 static NSString *identify=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text=[_myArray objectAtIndex:[indexPath row]];
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
