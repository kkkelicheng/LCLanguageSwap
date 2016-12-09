//
//  ViewController.m
//  LCLanguageSwapDemo
//
//  Created by MAC-DDT on 16/12/9.
//  Copyright © 2016年 YCL. All rights reserved.
//

#import "ViewController.h"
#import "LCLanguageSwap.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ALabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews
{
    [self.ALabel setText:LC_LOCAL_STRING(@"good")];
    [LanguageControlsPool registView:self.ALabel value:@"good"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
