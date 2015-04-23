//
//  ViewController.m
//  循环播放
//
//  Created by mac on 15/4/17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ViewController.h"
#import "BSYScrollView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BSYScrollView *_whView;
}
@end

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.section==0) {
        
        cell.imageView.image = [UIImage imageNamed:@"我的收藏"];
        cell.textLabel.text = @"我的收藏";
    }else if (indexPath.section==1){
        cell.imageView.image = [UIImage imageNamed:@"离线缓存"];
        cell.textLabel.text = @"离线缓存";
    }else if (indexPath.section==2){
        cell.imageView.image = [UIImage imageNamed:@"近期观看"];
        cell.textLabel.text = @"近期观看";
    
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 150;
    }
    
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        // 最简单的轮播图创建方式
        _whView = [[BSYScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
        //把图片放到imageview上
        NSMutableArray *tempAry = [NSMutableArray array];
        for (int i=1; i<4 ;i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.png",i]];
            [tempAry addObject:imageView];
        }
        [_whView setImageViewAry:tempAry];
        _whView.delegate = self;
        return _whView ;
    }
    return nil;
   }
#pragma mark 界面消失的时候，停止自动滚动

-(void)viewDidDisappear:(BOOL)animated
{
    [_whView BSYShouldAutoShow:NO];
}
@end
