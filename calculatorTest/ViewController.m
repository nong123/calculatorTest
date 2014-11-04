//
//  ViewController.m
//  calculatorTest
//
//  Created by nong on 14/11/3.
//  Copyright (c) 2014年 nong. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "CalculateView.h"
@interface ViewController ()
{
    NSArray *_charArr;
    NSArray *_numberArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"-----");
//显示条
    UILabel *label = [[UILabel alloc] init];
    label.text = @"0";
    label.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      UIEdgeInsets padding =  UIEdgeInsetsMake(30, 10, [[UIScreen mainScreen] bounds].size.height-60, 10);
        make.edges.equalTo(self.view).with.insets(padding);
    }];
    
    NSArray *numberArr = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@".",@"+/-", nil];
    NSArray *matchesArr = [[NSArray alloc] initWithObjects:@"+",@"-",@"*",@"/", nil];
    NSArray *anotherArr = [[NSArray alloc] initWithObjects:@"AC",@"=",@"%",@"Back", nil];
    
    CalculateView *numbersView = [[CalculateView alloc] init];
    numbersView.label = label;
    numbersView.numsArr = [[NSMutableArray alloc] initWithCapacity:2];
    [self.view addSubview:numbersView];
   
    [numbersView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets test = UIEdgeInsetsMake(0, 0, 0, 0);
        make.edges.equalTo(self.view).with.insets(test);
    }];
//数字按键
    [numbersView creatNumbersButton:numberArr];
//运算符:+ - * /
    [numbersView creatMatchesButton:matchesArr];
//功能键
    [numbersView creatAnothersButton:anotherArr];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
