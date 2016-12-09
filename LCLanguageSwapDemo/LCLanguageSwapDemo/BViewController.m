//
//  BViewController.m
//  LCLanguageSwapDemo
//
//  Created by MAC-DDT on 16/12/9.
//  Copyright © 2016年 YCL. All rights reserved.
//

#import "BViewController.h"
#import "LCLanguageSwap.h"
#import "CViewController.h"

@interface BViewController ()
@property (weak, nonatomic) IBOutlet UILabel *BLabel;

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews
{
    [self.BLabel setText:LC_LOCAL_STRING(@"pageB")];
    [LanguageControlsPool registView:self.BLabel value:@"pageB"];
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
- (IBAction)push:(id)sender
{
    CViewController * c = [[CViewController alloc]initWithNibName:@"CViewController" bundle:nil];
    [self.navigationController pushViewController:c animated:YES];
}


@end
