//
//  LCStretchableHeaderViewController.h
//  LCStretchableHeaderViewController
//
//  Created by hechao on 17/5/9.
//  Copyright © 2017年 hc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface LCStretchableHeaderViewController : UIViewController

@property (strong, nonatomic) UIView *headerView;//header view can be a custom view or just a image view
@property (strong, nonatomic) UIScrollView *containerView;//containerView must be kind of UIScrollView or subclass of UIScrollView
@property (assign, nonatomic) BOOL stretchable;//default is YES,whether headerView can stretch or not
@property (assign, nonatomic) CGFloat ignoredTopOffset;//ingored offset on top

@property (assign, nonatomic) BOOL isGradientNavBar;//default is YES,whether nav bar is gradient
@property (strong, nonatomic) UIColor *navBarNormalColor;//nav bar color

@end
