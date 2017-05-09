//
//  LCStretchableHeaderViewController.m
//  LCStretchableHeaderViewController
//
//  Created by hechao on 17/5/9.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "LCStretchableHeaderViewController.h"
#import <LTNavigationBar/UINavigationBar+Awesome.h>

#define NAVBAR_CHANGE_POINT 32
#define NAVBAR_HEIGHT       64
#define UNSET_VALUE         (-1)

@interface LCStretchableHeaderViewController ()

@property (assign, nonatomic) CGFloat headerHeight;

@end

@implementation LCStretchableHeaderViewController

#pragma mark - Life Cycle

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.stretchable = YES;
    self.isGradientNavBar = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar lt_reset];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action



#pragma mark - Http



#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (scrollView == self.containerView && self.headerView && self.stretchable)
    {
        //stretch header view
        if (offsetY < 0)
        {
            self.headerView.frame = CGRectMake(0, offsetY, self.headerView.frame.size.width, - offsetY);
        }
    }
    //shade nav bar
    if (self.isGradientNavBar)
    {
        if (offsetY + self.ignoredTopOffset > NAVBAR_CHANGE_POINT)
        {
            CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + NAVBAR_HEIGHT - (offsetY + self.ignoredTopOffset)) / NAVBAR_HEIGHT));
            [self.navigationController.navigationBar lt_setBackgroundColor:[self.navBarNormalColor colorWithAlphaComponent:alpha]];
        }else
        {
            [self.navigationController.navigationBar lt_setBackgroundColor:[self.navBarNormalColor colorWithAlphaComponent:0]];
        }
    }
}

#pragma mark - Private Methods

- (void)layoutContainerView
{
    if (![self.containerView isKindOfClass:[UIScrollView class]])
    {
        return;
    }
    self.containerView.contentInset = UIEdgeInsetsMake(self.headerHeight, 0, 0, 0);
    self.containerView.contentOffset = CGPointMake(0, -self.headerHeight);
}

#pragma mark - UI


#pragma mark - Getter && Setter

- (void)setHeaderView:(UIView *)headerView
{
    if (_headerView)
    {
        [_headerView removeFromSuperview];
    }
    
    if (headerView == nil)
    {
        _headerView = nil;
        _headerHeight = 0;
    }else
    {
        _headerView = headerView;
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
        if (_containerView)
        {
            [self.containerView insertSubview:_headerView atIndex:0];
            [self layoutContainerView];
        }
    }
}

- (void)setContainerView:(UIScrollView *)containerView
{
    if (_containerView)
    {
        [_containerView removeFromSuperview];
    }
#if DEBUG
    NSAssert(([containerView isKindOfClass:[UIScrollView class]]), @"illegal containerView");
#endif
    _containerView = containerView;
    [self.view addSubview:_containerView];
    if (self.headerView && !self.headerView.superview)
    {
        [self.containerView insertSubview:_headerView atIndex:0];
    }
    [self layoutContainerView];
}

- (CGFloat)ignoredTopOffset
{
    if (_ignoredTopOffset == UNSET_VALUE)
    {
        _ignoredTopOffset = 100;
    }
    
    return _ignoredTopOffset;
}

- (CGFloat)headerHeight
{
    if (self.headerView == nil)
    {
        return 0;
    }else
    {
        return CGRectGetHeight(self.headerView.frame);
    }
}

- (UIColor *)navBarNormalColor
{
    if (_navBarNormalColor)
    {
        return _navBarNormalColor;
    }
    
    return [UIColor whiteColor];
}

@end
