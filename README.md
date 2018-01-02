# PopoverView

[![Build](https://img.shields.io/wercker/ci/wercker/docs.svg)]()
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)]()
[![License](https://img.shields.io/badge/license-MIT-orange.svg?style=flat)]()


> 本代码从Apple官方Demo中进化而来，原Demo代码[👇戳这里👇](https://developer.apple.com/library/content/samplecode/LookInside/Introduction/Intro.html#//apple_ref/doc/uid/TP40014643)

弹出一个居中的Popover视图

使用简单，代码无侵入，适配横竖屏


## Requirements

- iOS8.0+


## Usage

- 将CenterPopover文件夹拖入你的项目即可

- 示例代码

1. 弹出控制器

```ObjC
UIViewController *vc = [[UIViewController alloc] init];
[self presentPopoverPresentationController:vc preferredContentSize:CGSizeMake(200.0, 300.0) shouldDismissPopover:YES completion:^{
	NSLog(@"Popover show finish.");
}];
```

2. 弹出自定义视图

```ObjC
UIView *contentView = [[UIView alloc] init];
contentView.backgroundColor = [UIColor purpleColor];
[self presentPopoverView:contentView preferredContentSize:CGSizeMake(200.0, 300.0) shouldDismissPopover:YES completion:^{
	// 3秒后自动关闭
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
	});
}];
```

## License

基于MIT协议进行开源，详细内容请参阅`LICENSE`文件。