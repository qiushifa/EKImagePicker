//
//  EKPhotoPickerController.m
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import "EKPhotoPickerController.h"
#import "UIView+EKValue.h"
#import "EKAssetCell.h"
#import "EKImageManager.h"
#import "EKPreview/EKPhotoPreviewController.h"


@interface EKPhotoPickerController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *previewBtn;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIView *toolBar;
@property (nonatomic, strong) NSMutableArray *dataArr; // 所有照片数组
@property (nonatomic, strong) NSMutableArray *selectedPhotoArr; // 已选的照片数组
@end

@implementation EKPhotoPickerController

- (instancetype)init{
    if (self = [super init]) {
        _columnNumber = 4;
        _margin = 5;
        _scrollBottom = YES;
        
    }
    return  self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self scrollCollectionViewToBottom];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.titleStr;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonClick)];
    self.selectedPhotoArr = [NSMutableArray array];
    [self configCollectionView];
    [self configBottomToolBar];
    [self getAllPhotos];
    
    // Do any additional setup after loading the view.
}


- (void)getAllPhotos{
    PHFetchResult *result = self.fetch ? self.fetch : [[EKImageManager manager] getCameraRollFetchResult];
    NSArray *arr = [[EKImageManager manager] getPhotoAssets:result assetType:PHAssetMediaTypeImage];
//    for (PHAsset *item in arr) {
//        EKAsset *model = (EKAsset *)[PHAsset new];
//        model.selected = NO;
//        [self.dataArr addObject:model];
//        
//    }
    [self.dataArr addObjectsFromArray:arr];

    [self.collectionView reloadData];
    
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWH = (self.view.ek_width - (self.columnNumber + 1) * _margin) / self.columnNumber;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    
    CGFloat top = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, top, self.view.ek_width, self.view.ek_height - top - 50) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.alwaysBounceHorizontal = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(_margin, _margin, _margin, _margin);
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[EKAssetCell class] forCellWithReuseIdentifier:@"EKAssetCell"];

}
- (void)configBottomToolBar{
    
    self.toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.ek_height - 50, self.view.ek_width, 50)];
    _toolBar.backgroundColor = [UIColor whiteColor];
    
    self.previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _previewBtn.frame = CGRectMake(10, 3, 80, 44);
    _previewBtn.enabled = NO;
    [_previewBtn addTarget:self action:@selector(previewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _previewBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_previewBtn setTitle:@"预览" forState:UIControlStateNormal];
    [_previewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_previewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_toolBar addSubview:_previewBtn];
    
    self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneButton.frame = CGRectMake(self.view.ek_width - 44 - 12, 3, 44, 44);
    _doneButton.enabled = NO;
    _doneButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_toolBar addSubview:_doneButton];
    
    [self.view addSubview:_toolBar];
    
}

#pragma mark - UICollectionViewDataSource && Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EKAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EKAssetCell" forIndexPath:indexPath];
    cell.selectBtn.tag = indexPath.row;
    [cell.selectBtn addTarget:self action:@selector(selectPicBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell loadPhotoData:[self.dataArr objectAtIndex:indexPath.row]];
    [cell selectBtnStage:self.selectedPhotoArr existence:[self.dataArr objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark -  选中的在数组中添加，取消的从数组中减少
-(void)selectPicBtn:(UIButton *)button{
    NSInteger index = button.tag;
    if (button.selected == NO) {
        self.previewBtn.enabled = YES;
        self.doneButton.enabled = YES;
        if (self.selectedPhotoArr.count + 1 > _maxCount) {
            [self showSelectPhotoAlertView:_maxCount];
        }else{
            [self.selectedPhotoArr addObject:[self.dataArr objectAtIndex:index]];
            [button setImage:[UIImage imageNamed:@"select_yes"] forState:UIControlStateNormal];
            button.selected = YES;
        }
    }else{
        if (self.selectedPhotoArr.count - 1 < 1) {
            self.previewBtn.enabled = NO;
            self.doneButton.enabled = NO;
        }

        [self.selectedPhotoArr removeObject:[self.dataArr objectAtIndex:index]];
        [button setImage:[UIImage imageNamed:@"select_no"] forState:UIControlStateNormal];
        button.selected = NO;
    }
}
-(void)showSelectPhotoAlertView:(NSInteger)photoNumOfMax {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"最多只能选择%ld张图片",(long)photoNumOfMax]preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    EKPhotoPreviewController *preview = [[EKPhotoPreviewController alloc] initWithPhotos:self.dataArr atIndex:indexPath.row];
    [self.navigationController pushViewController:preview animated:YES];
    
}

#pragma mark - 滚动到底部
- (void)scrollCollectionViewToBottom {
    if (_scrollBottom && _dataArr.count > 0) {
        NSInteger item = _dataArr.count - 1;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
        _scrollBottom = NO;
    }
}

// 完成按钮
- (void)doneButtonClick{
    if (self.selectedPhotos) {
        self.selectedPhotos(self.selectedPhotoArr);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 预览按钮
- (void)previewButtonClick{
    EKPhotoPreviewController *preview = [[EKPhotoPreviewController alloc] initWithPhotos:self.selectedPhotoArr atIndex:0];
    [self.navigationController pushViewController:preview animated:YES];
}
// 取消按钮
- (void)cancelButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
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
