//
//  ViewController.m
//  Demo2
//
//  Created by binghuang on 16/3/3.
//  Copyright © 2016年 binghuang. All rights reserved.
//

#define ktableViewHeaderHeigth  300

#define ktableViewTopHeight 250

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView * headView;
    CAShapeLayer * headermaskLayer;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    headView  =  _tableView.tableHeaderView;
    _tableView.tableHeaderView  = nil;
    _tableView.rowHeight   = UITableViewAutomaticDimension;

    [_tableView addSubview:headView];
    
    _tableView.contentInset  = UIEdgeInsetsMake(ktableViewTopHeight, 0, 0, 0);
//    _tableView.contentOffset  = CGPointMake(0, -ktableViewHeaderHeigth);
    
    headermaskLayer = [CAShapeLayer layer];
//    headermaskLayer.fillColor      = [UIColor blackColor].CGColor;
    headView.layer.mask            = headermaskLayer;
    
    [self updateHeaderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    
    return YES;
}

-(void)updateHeaderView{
    
    CGRect  headerRect           = CGRectMake(0,-ktableViewTopHeight,_tableView.bounds.size.width,ktableViewHeaderHeigth);
    
    if (_tableView.contentOffset.y < -ktableViewTopHeight) {
        headerRect.origin.y      =   _tableView.contentOffset.y;
        headerRect.size.height   = - _tableView.contentOffset.y + (ktableViewHeaderHeigth -ktableViewTopHeight);
    }
    
    headView.frame        = headerRect;
    
    UIBezierPath *  path  = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(headerRect.size.width, 0)];
    [path addLineToPoint:CGPointMake(headerRect.size.width,headerRect.size.height)];
    [path addLineToPoint:CGPointMake(0,headerRect.size.height - 100)];
    headermaskLayer.path  = path.CGPath;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self updateHeaderView];
    NSLog(@"scrollViewDidScroll=%f",scrollView.contentOffset.y);
}

//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}


@end
