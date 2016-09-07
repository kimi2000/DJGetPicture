//
//  ViewController.m
//  DJGetPicture
//
//  Created by ii on 16/9/7.
//  Copyright © 2016年 金色麦垛. All rights reserved.
//  https://github.com/kimi2000/DJGetPicture

#import "ViewController.h"
#import "DJGetPicture.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *pictureBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pictureBtn:(UIButton *)sender {
    
    [DJGetPicture shareGetPicture:^(UIImage *HeadImage){
        
        [self.pictureBtn setBackgroundImage:HeadImage forState:UIControlStateNormal];
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
