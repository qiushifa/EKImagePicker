//
//  EKPhotoController.m
//  EKImagePickerController
//
//  Created by lilong on 2018/4/20.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import "EKPhotoController.h"
#import "EKPhotoListViewController.h"
#import "EKPhotoPickerController.h"

@interface EKPhotoController()
@property (nonatomic, strong) EKPhotoListViewController *listVC;
@property (nonatomic, strong) EKPhotoPickerController *pickerVC;
@property (nonatomic, strong) UINavigationController *naviVC;
@end

@implementation EKPhotoController

- (void)showIn:(UIViewController *)controller result:(EKPhotoResult)result{
    //相册权限判断
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) {
        //相册权限未开启
        [self showAlertViewToController:controller];
        
    }else if(status == PHAuthorizationStatusNotDetermined){
        //相册进行授权
        /* * * 第一次安装应用时直接进行这个判断进行授权 * * */
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
            //授权后直接打开照片库
            if (status == PHAuthorizationStatusAuthorized){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showController:controller result:result];
                });
                
            }
        }];
    }else if (status == PHAuthorizationStatusAuthorized){
        [self showController:controller result:result];
    }
}

-(void)showController:(UIViewController *)controller result:(EKPhotoResult)result {
    //授权完成，打开相册
    
    self.listVC.photoResult = result;
    [self showPhotoList:controller];
    

    self.pickerVC.selectedPhotos = result;
    self.pickerVC.maxCount = _selectPhotoOfMax;
    [self showPhotoPicker:self.listVC.navigationController];
}
-(void)showPhotoList:(UIViewController *)controller {
    [controller presentViewController:self.naviVC animated:YES completion:nil];
}

-(void)showPhotoPicker:(UINavigationController *)navigationController {
    //此处注意Animated == NO，关闭动画效果。则直接进入了详细页面。
    [navigationController pushViewController:self.pickerVC animated:NO];
}

-(void)showAlertViewToController:(UIViewController *)controller {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"请在iPhone的“设置->隐私->照片”开启%@访问你的手机相册",app_Name] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    
    [alert addAction:action1];
    [controller presentViewController:alert animated:YES completion:nil];
}

- (EKPhotoListViewController *)listVC{
    if (!_listVC) {
        _listVC = [EKPhotoListViewController new];
    }
    return _listVC;
}
- (EKPhotoPickerController *)pickerVC{
    if (!_pickerVC) {
        _pickerVC = [EKPhotoPickerController new];
    }
    return _pickerVC;
}
- (UINavigationController *)naviVC{
    if (!_naviVC) {
        _naviVC = [[UINavigationController alloc] initWithRootViewController:_listVC];
    }
    return _naviVC;
}
@end
