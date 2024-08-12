//
//  View+RequestReview.swift
//  RateDemo
//
//  Created by hong on 2024/8/12.
//

import StoreKit
import SwiftUI

/// 请求用户评分的策略
enum RequestReviewStrategy {
    // 视图出现的时候
    case appear
    // 视图消失的时候
    case disappear
}

extension View {
    /// 请求用户评分
    func requestReviewIfNeeded(strategy: RequestReviewStrategy = .disappear) -> some View {
        self.modifier(RequestReviewIfNeededModifier(strategy: strategy))
    }
}

/// 请求用户评分Modifier
private struct RequestReviewIfNeededModifier: ViewModifier {
    @Environment(\.requestReview) var requestReview
    
    var strategy: RequestReviewStrategy
    
    /// 请求评分的次数
    @AppStorage("requestReviewCount") var count: Int = 0
    
    /// 上次出现的评分请求的时间
    @AppStorage("lastSeen") var lastSeenTimeStamp: TimeInterval = 0
    
    func body(content: Content) -> some View {
        switch strategy {
        case .appear:
            content
                .onAppear(perform: {
                    if needRequestReview() {
                        requestReview()
                    }
                })
        case .disappear:
            content
                .onDisappear(perform: {
                    if needRequestReview() {
                        requestReview()
                    }
                })
        }
    }
    
    /// 是否需要请求用户评分
    
    private func needRequestReview() -> Bool {
        // 是否距离上次出现超过122天，如果超过122天就计数，如果没超过122天就继续流程
        
        let currentTimeStamp = Date().timeIntervalSince1970
        
        let timeDiff = currentTimeStamp - lastSeenTimeStamp
        
        /// 在 365 天以内，最多可向用户征求三次评分
        /// ref: https://developer.apple.com/cn/app-store/ratings-and-reviews/
        if timeDiff < 122 * 24 * 60 * 60 { // 冷却期内
            print("冷却期内不计数")
            return false
        }
        print("不在冷却期")
        
        count += 1
        
        let countTheshold = 10
        
        if count == countTheshold {
            print("计数:\(count)，请求用户评分")
            lastSeenTimeStamp = Date().timeIntervalSince1970
            count = 0
            return true
        }
        
        print("计数:\(count)")
        return false
    }
}
