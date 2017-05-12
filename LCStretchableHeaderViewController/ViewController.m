//
//  ViewController.m
//  LCStretchableHeaderViewController
//
//  Created by hechao on 17/5/9.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, LCNavigationBarDelegate>

@end

@implementation ViewController

#pragma mark - Life Cycle


- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action



#pragma mark - Http

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL_ID"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - LCNavigationBarDelegate

- (void)lc_navgigationBarStateChanged:(LCNavigationBarState)barState
{
    NSLog(@"state = %ld", barState);
    if (barState == LCNavigationBarStateTransparent)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Transparent" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }else
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Normal" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blackColor]];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    }
}

#pragma mark - Private Methods


#pragma mark - UI

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"DEMO";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Transparent" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navBarNormalColor = [UIColor greenColor];
    self.ignoredTopOffset = 200;
    self.delegate = self;
    
    //add subview
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    self.headerView.backgroundColor = [UIColor redColor];
    //set frame
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    tableView.rowHeight = 88;
    tableView.delegate = self;
    tableView.dataSource = self;
    self.containerView = tableView;
}

#pragma mark - Getter && Setter





@end
