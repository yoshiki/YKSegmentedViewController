//
//  SegmentedViewController.m
//  YKSegmentedViewControllerDemo
//
//  Created by Yoshiki Kurihara on 2014/02/03.
//  Copyright (c) 2014年 Yoshiki Kurihara. All rights reserved.
//

#import "SegmentedViewController.h"

@interface SegmentedViewController ()

@property (nonatomic, strong) NSArray *views;

@end

@implementation SegmentedViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }

    UITableView *view1 = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    view1.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight;
    view1.backgroundColor = [UIColor greenColor];
    view1.delegate = self;
    view1.dataSource = self;
    
    UIView *view2 = [[UIView alloc] initWithFrame:self.view.bounds];
    view2.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight;
    view2.backgroundColor = [UIColor orangeColor];
    
    UIView *view3 = [[UIView alloc] initWithFrame:self.view.bounds];
    view3.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight;
    view3.backgroundColor = [UIColor blueColor];
    
    _views = @[ view1, view2, view3 ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Demo";
    
    self.selectedSegmentIndex = 0;
}

#pragma mark - YKSegmentedViewControllerDelegate

- (NSInteger)numberOfSegmentsInController:(YKSegmentedViewController *)controller
{
    return _views.count;
}

- (CGFloat)heightForSegmentedViewInController:(YKSegmentedViewController *)controller
{
    return 44.0f;
}

- (UIView *)segmentedViewController:(YKSegmentedViewController *)controller viewForContentAtIndex:(NSInteger)index
{
    return _views[index];
}

- (NSString *)segmentedViewController:(YKSegmentedViewController *)controller textForSegmentAtIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"View%d", index];
}

- (UIColor *)segmentedViewController:(YKSegmentedViewController *)controller highlightedTextColorForSegmentAtIndex:(NSInteger)index
{
    return [UIColor whiteColor];
}

- (UIImage *)segmentedViewController:(YKSegmentedViewController *)controller selectedBackgroundImageForSegmentAtIndex:(NSInteger)index
{
    return [UIImage imageNamed:@"bg"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
