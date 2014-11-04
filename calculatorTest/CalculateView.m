//
//  CalculateView.m
//  calculatorTest
//
//  Created by nong on 14/11/4.
//  Copyright (c) 2014年 nong. All rights reserved.
//

#import "CalculateView.h"
#import "Masonry.h"
#import <BlocksKit+UIKit.h>
@implementation CalculateView
//创建number
- (void)creatNumbersButton:(NSArray *)arr
{
    for (int i = 0; i<[arr count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        CGFloat baseNum = [[UIScreen mainScreen] bounds].size.width/5;
        [self addSubview:button];
        UIEdgeInsets temp = UIEdgeInsetsMake(baseNum + baseNum*(i/3),  baseNum*(i%3), 6.5*baseNum-baseNum*(i/3), 4*baseNum - baseNum*(i%3));
        //加button约束
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(temp);
        }];
        //添加事件
        [button bk_addEventHandler:^(id sender) {
             NSString *string = self.label.text;
            // .
            if (i == 10) {
                if (pointIdentify == 0) {
                    self.label.text = [string stringByAppendingString:button.titleLabel.text];
                    pointIdentify++;
                }
            }
            // +/-
            if (i == 11 &&![string isEqualToString:@"0"]) {
                if (PMIdentify == 0) {
                    self.label.text = [@"-" stringByAppendingString:self.label.text];
                    PMIdentify++ ;
                }else {
                    self.label.text = [self.label.text substringFromIndex:1];
                    PMIdentify = 0;
                }
            }
            // s
            if (i != 10 && i != 11) {
                if ([string isEqualToString:@"0"]) {
                    self.label.text = button.titleLabel.text;
                }else {
                    self.label.text = [string stringByAppendingString:button.titleLabel.text];
                }
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
}

static int matchIndex = 0;

//创建运算符
- (void)creatMatchesButton:(NSArray *)arr
{
    for (int i = 0; i<[arr count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        CGFloat baseNum = [[UIScreen mainScreen] bounds].size.width/5;
        [self addSubview:button];
        UIEdgeInsets temp = UIEdgeInsetsMake(baseNum + baseNum*i,  baseNum*3, 6.5*baseNum-baseNum*i, baseNum);
        //加button约束
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(temp);
        }];
        //加点击事件
        [button bk_addEventHandler:^(id sender) {
        if (clickIdentify == 0) {
            [self.numsArr addObject:self.label.text];
            clickIdentify ++;
            NSLog(@"---first");
            matchIndex = i;
            self.label.text = @"";
        } else {
            [self.numsArr addObject:self.label.text];
            self.label.text = @"";
            NSLog(@"+++second");
            matchIndex = i;
            [self doMatchesWithIndex:i];
        }
        } forControlEvents:UIControlEventTouchUpInside];
    }
}
//功能键
- (void)creatAnothersButton:(NSArray *)arr
{
    for (int i = 0; i<[arr count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        CGFloat baseNum = [[UIScreen mainScreen] bounds].size.width/5;
        [self addSubview:button];
        UIEdgeInsets temp = UIEdgeInsetsMake(baseNum + baseNum*i,  baseNum*4, 6.5*baseNum-baseNum*i, 0);
        //加button约束
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(temp);
        }];
        //加事件
        [button bk_addEventHandler:^(id sender) {
            CGFloat num = [self.label.text floatValue];
            switch (i) {
                case 0:
                    self.label.text = @"0";
                    pointIdentify = 0;
                    PMIdentify = 0;
                    clickIdentify = 0;
                    [self.numsArr removeAllObjects];
                    break;
                case 1:
                    [self.numsArr addObject:self.label.text];
                    self.label.text = @"";
                    [self doMatchesWithIndex:matchIndex];
                    break;
                case 2:
                    self.label.text = [NSString stringWithFormat:@"%.4f",num/100.00];
                    break;
                case 3:
                    if ([self.label.text length] == 1 ||([self.label.text length] <=2 && PMIdentify !=0)) {
                        self.label.text = @"0";
                        pointIdentify = 0;
                        PMIdentify = 0;
                        clickIdentify = 0;
                    }else {
                        self.label.text = [self.label.text substringToIndex:[self.label.text length]-1];
                            }
                    break;
                default:
                    break;
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }

}
//做运算
- (void)doMatchesWithIndex:(int )i
{
    NSLog(@"--%d",i);
    switch (i) {
        case 0:
            self.label.text = [NSString stringWithFormat:@"%f",[[self.numsArr objectAtIndex:0] floatValue] + [[self.numsArr objectAtIndex:1] floatValue]];
            break;
        case 1:
            self.label.text = [NSString stringWithFormat:@"%f",[[self.numsArr objectAtIndex:0] floatValue] - [[self.numsArr objectAtIndex:1] floatValue]];
            break;
        case 2:
            self.label.text = [NSString stringWithFormat:@"%f",[[self.numsArr objectAtIndex:0] floatValue] * [[self.numsArr objectAtIndex:1] floatValue]];
            break;
        case 3:
            self.label.text = [NSString stringWithFormat:@"%f",[[self.numsArr objectAtIndex:0] floatValue] / [[self.numsArr objectAtIndex:1] floatValue]];
            break;
        default:
            break;
    }
    
    [self.numsArr removeObjectAtIndex:0];
}
static int pointIdentify = 0;
//正负
static int PMIdentify = 0;
//是否第一次点击运算符
static int clickIdentify = 0;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
