//
//  YKSegmentedViewController.h
//  YKSegmentedViewControllerDemo
//
//  Created by Yoshiki Kurihara on 2014/02/03.
//  Copyright (c) 2014年 Yoshiki Kurihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKSegmentedViewController;

@protocol YKSegmentedViewControllerDelegate <NSObject>

- (NSInteger)numberOfSegmentsInController:(YKSegmentedViewController *)controller;

- (UIView *)segmentedViewController:(YKSegmentedViewController *)controller
              viewForContentAtIndex:(NSInteger)index;

- (CGFloat)heightForSegmentedViewInController:(YKSegmentedViewController *)controller;

@optional
- (void)segmentedViewController:(YKSegmentedViewController *)controller
            valueChangedToIndex:(NSInteger)index;

- (UIImage *)segmentedViewController:(YKSegmentedViewController *)controller
    backgroundImageForSegmentAtIndex:(NSInteger)index;

- (UIImage *)segmentedViewController:(YKSegmentedViewController *)controller
selectedBackgroundImageForSegmentAtIndex:(NSInteger)index;

- (UIImage *)segmentedViewController:(YKSegmentedViewController *)controller
              imageForSegmentAtIndex:(NSInteger)index;

- (UIImage *)segmentedViewController:(YKSegmentedViewController *)controller
      selectedImageForSegmentAtIndex:(NSInteger)index;

- (NSString *)segmentedViewController:(YKSegmentedViewController *)controller
                textForSegmentAtIndex:(NSInteger)index;

- (UIColor *)segmentedViewController:(YKSegmentedViewController *)controller
          textColorForSegmentAtIndex:(NSInteger)index;

- (UIColor *)segmentedViewController:(YKSegmentedViewController *)controller
highlightedTextColorForSegmentAtIndex:(NSInteger)index;

- (UIColor *)segmentedViewController:(YKSegmentedViewController *)controller
    textShadowColorForSegmentAtIndex:(NSInteger)index;

- (UIColor *)segmentedViewController:(YKSegmentedViewController *)controller
highlightedTextShadowColorForSegmentAtIndex:(NSInteger)index;

- (CGSize)segmentedViewController:(YKSegmentedViewController *)controller
textShadowOffsetForSegmentAtIndex:(NSInteger)index;

- (UIFont *)segmentedViewController:(YKSegmentedViewController *)controller
              fontForSegmentAtIndex:(NSInteger)index;

- (UIView *)headerViewInController:(YKSegmentedViewController *)controller;

- (CGFloat)heightForButtonInController:(YKSegmentedViewController *)controller;

- (CGFloat)widthForButtonInController:(YKSegmentedViewController *)controller;

- (UIImage *)backgroundImageInController:(YKSegmentedViewController *)controller;

@end

@interface YKSegmentedViewController : UIViewController

@property (unsafe_unretained) id<YKSegmentedViewControllerDelegate> delegate;
@property (nonatomic, strong) UIView *segmentedView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, assign) BOOL hidesSegmentedView;

- (void)reloadView;

@end
