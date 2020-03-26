//
//  ViewController.m
//  ZXSwitch
//
//  Created by mac on 2020/3/26.
//  Copyright © 2020 my. All rights reserved.
//

#import "ViewController.h"
#import "ZXSwitchView.h"
#import "ChildViewController.h"
@interface ViewController ()<ZXSwitchViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) ZXSwitchView *switchView;
@property (nonatomic, strong) UIScrollView *scroller;
@property (nonatomic, strong) NSMutableDictionary *vDict;
@property (nonatomic, strong) NSArray *classArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.switchView];
    
    [self.view addSubview:self.scroller];
    
    _classArr = @[@{@"name":@"第一页",@"key":@"1",@"color":[UIColor redColor]},
                  @{@"name":@"第二十页",@"key":@"20",@"color":[UIColor yellowColor]},
                  @{@"name":@"第三十三页",@"key":@"33",@"color":[UIColor blueColor]},
                  @{@"name":@"第四页",@"key":@"4",@"color":[UIColor greenColor]},
                  @{@"name":@"第5页",@"key":@"5",@"color":[UIColor lightGrayColor]},
                  @{@"name":@"第6页",@"key":@"6",@"color":[UIColor orangeColor]},
                  @{@"name":@"第70页",@"key":@"70",@"color":[UIColor grayColor]},
                  @{@"name":@"第800页",@"key":@"800",@"color":[UIColor brownColor]}];
    
    self.switchView.classes = _classArr;
        
    self.scroller.contentSize=CGSizeMake( self.view.frame.size.width*_classArr.count , 0 );
    
    [self creatChildView:0];
    
}

- (ZXSwitchView *)switchView{
    if (!_switchView) {
        _switchView = [[ZXSwitchView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
        _switchView.delegate = self;
        _switchView.textColor = [UIColor blackColor];
        _switchView.hiddenRedLine = YES;
    }
    return _switchView;
}

- (UIScrollView *)scroller{
    if (!_scroller) {
        _scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height  - 60)];
        _scroller.pagingEnabled = YES;
        _scroller.directionalLockEnabled = YES;
        _scroller.bounces = NO;
        _scroller.delegate = self;
    }
    return _scroller;
}

- (void)didSelect:(NSInteger)index{
    
    [self creatChildView:index];
    CGFloat point = self.view.frame.size.width * index;
    [_scroller setContentOffset:CGPointMake(point,0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat pageWidth = scrollView.frame.size.width;
    
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self creatChildView:page];
    
    [self.switchView setCurrentView:page];
}

- (void)creatChildView:(NSInteger)index{
  
    NSDictionary *dic = _classArr[index];
    
    NSString *key = dic[@"key"];
    
    ChildViewController *vc = self.vDict[key];
     
    
    if (!vc) {

       
        vc = [[ChildViewController alloc]init];
        
        vc.viewColor = dic[@"color"];
              
        [self addChildViewController:vc];
       
        [self.vDict setObject:vc forKey:key];
     
        vc.view.frame = CGRectMake(index * self.view.frame.size.width, 0, self.view.frame.size.width, _scroller.frame.size.height);
       
        [_scroller addSubview:vc.view];
     }
    
}

- (NSMutableDictionary *)vDict{
    if (!_vDict) {
        _vDict = [NSMutableDictionary dictionary];
    }
    return _vDict;
}

@end
