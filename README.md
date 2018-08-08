# LottieViewMager

## 支持pod导入

* pod 'LottieViewMager'

* 执行pod search LottieViewMager提示搜索不到，可以执行以下命令更新本地search_index.json文件
  
```objc 
rm ~/Library/Caches/CocoaPods/search_index.json
```
* 如果pod search还是搜索不到，执行pod setup命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了

## 使用说明：

* 导入头文件 #import "LottieViewManager.h"

* 在基类VC中添加加载动画

示例代码：

```objc       
- (void)showLoadingView
{
// loading大小是默认
    LottieViewManager *hud = [LottieViewManager showHUDAddedTo:self.navigationController.view animated:YES animationJson:@"vio"];
    
// 控制loading 的大小  vio是本地json格式的动画数据
//    LottieViewManager *hud = [LottieViewManager showHUDAddedTo:self.navigationController.view animated:YES frame:CGRectMake(0, 0, 0, 0) animationJson:@"vio"];
    self.hud = hud;
}

- (void)hideLoadingView
{
    [self.hud removeFromSuperview];
    self.hud = nil;
}

```

* 在基类VC.h文件中暴露出来两个方法：显示和隐藏

```objc
// 显示加载动画
- (void)showLoadingView;
// 隐藏加载动画
- (void)hideLoadingView;
```

## 详细用法可以下载demo

*  json格式动画下载链接：https://www.lottiefiles.com/aep

* ![Mou icon](https://github.com/MrLujh/LottieViewMager/blob/master/Untitled.gif)
