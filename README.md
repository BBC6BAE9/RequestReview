# RequestReview

## Introduction

One line of code to add AppStore user review Alert.

(1) Introduce frequency control mechanism to avoid disturbing users. Up to 3 prompts per year. https://developer.apple.com/cn/app-store/ratings-and-reviews/

(2) When the user triggers the prompt 10 times, the prompt will appear. Support for specifying the strategy (counting when SwiftUI.View disappears or appears).

## Usage

`SystemPlayerView` accumulates `10` disappearances (i.e. after the user watches 10 videos), triggering the review alert.

```Swift
SystemPlayerView()
    .requestReviewIfNeeded()
```

```
SystemPlayerView()
    .requestReviewIfNeeded(strategy: .disappear)
```

`SystemPlayerView` accumulates `10` appearances, triggering the review alert.

```Swift
SystemPlayerView()
    .requestReviewIfNeeded(strategy: .appear)
```
