# RequestReview

## 介绍

一行代码接入AppStore用户评价弹窗。

（1）引入频控机制，避免打扰用户。全年最多弹出3次 https://developer.apple.com/cn/app-store/ratings-and-reviews/

（2）用户累计触发10次，弹一次窗。支持指定策略（在SwiftUI.View消失的时候还是出现的时候进行计数）



## 使用

`SystemPlayerView`累计消失`10`次（即用户观看10次视频之后），触发评分弹窗。

```Swift
SystemPlayerView()
		.requestReviewIfNeeded()
```

```
SystemPlayerView()
		.requestReviewIfNeeded(strategy: .disappear)
```

`SystemPlayerView`累计出现`10`次，触发评分弹窗。

```Swift
SystemPlayerView()
		.requestReviewIfNeeded(strategy: .appear)
```
