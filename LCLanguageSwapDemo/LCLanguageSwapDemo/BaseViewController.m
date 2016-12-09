//
//  BaseViewController.m
//  LCLanguageSwapDemo
//
//  Created by MAC-DDT on 16/12/9.
//  Copyright © 2016年 YCL. All rights reserved.
//

#import "BaseViewController.h"
#import "LCLanguageSwap.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(languageChangedNoti:) name:kNotificationLanguageChanged object:nil];
}

- (void)languageChangedNoti:(NSNotification *)noti
{
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
