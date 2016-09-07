//
//  DJGetPicture.m
//  DJGetPicture
//
//  Created by ii on 16/9/7.
//  Copyright © 2016年 金色麦垛. All rights reserved.
//

#import "DJGetPicture.h"

#define AppRootView  ([[[[[UIApplication sharedApplication] delegate] window] rootViewController] view])
#define AppRootViewController  ([[[[UIApplication sharedApplication] delegate] window] rootViewController])

#define kALERTTITLE @"设置图像"
#define kNOTSUPPORTCAMERAL @"设备不支持访问相册，请在设置->隐私->相机中进行设置！"
#define kNOTSUPPORTALBUM @"设备不支持访问相册，请在设置->隐私->照片中进行设置！"

@implementation DJGetPicture

+ (DJGetPicture *)sharedManager {
    static DJGetPicture *sharedManager = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

+ (void)shareGetPicture:(getPictureBlock)block {
    
    DJGetPicture *getPicture = [DJGetPicture sharedManager];
    
    getPicture.pictureBlock = block;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:kALERTTITLE message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertAction *CameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *CameraAction){
            [getPicture openCamera];
        }];
        [alertController addAction:CameraAction];
    }
    
    UIAlertAction *ImageAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *ImageAction){
        [getPicture openAlbum];
    }];
    [alertController addAction:ImageAction];
    
    [AppRootViewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Camera
- (void)openCamera {
    DJGetPicture *getPicture = [DJGetPicture sharedManager];
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限
        [getPicture showAlertViewWithTitel:kNOTSUPPORTCAMERAL];
        
    }else{
        // 相机 UIImagePickerControllerSourceTypeCamera
        [getPicture setImagePickerControllerWith:UIImagePickerControllerSourceTypeCamera];
    }
}

#pragma mark - Album
- (void)openAlbum {
    DJGetPicture *getPicture = [DJGetPicture sharedManager];
    
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied)
    {
        //无权限
        [getPicture showAlertViewWithTitel:kNOTSUPPORTALBUM];
        
    }else{
        // 相册 UIImagePickerControllerSourceTypePhotoLibrary,UIImagePickerControllerSourceTypeSavedPhotosAlbum
        [getPicture setImagePickerControllerWith:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    DJGetPicture *getPicture = [DJGetPicture sharedManager];
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [getPicture pictureBlock](image);
}

#pragma mark - showAlertView
- (void)showAlertViewWithTitel:(NSString *)title{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    [alertController addAction:cancelAction];
    [AppRootViewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - ImagePickerController
- (void)setImagePickerControllerWith:(UIImagePickerControllerSourceType)type {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = [DJGetPicture sharedManager];
    imagePicker.sourceType = type;
    imagePicker.allowsEditing = YES;
    
    [AppRootViewController presentViewController:imagePicker animated:YES completion:nil];
}
@end
