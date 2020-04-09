//
//  QuysIconView.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/27.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysIconView.h"
#import "QuysIconCollectionCell.h"
NSInteger kCellItemSize = 60;
NSInteger kCellSpaceSize = 5;

@interface QuysIconView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UILabel *lblTitle;
@property (nonatomic,strong) UIView *viewStrokeLeftLine;
@property (nonatomic,strong) UIView *viewStrokeRightLine;

@property (nonatomic,strong) UICollectionView *ucVontain;
@property (nonatomic,strong) NSArray *arrSource;
@property (nonatomic,assign) CGFloat ucOffsetX;
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

    UIView *viewStrokeLeftLine = [[UIView alloc]init];
    viewStrokeLeftLine.backgroundColor = kRGB16(kBackgroundColor1, 1);
    [self addSubview:viewStrokeLeftLine];
    self.viewStrokeLeftLine = viewStrokeLeftLine;
    
    UILabel *lblTitle = [[UILabel alloc]init];
    [lblTitle setText:@"快捷登陆"];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lblTitle];
    self.lblTitle = lblTitle;
    
    UIView *viewStrokeRightLine = [[UIView alloc]init];
    viewStrokeRightLine.backgroundColor = kRGB16(kBackgroundColor1, 1);
    [self addSubview:viewStrokeRightLine];
    self.viewStrokeRightLine = viewStrokeRightLine;
    
    
    [self.ucVontain registerClass:[QuysIconCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([QuysIconCollectionCell class])];
    
    [self addSubview:self.ucVontain];
    self.ucVontain.dataSource = self;
    self.ucVontain.delegate = self;
    [self.ucVontain reloadData];
    self.ucOffsetX = [self getUCWidth];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.viewStrokeLeftLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kScale_H(10));
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(self.lblTitle);
    }];
    
    [self.lblTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(kScale_H(10));
        make.left.mas_equalTo(self.viewStrokeLeftLine.mas_right).offset(kScale_H(10));
        make.centerX.mas_equalTo(self);
        
    }];
    
    [self.viewStrokeRightLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblTitle.mas_right).offset(kScale_H(10));
        make.right.mas_equalTo(self).offset(kScale_H(-10));
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(self.lblTitle);
    }];
    
    [self.ucVontain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(kScale_H(10));
        make.left.mas_equalTo(self).offset(self.ucOffsetX).priorityHigh();
        make.right.mas_equalTo(self).priorityLow();
        make.height.mas_equalTo(kScale_W(kCellItemSize));
        make.bottom.mas_lessThanOrEqualTo(self).offset(kScale_H(-5)).priorityHigh();
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
    cell.model = self.arrSource[indexPath.row];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.clickBlock)
    {
        self.clickBlock(indexPath);
    }
}


- (CGFloat)getUCWidth
{
    CGFloat ucLeftAndRighboundary = 2*(10 + 15);
    CGFloat ucWidth = self.arrSource.count * kScale_W(kCellItemSize) + (self.arrSource.count >=1?(self.arrSource.count) - 1:0) * kScale_W(kCellSpaceSize + 1);
    CGFloat ucOffsetX = (kScreenWidth - kScale_W(ucLeftAndRighboundary) - ucWidth)/2.0;
    return ucOffsetX;
}
                                           
    

#pragma mark - Init
- (NSArray *)arrSource
{
    if (_arrSource == nil) {
        QuysIconModel *model1 = [QuysIconModel new];
        model1.iconName = @"";
        model1.iconUrl = @"https://pics5.baidu.com/feed/1ad5ad6eddc451da340d5bc4e5943c60d1163291.jpeg?token=78506abfed90400aa13cd9eddd2e2e35";
        model1.platformName = @"qq";
        model1.platform = WXHThirdPatrPlatformTypeQQ;
        
        QuysIconModel *model2 = [QuysIconModel new];
        model2.iconName = @"";
        model2.iconUrl = @"https://pics3.baidu.com/feed/574e9258d109b3de6192396d9fd60287800a4c72.jpeg?token=293cb341919153024072838cf8ea18ef";
        model2.platformName = @"weixin";
        model2.platform = WXHThirdPatrPlatformTypeWeiXin;
    
        QuysIconModel *model3 = [QuysIconModel new];
        model3.iconName = @"";
        model3.iconUrl = @"https://goss2.cfp.cn/creative/vcg/800/new/VCG211184065628.jpg?x-oss-process=image/format,jpg/interlace,1";
        model3.platformName = @"weixin";
        model3.platform = WXHThirdPatrPlatformTypeWeiXin;
        
        QuysIconModel *model4 = [QuysIconModel new];
        model4.iconName = @"";
        model4.iconUrl = @"https://goss2.cfp.cn/creative/vcg/800/new/VCG211174783632.jpg?x-oss-process=image/format,jpg/interlace,1";
        model4.platformName = @"weixin";
        model4.platform = WXHThirdPatrPlatformTypeWeiXin;
        
        QuysIconModel *model5 = [QuysIconModel new];
        model5.iconName = @"";
        model5.iconUrl = @"https://goss.cfp.cn/creative/vcg/800/new/VCG211181040894.jpg?x-oss-process=image/format,jpg/interlace,1";
        model5.platformName = @"weixin";
        model5.platform = WXHThirdPatrPlatformTypeWeiXin;
        
        _arrSource = @[model1,model2];
    }return _arrSource;
}

- (UICollectionView *)ucVontain
{
    if (_ucVontain == nil) {
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kScale_W(kCellItemSize), kScale_W(kCellItemSize));
        layout.minimumInteritemSpacing = kScale_W(kCellSpaceSize);
        layout.minimumLineSpacing = kScale_W(kCellSpaceSize);
        UICollectionView *ucVontain = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        ucVontain.backgroundColor = [UIColor clearColor];
        _ucVontain = ucVontain;
    }return _ucVontain;
}

@end
