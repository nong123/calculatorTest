//
//  CalculateView.h
//  calculatorTest
//
//  Created by nong on 14/11/4.
//  Copyright (c) 2014年 nong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculateView : UIView

@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)NSMutableArray *numsArr;

- (void)creatNumbersButton:(NSArray *)arr;
- (void)creatMatchesButton:(NSArray *)arr;
- (void)creatAnothersButton:(NSArray *)arr;
@end
