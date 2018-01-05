# PopoverView

[![Build](https://img.shields.io/wercker/ci/wercker/docs.svg)]()
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)]()
[![License](https://img.shields.io/badge/license-MIT-orange.svg?style=flat)]()


> 本代码从Apple官方Demo中进化而来，原Demo代码[👇戳这里👇](https://developer.apple.com/library/content/samplecode/LookInside/Introduction/Intro.html#//apple_ref/doc/uid/TP40014643)

弹出一个居中的Popover视图

使用简单，代码无侵入，适配横竖屏


## Requirements

- iOS8.0+
- Swift4.0
- Xcode9.0+


## Usage

- 将CenterPopover文件夹拖入你的项目即可

- 示例代码

1. 弹出控制器

```Swift
let contentViewController = UIViewController()
contentViewController.view.backgroundColor = .purple
presentPopoverPresentationController(contentViewController, preferredContentSize: CGSize(width: 200.0, height: 300.0), shouldDismissPopover: true) {
    print("ViewController show finish.")
}
```

2. 弹出自定义视图

```Swift
let contentView = UIView()
contentView.layer.cornerRadius = 14.0
contentView.layer.masksToBounds = true
contentView.backgroundColor = .purple
presentPopoverView(contentView, preferredContentSize: CGSize(width: 200.0, height: 300.0), shouldDismissPopover: false) {
	print("View is showed.");
	// 3秒后自动关闭
	DispatchQueue.main.asyncAfter(deadline: .now()+3.0, execute: {
		self.presentedViewController?.dismiss(animated: true, completion: nil)
	})
}

```

## License

基于MIT协议进行开源，详细内容请参阅`LICENSE`文件。