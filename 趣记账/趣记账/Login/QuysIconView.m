//
//  QuysIconView.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/27.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysIconView.h"
#import "QuysIconCollectionCell.h"
@interface QuysIconView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UILabel *lblTitle;
@property (nonatomic,strong) UIView *viewStrokeLine;
@property (nonatomic,strong) UICollectionView *ucVontain;
@property (nonatomic,strong) NSArray *arrSource;

@end


@implementation QuysIconView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UILabel *lblTitle = [[UILabel alloc]init];
    lblTitle.backgroundColor = [UIColor clearColor];
    [lblTitle setText:@"  快捷登陆  "];//添加空格 制造遮罩现象
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lblTitle];
    self.lblTitle = lblTitle;
    
    UIView *viewStrokeLine = [[UIView alloc]init];
    viewStrokeLine.backgroundColor = kRGB16(kBackgroundColor1, 1);
    [self addSubview:viewStrokeLine];
    self.viewStrokeLine = viewStrokeLine;
    
    [self.ucVontain registerClass:[QuysIconCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([QuysIconCollectionCell class])];
    
    [self addSubview:self.ucVontain];
    self.ucVontain.dataSource = self;
    self.ucVontain.delegate = self;
    
}

- (void)updateConstraints
{

    [self.viewStrokeLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(kScale_H(10));
        make.left.mas_equalTo(self).offset(kScale_H(10));
        make.right.mas_equalTo(self).offset(kScale_H(-10));
        make.height.mas_equalTo(1);
    }];
    
    [self.lblTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self.viewStrokeLine);
    }];
    
    [self.ucVontain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(kScale_H(10));
        make.left.mas_equalTo(self).offset(kScale_H(5));
        make.right.mas_equalTo(self).offset(kScale_H(-5));
        make.bottom.mas_equalTo(self).offset(kScale_H(-10));
    }];
    
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QuysIconCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([QuysIconCollectionCell class]) forIndexPath:indexPath];
    return cell;
     
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    //TODO
    
}


#pragma mark - Init
- (NSArray *)arrSource
{
    if (_arrSource == nil) {
         _arrSource = [NSArray new];
    }return _arrSource;
}

- (UICollectionView *)ucVontain
{
    if (_ucVontain == nil) {
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *ucVontain = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
         _ucVontain = ucVontain;
    }return _ucVontain;
}

@end
