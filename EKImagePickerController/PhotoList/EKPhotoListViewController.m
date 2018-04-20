//
//  EKPhotoListViewController.m
//  EKImagePickerController
//
//  Created by lilong on 2018/4/19.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import "EKPhotoListViewController.h"
#import <Photos/Photos.h>
#import "EKPhotoPickerController.h"
#import "EKPhotoListCell.h"
#import "EKImageManager.h"

@interface EKPhotoListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (strong, nonatomic) UIBarButtonItem *cancelBtn;

@property (nonatomic, strong) NSMutableArray *dataArr; // 相册数组


@end

@implementation EKPhotoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = _cancelBtn;
    self.navigationItem.title = @"相册";
    [self createTableView];
    // Do any additional setup after loading the view.
}
- (void)createTableView{
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    _mainTableView.tableFooterView = [UIView new];
    [self.view addSubview:_mainTableView];
    
    self.dataArr = [[[EKImageManager manager] getAllAlbums] mutableCopy];
}
#pragma mark - **************** UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EKPhotoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[EKPhotoListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    [cell loadPhotoListData:[_dataArr objectAtIndex:indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EKPhotoPickerController *photopicker = [EKPhotoPickerController new];
    if (indexPath.row != 0) {
        PHFetchResult *result = [[EKImageManager manager] getFetchResult:_dataArr[indexPath.row]];
        photopicker.fetch = result;
    }
    EKPhotoListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    photopicker.titleStr = cell.title.text;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:photopicker animated:YES];
    
}

-(UIBarButtonItem *)cancelBtn{
    if (_cancelBtn) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
        [button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        _cancelBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
        
    }
    return _cancelBtn;
}
-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSMutableArray *)dataArr{
    if (_dataArr) {
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
