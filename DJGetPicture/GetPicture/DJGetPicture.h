//
//  DJGetPicture.h
//  DJGetPicture
//
//  Created by ii on 16/9/7.
//  Copyright © 2016年 金色麦垛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef void (^getPictureBlock)(UIImage *image);

@interface DJGetPicture : NSObject <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,copy)getPictureBlock pictureBlock;

+ (DJGetPicture *)sharedManager;

+ (void)shareGetPicture:(getPictureBlock)block;

@end
