//
//  EKPhotoPreviewController.m
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import "EKPhotoPreviewController.h"
#import "UIView+EKValue.h"
#import "EKPhotoPreviewCell.h"

@interface EKPhotoPreviewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;// 展示区
@property (nonatomic, strong) UIView *toolBar;
@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, assign) NSUInteger index;
@end

@implementation EKPhotoPreviewController

- (instancetype)initWithPhotos:(NSArray *)photos atIndex:(NSUInteger)index{
    if (self = [super init]) {
        _photos = photos;
        _index = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configCollectionView];
    [self configBottomToolBar];
    // Do any additional setup after loading the view.
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.view.ek_width, self.view.ek_height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.ek_width , self.view.ek_height) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor blackColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.scrollsToTop = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.contentOffset = CGPointMake(self.view.ek_width * _index, 0);
    _collectionView.contentSize = CGSizeMake(self.photos.count * (self.view.ek_width), 0);
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[EKPhotoPreviewCell class] forCellWithReuseIdentifier:@"EKPhotoPreviewCell"];
}

- (void)configBottomToolBar {
    _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.ek_height - 44, self.view.ek_width, 44)];
    static CGFloat rgb = 34 / 255.0;
    _toolBar.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.7];
    
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneButton.frame = CGRectMake(self.view.ek_width - 44 - 12, 0, 44, 44);
    _doneButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_toolBar addSubview:_doneButton];

    [self.view addSubview:_toolBar];
}

- (void)doneButtonClick {
    if (self.doneBlock) {
        self.doneBlock(_photos);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UICollectionViewDataSource && Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photos.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EKPhotoPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EKPhotoPreviewCell" forIndexPath:indexPath];
    cell.asset = _photos[indexPath.row];
    
    if (!cell.singleTapGestureBlock) {
        __weak typeof(_toolBar) weakToolBar = _toolBar;
        cell.singleTapGestureBlock = ^(){
            weakToolBar.hidden = !weakToolBar.hidden;
        };
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[EKPhotoPreviewCell class]]) {
        [(EKPhotoPreviewCell *)cell recoverSubviews];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[EKPhotoPreviewCell class]]) {
        [(EKPhotoPreviewCell *)cell recoverSubviews];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
