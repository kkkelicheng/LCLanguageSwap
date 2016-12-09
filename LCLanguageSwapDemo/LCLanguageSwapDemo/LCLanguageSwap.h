//
//  LCLanguageSwap.h
//  LCLanguageSwapDemo
//
//  Created by kkkelicheng on 16/12/9.
//  Copyright © 2016年 YCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LCLanguageSwap : NSObject


#define LC_LOCAL_STRING(KEY) [LCLanguageSwap localValueWithKey:KEY]

extern NSString * const userLanguage;
extern NSString * const kNotificationLanguageChanged;
extern NSString * const kNotificationLanguageWillChange;

/**
 语言类型，跟mainBundle中的语言plist文件顺序要一致
 
 - LanguageCHINESE:     中文
 - LanguageTraditional: 繁体字
 - LanguageENGLISH:     英文
 */
typedef NS_ENUM(NSInteger , LanguageType){
    LanguageCHINESE,
    LanguageTraditional,
    LanguageENGLISH,
};


+(NSString *)currentUseLanguage;
+(void)setCurrentUseLanguage:(LanguageType)language;

/**
 根据当前的设置语言以及key获得对应的值
 @param key   key值
 @return 返回当前语言的table名字是CustomStrings中，key对应的value值
 */
+(NSString *)localValueWithKey:(NSString *)key;

/**
 根据当前的设置语言以及key获得对应的值
 @param key   key值
 @param tableIndex 就是UserLanguageList文件中stringsFile的索引值，不能带后缀
 @return 返回对应语言的table中，key对应的value值
 */
+(NSString *)localValueWithKey:(NSString *)key tableIndex:(NSInteger)tableIndex;

@end







@interface LanguageControls : NSObject

//这里用weak
@property (nonatomic,weak) id view;
@property (nonatomic,copy) NSString * value;

/**
 包装类
 
 @param view  想要被语言化的控件
 @param value stings文件中的值key值
 
 @return 被包裹的view
 */
- (instancetype)initWithView:(id)view andValue:(NSString *)value;

@end



@interface LanguageControlsPool : NSObject


+(void)registView:(id)view value:(NSString *)value;

@end






