//
//  BSYScrollView.h
//  循环播放
//
//  Created by mac on 15/4/17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSYScrollViewDelegate;
@interface BSYScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, weak) id <BSYScrollViewDelegate> delegate;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *imageViewAry;

@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, readonly) UIPageControl *pageControl;

-(void)BSYShouldAutoShow:(BOOL)shouldStart;
@end
@protocol WHcrollViewViewDelegate <NSObject>
@optional
- (void)BSYDidClickPage:(BSYScrollView *)view atIndex:(NSInteger)index;

@end
