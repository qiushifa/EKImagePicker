//
//  ViewController.m
//  EKImagePickerController
//
//  Created by lilong on 2018/4/17.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "EKPhotoPreviewController.h"
#import "EKPhotoPickerController.h"
#import "EKImageManager.h"
#import "EKPhotoListViewController.h"
#import "EKPhotoController.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *view1;
@property (weak, nonatomic) IBOutlet UIImageView *view2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)picker:(UIButton *)sender {

//    EKPhotoPickerController *picker = [EKPhotoPickerController new];
//
//    [self presentViewController:picker animated:YES completion:nil];
    
//    EKPhotoListViewController *list = [EKPhotoListViewController new];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:list];
//    [self presentViewController:nav animated:YES completion:nil];
    EKPhotoController *cont = [EKPhotoController new];
    cont.selectPhotoOfMax = 5;
    [cont showIn:self result:^(id responseObject) {
        
    }];

    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
