//
//  EKImageView.m
//  EKImagePickerController
//
//  Created by lilong on 2018/4/23.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import "EKImageView.h"
#import "EKCollectionViewCell.h"
#import "UIView+EKValue.h"
#import "EKPhotoController.h"
#import <Photos/Photos.h>
#import "EKImageManager.h"
#import "EKPhotoPreviewController.h"
@interface EKImageView ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) NSArray *dataArr;

@property (assign, nonatomic) CGFloat itemWH;
@property (assign, nonatomic) NSUInteger everyRowCount; //view每行照片数
@property (assign, nonatomic) CGFloat margin;  //已选图片页面Cell的间距
@property (assign, nonatomic) UIEdgeInsets contentInsets; //collectionView的edge配置
@end
@implementation EKImageView

- (instancetype)initWithFrame:(CGRect)frame withPhotos:(NSArray *)photos{
    if (self = [super initWithFrame:frame]) {
        self.allPhotos = [photos mutableCopy];
        _everyRowCount = 4;
        _margin = 12;
        _maxPhotosCount = 9;
        [self configCollectionView];
    }
    return self;
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    _itemWH = self.ek_width / _everyRowCount - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.ek_width, self.ek_height) collectionViewLayout:layout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = _contentInsets;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled = NO;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[EKCollectionViewCell class] forCellWithReuseIdentifier:@"EKCollectionViewCell"];
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(_allPhotos.count < _maxPhotosCount) {
        return _allPhotos.count + 1;
    }else {
        return _allPhotos.count  ;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EKCollectionViewCell" forIndexPath:indexPath];
    
    if(_allPhotos.count < _maxPhotosCount) {
        if (indexPath.row == _allPhotos.count) {
            [cell.imageThumbnail setImage:[UIImage imageNamed:@"add_camera"]];
            cell.imageThumbnail.layer.borderWidth = 0;
            cell.nookDeleteBtn.hidden = YES;
            
        } else {
            cell.imageThumbnail.image = _allPhotos[indexPath.row];
            cell.imageThumbnail.layer.borderWidth = 0;
            cell.nookDeleteBtn.hidden = NO;
        }
        
    }else {
        cell.imageThumbnail.image = _allPhotos[indexPath.row];
        cell.imageThumbnail.layer.borderWidth = 0;
        cell.nookDeleteBtn.hidden = NO;
    }
    
    cell.nookDeleteBtn.tag = indexPath.row;
    [cell.nookDeleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _allPhotos.count) {
        [self pushImagePickerController];
    } else {//预览照片
       
        
    };
}

#pragma mark - 图片选择器
- (void)pushImagePickerController {
    if (self.maxPhotosCount <= 0) {
        return;
    }
    EKPhotoController *cont = [EKPhotoController new];
    cont.selectPhotoOfMax = 5;
    [cont showIn:self.navcDelegate result:^(id responseObject) {
        NSMutableArray *temp = [@[] mutableCopy];
        for (PHAsset *asset in responseObject) {
            [[EKImageManager manager] getImageObject:asset complection:^(UIImage *image, BOOL isDegraded) {
                [temp addObject:image];
            }];
        }
        self.selectedPhotosBlock(temp);
    }];
    
    
}

#pragma mark - DeleteBtn
- (void)deleteBtnClik:(UIButton *)sender {
    [_allPhotos removeObjectAtIndex:sender.tag];
    if(_allPhotos.count == _maxPhotosCount - 1){
        [_collectionView reloadData];
    }else{
        __weak typeof(self)weakSelf = self;
        [_collectionView performBatchUpdates:^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
            [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        } completion:^(BOOL finished) {
            [weakSelf.collectionView reloadData];
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
