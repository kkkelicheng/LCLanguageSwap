//
//  CViewController.m
//  LCLanguageSwapDemo
//
//  Created by MAC-DDT on 16/12/9.
//  Copyright © 2016年 YCL. All rights reserved.
//

#import "CViewController.h"
#import "LCLanguageSwap.h"

@interface CViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nihaoLabel;

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews
{
    [self.nihaoLabel setText:LC_LOCAL_STRING(@"hello")];
    [LanguageControlsPool registView:self.nihaoLabel value:@"hello"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)en:(id)sender
{
    [LCLanguageSwap setCurrentUseLanguage:LanguageENGLISH];
}

- (IBAction)hanz:(id)sender
{
    [LCLanguageSwap setCurrentUseLanguage:LanguageCHINESE];
}

- (IBAction)hant:(id)sender
{
    [LCLanguageSwap setCurrentUseLanguage:LanguageTraditional];
}

@end
