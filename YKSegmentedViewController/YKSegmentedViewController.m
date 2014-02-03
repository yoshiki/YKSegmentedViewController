//
//  YKSegmentedViewController.m
//  YKSegmentedViewController
//
//  Created by Yoshiki Kurihara on 2014/02/03.
//  Copyright (c) 2014年 Yoshiki Kurihara. All rights reserved.
//

#import "YKSegmentedViewController.h"


#define kYKSegmentedViewControllerContentSubviewTag 9999

@interface YKSegmentedViewController ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation YKSegmentedViewController

@synthesize selectedSegmentIndex = _selectedSegmentIndex;
@synthesize hidesSegmentedView = _hidesSegmentedView;

- (id)init
{
    self = [super init];
    if (self) {
        self.items = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(headerViewInController:)]) {
            self.headerView = [self.delegate headerViewInController:self];
            if (self.headerView != nil) {
                [self.view addSubview:self.headerView];
            }
        }
        
        CGFloat offsetYForSegmentedView = ((self.headerView != nil)
                                           ? CGRectGetMaxY(self.headerView.frame)
                                           : 0.0f);
        CGFloat heightForSegmentedView = [self.delegate heightForSegmentedViewInController:self];
        CGRect segmentedViewFrame = CGRectMake(0.0f,
                                               offsetYForSegmentedView,
                                               CGRectGetWidth(self.view.frame),
                                               heightForSegmentedView);
        self.segmentedView = [[UIView alloc] initWithFrame:segmentedViewFrame];
        self.segmentedView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.segmentedView];
        
        if ([self.delegate respondsToSelector:@selector(backgroundImageInController:)]) {
            UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.segmentedView.bounds];
            backgroundImageView.userInteractionEnabled = YES;
            backgroundImageView.image = [self.delegate backgroundImageInController:self];
            [self.segmentedView addSubview:backgroundImageView];
        }
        
        NSInteger numberOfSegments = [self.delegate numberOfSegmentsInController:self];
        CGFloat widthOfSegment = CGRectGetWidth(self.segmentedView.frame) / numberOfSegments;
        for (int i = 0; i < numberOfSegments; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if ([self.delegate respondsToSelector:@selector(segmentedViewController:textForSegmentAtIndex:)]) {
                NSString *text = [self.delegate segmentedViewController:self textForSegmentAtIndex:i];
                if (text != nil) {
                    [button setTitle:text forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; // default
                }
            }
            
            if ([self.delegate respondsToSelector:@selector(segmentedViewController:fontForSegmentAtIndex:)]) {
                UIFont *font = [self.delegate segmentedViewController:self fontForSegmentAtIndex:i];
                if (font != nil) {
                    button.titleLabel.font = font;
                }
            }
            
            if ([self.delegate respondsToSelector:@selector(segmentedViewController:textColorForSegmentAtIndex:)]) {
                UIColor *color = [self.delegate segmentedViewController:self textColorForSegmentAtIndex:i];
                if (color != nil) {
                    [button setTitleColor:color forState:UIControlStateNormal];
                }
            }
            
            if ([self.delegate respondsToSelector:@selector(segmentedViewController:textShadowColorForSegmentAtIndex:)]) {
                UIColor *color = [self.delegate segmentedViewController:self textShadowColorForSegmentAtIndex:i];
                if (color != nil) {
                    [button setTitleShadowColor:color forState:UIControlStateNormal];
                }
            }
            
            if ([self.delegate respondsToSelector:@selector(segmentedViewController:highlightedTextShadowColorForSegmentAtIndex:)]) {
                UIColor *color = [self.delegate segmentedViewController:self highlightedTextShadowColorForSegmentAtIndex:i];
                if (color != nil) {
                    [button setTitleShadowColor:color forState:UIControlStateHighlighted];
                    [button setTitleShadowColor:color forState:UIControlStateSelected];
                }
            }
            
            if ([self.delegate respondsToSelector:@selector(segmentedViewController:highlightedTextColorForSegmentAtIndex:)]) {
                UIColor *color = [self.delegate segmentedViewController:self highlightedTextColorForSegmentAtIndex:i];
                if (color != nil) {
                    [button setTitleColor:color forState:UIControlStateHighlighted];
                    [button setTitleColor:color forState:UIControlStateSelected];
                }
            }
            
            if ([self.delegate respondsToSelector:@selector(segmentedViewController:textShadowOffsetForSegmentAtIndex:)]) {
                CGSize size = [self.delegate segmentedViewController:self textShadowOffsetForSegmentAtIndex:i];
                if (!CGSizeEqualToSize(size, CGSizeZero)) {
                    button.titleLabel.shadowOffset = size;
                }
            }
            
            if ([self.delegate respondsToSelector:@selector(segmentedViewController:imageForSegmentAtIndex:)]) {
                UIImage *image = [self.delegate segmentedViewController:self imageForSegmentAtIndex:i];
                if (image != nil) {
                    [button setImage:image forState:UIControlStateNormal];
                }
            }
            
            if ([self.delegate respondsToSelector:@selector(segmentedViewController:selectedImageForSegmentAtIndex:)]) {
                UIImage *selectedImage = [self.delegate segmentedViewController:self selectedImageForSegmentAtIndex:i];
                if (selectedImage != nil) {
                    [button setImage:selectedImage forState:UIControlStateSelected];
                }
            }
            
            CGSize backgroundImageSize = CGSizeZero;
            if ([self.delegate respondsToSelector:@selector(segmentedViewController:backgroundImageForSegmentAtIndex:)]) {
                UIImage *backgroundImage = [self.delegate segmentedViewController:self backgroundImageForSegmentAtIndex:i];
                if (backgroundImage != nil) {
                    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
                    
                    backgroundImageSize = backgroundImage.size;
                }
            }
            
            if ([self.delegate respondsToSelector:@selector(segmentedViewController:selectedBackgroundImageForSegmentAtIndex:)]) {
                UIImage *selectedBackgroundImage = [self.delegate segmentedViewController:self selectedBackgroundImageForSegmentAtIndex:i];
                if (selectedBackgroundImage != nil) {
                    [button setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
                    [button setBackgroundImage:selectedBackgroundImage forState:UIControlStateHighlighted];
                }
            }
            
            CGFloat heightForButton = ([self.delegate respondsToSelector:@selector(heightForButtonInController:)]
                                       ? [self.delegate heightForButtonInController:self]
                                       : heightForSegmentedView);
            CGFloat widthForButton = ([self.delegate respondsToSelector:@selector(widthForButtonInController:)]
                                      ? [self.delegate widthForButtonInController:self]
                                      : widthOfSegment);
            CGFloat buttonOffsetX = ceilf(CGRectGetWidth(self.view.frame)/2 - (widthForButton * numberOfSegments)/2);
            CGFloat buttonOffsetY = ceilf(heightForSegmentedView/2 - heightForButton/2);
            button.tag = i;
            button.frame = CGRectMake(buttonOffsetX + widthForButton * i,
                                      buttonOffsetY,
                                      widthForButton,
                                      heightForButton);
            [self.segmentedView addSubview:button];
            
            [button addTarget:self action:@selector(didTapSegmentView:) forControlEvents:UIControlEventTouchDown];
            [button addTarget:self action:@selector(didTapSegmentView:) forControlEvents:UIControlEventTouchUpInside];
            [button addTarget:self action:@selector(didTapSegmentView:) forControlEvents:UIControlEventTouchUpOutside];
            [button addTarget:self action:@selector(didTapSegmentView:) forControlEvents:UIControlEventTouchDragOutside];
            [button addTarget:self action:@selector(didTapSegmentView:) forControlEvents:UIControlEventTouchDragInside];
            
            [self.items addObject:button];
        }
    }
    
    CGRect contentViewFrame = CGRectMake(0.0f,
                                         CGRectGetMaxY(self.segmentedView.frame),
                                         CGRectGetWidth(self.view.frame),
                                         [self heightForContentView]);
    self.contentView = [[UIView alloc] initWithFrame:contentViewFrame];
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:self.contentView];
}

