//
//  LCLanguageSwap.m
//  LCLanguageSwapDemo
//
//  Created by kkkelicheng on 16/12/9.
//  Copyright © 2016年 YCL. All rights reserved.
//

#import "LCLanguageSwap.h"

#define UserLanguageFile @"UserLanguageInfomation.plist"

static NSArray<NSString *> * _languages = nil;
static NSArray<NSString *> * _stingsFiles= nil;

NSString * const userLanguage = @"userLanguage";
NSString * const kNotificationLanguageWillChange = @"notification_language_will_change";
NSString * const kNotificationLanguageChanged = @"notification_language_changed";

@interface LCLanguageSwap ()
@property (nonatomic,strong,class,readonly) NSArray * languages;
@property (nonatomic,strong,class,readonly) NSArray * stringsFiles;
@end

@implementation LCLanguageSwap

/**
 get 类属性
 
 @return 返回语言的信息
 */
+(NSArray<NSString *> *)languages
{
    if (!_languages) {
        NSString * path = [[NSBundle mainBundle]pathForResource:UserLanguageFile ofType:nil];
        NSDictionary * info = [NSDictionary dictionaryWithContentsOfFile:path];
        _languages = info[@"languages"];
        //        NSLog(@"path :%@\n langInfos:%@",path,_languages);
    }
    return _languages;
}

+(NSArray<NSString *> *)stringsFiles
{
    if (!_stingsFiles) {
        NSString * path = [[NSBundle mainBundle]pathForResource:UserLanguageFile ofType:nil];
        NSDictionary * info = [NSDictionary dictionaryWithContentsOfFile:path];
        _stingsFiles = info[@"stringsFiles"];
        //        NSLog(@"path :%@\n _stingsFiles:%@",path,_stingsFiles);
    }
    return _stingsFiles;
}


+(void)setCurrentUseLanguage:(LanguageType)language
{
    if(![self setUserDefaultLanguageWith:language])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationLanguageWillChange
                                                           object:nil
                                                         userInfo:nil];
    }
    else {
        NSLog(@"相同的语言不需要切换");
    }
}

+(NSString *)currentUseLanguage
{
    NSString * languageString = [[NSUserDefaults standardUserDefaults]objectForKey:userLanguage];
    if (!languageString) {  //如果当前系统没有设置用户的语言，那么设置一个默认的
        LanguageType type = [self setDefaultLanguage];
        languageString = self.languages[type];
    }
    //    NSLog(@"当前使用语言：%@",languageString);
    return languageString;
}


+(NSString *)localValueWithKey:(NSString *)key
{
    return [self localValueWithKey:key tableIndex:0];
}

+(NSString *)localValueWithKey:(NSString *)key tableIndex:(NSInteger)tableIndex
{
    NSString * languageFilePath = [[NSBundle mainBundle]
                                   pathForResource:[NSString stringWithFormat:@"%@.lproj",[LCLanguageSwap currentUseLanguage]] ofType:nil];
    NSBundle * languageBundle = [NSBundle bundleWithPath:languageFilePath];
    return [languageBundle localizedStringForKey:key value:@"" table:self.stringsFiles[tableIndex]];
}

/**
 第一启动的话可能没有设置当前的用户操作语言
 
 @return 用户语言类型
 */
+(LanguageType)setDefaultLanguage
{
    NSString * systemLanguage =  [[NSLocale preferredLanguages] firstObject];
    LanguageType type = LanguageENGLISH;
    if ([systemLanguage hasPrefix:@"zh-Hans"]) {
        type = LanguageCHINESE;
    }
    else if([systemLanguage hasPrefix:@"zh-Hant"]){
        type = LanguageTraditional;
    }
    [[NSUserDefaults standardUserDefaults]setObject:self.languages[type] forKey:userLanguage];
    [[NSUserDefaults standardUserDefaults]synchronize];
    return type;
}

/**
 手动改变语言
 
 @param language 枚举类
 */
+(BOOL)setUserDefaultLanguageWith:(LanguageType)language
{
    NSString * currentLanguage = [self currentUseLanguage];
    NSString * languageString = self.languages[language];
    if (![currentLanguage isEqualToString:languageString]) {
        [[NSUserDefaults standardUserDefaults]setObject:languageString forKey:userLanguage];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    return [currentLanguage isEqualToString:languageString];
}


@end







@implementation LanguageControls

- (instancetype)initWithView:(id)view andValue:(NSString *)value
{
    if (self = [super init]) {
        self.view = view;
        self.value = value;
    }
    return self;
}

@end





static LanguageControlsPool * pool = nil;

/**
   国际化控件池
 */
@interface LanguageControlsPool ()
@property (nonatomic,strong) NSMutableSet<LanguageControls *> * controlsSet;
@end

@implementation LanguageControlsPool

#pragma mark - 初始化等

+(instancetype)shareControlsPool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!pool) {
            pool = [[LanguageControlsPool alloc]init];
            //开启变化监听
            [pool linsenToLanguageChange];
        }
    });
    return pool;
}

-(NSMutableSet<LanguageControls *> *)controlsSet
{
    if (!_controlsSet) {
        _controlsSet = [NSMutableSet set];
    }
    return _controlsSet;
}

+(void)registView:(id)view value:(NSString *)value;
{
    LanguageControlsPool * myPool = [LanguageControlsPool shareControlsPool];
    LanguageControls * controls = [[LanguageControls alloc]initWithView:view andValue:value];
    [myPool.controlsSet addObject:controls];
}


#pragma mark - 业务处理
/**
 刷新数据
 */
-(void)refreshControls
{
    NSMutableArray * emptyControls = [NSMutableArray array];
    [self.controlsSet enumerateObjectsUsingBlock:^(LanguageControls * _Nonnull obj, BOOL * _Nonnull stop) {
        if (!obj.view) {
            [emptyControls addObject:obj];
        }
        else{
            NSString * value = obj.value;
            NSString * localValue = LC_LOCAL_STRING(value);
            UIView * view = obj.view;
            NSLog(@"刷新值：%@ 语言值：%@",value,localValue);
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton * button = (UIButton *)view;
                [button setTitle:localValue forState:UIControlStateNormal];
            }
            else if([view isKindOfClass:[UILabel class]]){
                UILabel * label = (UILabel *)view;
                [label setText:localValue];
            }
            //... 这里可以对自定义的类型自己设置判断
        }
    }];
    
    __weak typeof(self) weakSelf = self;
    if (emptyControls.count) {
        [emptyControls enumerateObjectsUsingBlock:^(LanguageControls *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"剔除：%@",[obj.value class]);
            [weakSelf.controlsSet removeObject:obj];
        }];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationLanguageChanged object:nil userInfo:nil];
}

/**
 对本地化池中的已经释放的控件剔除
 */
- (void)clearNilView
{
    //...
}

#pragma mark - 对LCLanguageSwap的配合

- (void)linsenToLanguageChange
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(languageChangedNoti:) name:kNotificationLanguageWillChange object:nil];
}

- (void)languageChangedNoti:(NSNotification *)noti
{
    [self refreshControls];
}


@end






