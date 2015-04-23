//
//  BSYScrollView.m
//  循环播放
//
//  Created by mac on 15/4/17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BSYScrollView.h"
@interface BSYScrollView ()
{
    UIView *_BView;
    UIView *_SView;
    UIView *_YView;
    float _viewWidth;
    float _viewHeight;
    NSTimer *_autoScrollTimer;
    UITapGestureRecognizer *_tap;
}
@end
@implementation BSYScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _viewWidth = self.bounds.size.width;
        _viewHeight = self.bounds.size.height;
        //设置scrollview
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _viewWidth, _viewHeight)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(_viewWidth * 3, _viewHeight);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        //设置分页
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _viewHeight-30, _viewWidth, 30)];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pageControl];

        _tap.numberOfTapsRequired = 1;
        _tap.numberOfTouchesRequired = 1;

    }
    return self;
}

#pragma mark 设置imageViewAry
-(void)setImageViewAry:(NSMutableArray *)imageViewAry
{
    if (imageViewAry) {
        _imageViewAry = imageViewAry;
        _currentPage = 0;
        _pageControl.numberOfPages = _imageViewAry.count;
    }
    [self reloadData];
}

#pragma mark 刷新view页面
-(void)reloadData
{
    [_BView removeFromSuperview];
    [_SView removeFromSuperview];
    [_YView removeFromSuperview];
    
    //从数组中取到对应的图片view加到已定义的三个view中
    if (_currentPage==0) {
        _BView = [_imageViewAry lastObject];
        _SView = [_imageViewAry objectAtIndex:_currentPage];
        _YView = [_imageViewAry objectAtIndex:_currentPage+1];
    }
    else if (_currentPage == _imageViewAry.count-1)
    {
        _BView = [_imageViewAry objectAtIndex:_currentPage-1];
        _SView = [_imageViewAry objectAtIndex:_currentPage];
        _YView = [_imageViewAry firstObject];
    }
    else
    {
        _BView = [_imageViewAry objectAtIndex:_currentPage-1];
        _SView = [_imageViewAry objectAtIndex:_currentPage];
        _YView = [_imageViewAry objectAtIndex:_currentPage+1];
    }
    
    //设置三个view的frame，加到scrollview上
    _BView.frame = CGRectMake(0, 0, _viewWidth, _viewHeight);
    _SView.frame = CGRectMake(_viewWidth, 0, _viewWidth, _viewHeight);
    _YView.frame = CGRectMake(_viewWidth*2, 0, _viewWidth, _viewHeight);
    [_scrollView addSubview: _BView];
    [_scrollView addSubview:_SView];
    [_scrollView addSubview:_YView];
    
    //设置当前的分页
    _pageControl.currentPage = _currentPage;
    
    //显示中间页
    _scrollView.contentOffset = CGPointMake(_viewWidth, 0);
}

#pragma mark scrollvie停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //手动滑动时候暂停自动替换
    [_autoScrollTimer invalidate];
    _autoScrollTimer = nil;
    _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoShowNextImage) userInfo:nil repeats:YES];
    
    //得到当前页数
    float x = _scrollView.contentOffset.x;
    
    //往前翻
    if (x<=0) {
        if (_currentPage-1<0) {
            _currentPage = _imageViewAry.count-1;
        }else{
            _currentPage --;
        }
    }
    
    //往后翻
    if (x>=_viewWidth*2) {
        if (_currentPage==_imageViewAry.count-1) {
            _currentPage = 0;
        }else{
            _currentPage ++;
        }
    }
    
    [self reloadData];
}

#pragma mark 自动滚动
-(void)shouldAutoShow:(BOOL)shouldStart
{
    if (shouldStart)  //开启自动翻页
    {
        if (!_autoScrollTimer) {
            _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoShowNextImage) userInfo:nil repeats:YES];
        }
    }
    else   //关闭自动翻页
    {
        if (_autoScrollTimer.isValid) {
            [_autoScrollTimer invalidate];
            _autoScrollTimer = nil;
        }
    }
}

#pragma mark 展示下一页
-(void)autoShowNextImage
{
    if (_currentPage == _imageViewAry.count-1) {
        _currentPage = 0;
    }else{
        _currentPage ++;
    }
    
    [self reloadData];
}

@end
