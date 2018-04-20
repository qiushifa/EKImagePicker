//
//  EKPhotoListCell.m
//  EKImagePickerController
//
//  Created by lilong on 2018/4/20.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import "EKPhotoListCell.h"

@implementation EKPhotoListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUILayout];
    }
    return self;
}

-(void)setUILayout{
    CGFloat jianGe = 5;
    CGFloat image_W_H = 60;
    
    _coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(2 * jianGe, jianGe, image_W_H, image_W_H)];
    _coverImage.layer.masksToBounds = YES;
    _coverImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_coverImage];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(_coverImage.frame.size.width + _coverImage.frame.origin.x + 10, 20, 100, 30)];
    _title.textColor = [UIColor blackColor];
    [self.contentView addSubview:_title];
    
    _subTitle = [[UILabel alloc]initWithFrame:CGRectMake(_title.frame.size.width + _title.frame.origin.x + 10, 20, 80, 30)];
    _subTitle.textColor = [UIColor blackColor];
    [self.contentView addSubview:_subTitle];
    
    CGFloat right = [UIScreen mainScreen].bounds.size.width;
    UIImageView *right_Cell = [[UIImageView alloc]initWithFrame:CGRectMake(right - 50, 25, 9, 20)];
    right_Cell.image = [UIImage imageNamed:@"rightCell"];
    [self.contentView addSubview:right_Cell];
}

-(void)loadPhotoListData:(PHAssetCollection *)assetItem{
    if ([assetItem isKindOfClass:[PHAssetCollection class]]) {
        PHFetchResult *group = [PHAsset fetchAssetsInAssetCollection:assetItem options:nil];
        [[PHImageManager defaultManager]requestImageForAsset:[group lastObject] targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result == nil) {
                self.coverImage.image = [UIImage imageNamed:@"no_data"];
            }else{
                self.coverImage.image = result;
            }
        }];
        PHAssetCollection *titleAsset = assetItem;
        if ([titleAsset.localizedTitle isEqualToString:@"All Photos"]) {
            self.title.text = @"相机胶卷";
        }else{
            self.title.text = [NSString stringWithFormat:@"%@",titleAsset.localizedTitle];
        }
        self.subTitle.textColor = [UIColor lightGrayColor];
        self.subTitle.text = [NSString stringWithFormat:@"(%lu)",(unsigned long)group.count];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