- (void)reloadView
{
    UIView *oldView = [self.contentView viewWithTag:kYKSegmentedViewControllerContentSubviewTag];
    if (oldView != nil) {
        [oldView removeFromSuperview];
        oldView = nil;
    }
    
    UIView *view = [self.delegate segmentedViewController:self viewForContentAtIndex:self.selectedSegmentIndex];
    if (view != nil) {
        view.tag = kYKSegmentedViewControllerContentSubviewTag;
        view.frame = self.contentView.bounds;
        view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:view];
    }
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    _selectedSegmentIndex = selectedSegmentIndex;
    [self didTapSegmentView:[self.items objectAtIndex:selectedSegmentIndex]];
}

- (void)didTapSegmentView:(id)sender
{
    UIButton *selectedButton = (UIButton *)sender;
    NSInteger index = selectedButton.tag;
    NSInteger previousIndex = _selectedSegmentIndex;
    _selectedSegmentIndex = index;
    
    for (UIButton *button in self.items) {
        if (button == selectedButton) {
            button.selected = YES;
            button.highlighted = button.selected ? NO : YES;
        } else {
            button.selected = NO;
            button.highlighted = NO;
        }
    }
    
    [self reloadView];
    
    if (previousIndex != _selectedSegmentIndex &&
        self.delegate != nil &&
        [self.delegate respondsToSelector:@selector(segmentedViewController:valueChangedToIndex:)]) {
        [self.delegate segmentedViewController:self valueChangedToIndex:_selectedSegmentIndex];
    }
}

- (CGFloat)heightForContentView
{
    CGFloat contentViewHeight = CGRectGetHeight(self.view.frame);
    if (!self.hidesSegmentedView) {
        contentViewHeight -= CGRectGetHeight(self.segmentedView.frame);
    }
    if (self.headerView != nil) {
        contentViewHeight -= CGRectGetHeight(self.headerView.frame);
    }
    return contentViewHeight;
}

- (void)setHidesSegmentedView:(BOOL)hidesSegmentedView
{
    _hidesSegmentedView = hidesSegmentedView;
    self.segmentedView.hidden = _hidesSegmentedView;
    self.contentView.frame = CGRectMake(0.0f,
                                        !_hidesSegmentedView ? CGRectGetMaxY(self.segmentedView.frame) : 0.0f,
                                        CGRectGetWidth(self.view.bounds),
                                        [self heightForContentView]);
    for (UIView *view in self.contentView.subviews) {
        view.frame = self.contentView.bounds;
    }
}

@end
