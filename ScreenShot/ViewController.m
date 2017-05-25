//
//  ViewController.m
//  ScreenShot
//
//  Created by mac on 17/5/25.
//  Copyright © 2017年 cai. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_Width    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_Height   ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIView *shotView;

@end

@implementation ViewController

#pragma mark -
- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_Width, SCREEN_Height / 3.0)];
        _imgView.backgroundColor = [UIColor orangeColor];
    }
    return _imgView;
}

- (UIView *)shotView
{
    if (!_shotView) {
        _shotView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_Width/4.0, 20 + SCREEN_Height / 3.0 + 20, SCREEN_Width/2.0, 100)];
        _shotView.backgroundColor = [UIColor redColor];
    }
    return _shotView;
}

//点击按钮 进行屏幕截图
- (IBAction)didClickBtnAction:(UIButton *)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //开启一个和图片相关的图形上下文
        UIGraphicsBeginImageContextWithOptions(self.shotView.bounds.size, NO, 0.0);
        
        //获取刚刚开启的上下文
        CGContextRef ref = UIGraphicsGetCurrentContext();
        
        //进行截图 把当前控制器view的显示效果绘制到图形上下文中 / 截取shotView
        [self.shotView.layer renderInContext:ref];
        
        //从上下文中获取图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        //关闭图形上下文
        UIGraphicsEndImageContext();
        
        self.imgView.image = image;
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:self.shotView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_Width/2.0 - 20, 20)];
    label.text = @"This is a label";
    label.textColor = [UIColor purpleColor];
    label.font = [UIFont systemFontOfSize:16];
    [self.shotView addSubview:label];
    
    [self.view addSubview:self.imgView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
