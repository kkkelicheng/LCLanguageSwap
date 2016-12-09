#LCLanguageSwap
应用内语言热切换
![效果图](https://raw.githubusercontent.com/kkkelicheng/LCLanguageSwap/master/LCLanguageSwapDemo/Language_gif.gif)

##简介
`LCLanguageSwap`文件夹里面有2个东西
* `LCLanguageSwap`
这里`LCLanguageSwap`类里面主要有三个类
	*  LCLanguageSwap 主要功能接口类
	*  LanguageControls 辅助类
	*  LanguageControlsPool 辅助类

* `UserLanguageInfomation`
 设置语言类型列表（其中**对应语言的值**设置正确，例如：简体中文是zh-Hans,英文是en），设置国际化文件列表

##用法
* 在代码中直接用`LC_LOCAL_STRING`这个宏去替换文字。
 会自动根据当前用户的语言，从默认的`table`（就是那个`Strings`文件了）中去找对应的值。

* 为了更新控件内容，你需要将控件放入`LanguageControlsPool`这个东西里面。
 直接调用` [LanguageControlsPool registView:view value:keyValue];`,刷新的时候会将`LanguageControlsPool`中的所有控件进行内容刷新。

* 你可能需要在更新内容后重新布局
监听`kNotificationLanguageChanged`触发。


##其他的一些说明
* `LCLanguageSwap`类中枚举类型说明
`LanguageType`要跟`UserLanguageInfomation`中语言列表的语言信息对应.
 枚举的名字可以自己写，位置要一对一。应为代码中的语言代码根据枚举的值去plist文件中的位置去获得**对应的语言的值**

* 工程中默认的用户语言设置说明
写在`LCLanguageSwap`类中`setDefaultLanguage`的这个方法里面。很简单的逻辑，可以自己修改一下。

* 通知的说明
`kNotificationLanguageWillChange` & `kNotificationLanguageChanged`
`kNotificationLanguageWillChange`这个过程是将要去做更新所有的国际化的控件
`kNotificationLanguageChanged` 发生这个通知的时候，是控件内容已经更新，可以做一些其他的操作，例如布局。
