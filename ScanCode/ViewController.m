//
//  ViewController.m
//  ScanCode
//
//  Created by wangheng on 2019/12/12.
//  Copyright © 2019年 wangheng. All rights reserved.
//

#import "ViewController.h"
#import "WHBusCodeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    UIButton *busCode = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    busCode.center = self.view.center;
    busCode.backgroundColor = UIColor.redColor;
    [busCode setTitle:@"乘车扫码" forState:UIControlStateNormal];
    [busCode addTarget:self action:@selector(busCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:busCode];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)busCodeAction{
    WHBusCodeViewController *bus = [[WHBusCodeViewController alloc] init];
    [self.navigationController pushViewController:bus animated:YES];
}

@end
