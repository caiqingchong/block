//
//  ViewController.m
//  NSThread
//
//  Created by Apple on 15/12/29.
//  Copyright © 2015年 mcas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIImageView *imageView ;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeSystem];
    but1.frame = CGRectMake(0, 0, 320, 40);
    but1.tag = 1;
    [but1 setTitle:@"开启线程" forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    but1.backgroundColor = [UIColor redColor];
    [self.view addSubview:but1];
    
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    but.frame = CGRectMake(0, 50, 320, 40);
    but.tag = 2;
    [but setTitle:@"不开线程" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    but.backgroundColor = [UIColor redColor];
    [self.view addSubview:but];

    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 320, 300)];
    imageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:imageView];
    
}

- (void)click:(UIButton *)sender
{
    if(sender.tag == 1){
        NSString *string = @"http://v1.qzone.cc/pic/201407/13/11/05/53c1f77cdbd01600.jpg%21600x600.jpg";
        NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(downLoad:) object:string];
        [thread start];
    }else{
    NSString *string = @"http://img5.duitang.com/uploads/item/201410/13/20141013134718_YkBJh.thumb.700_0.jpeg";
        [self downLoad:string];

    }

}

- (void)downLoad:(NSString *)string{
    NSLog(@"分线程----%@",[NSThread currentThread]);
    NSURL *url=[NSURL  URLWithString:string];
    
    NSLog(@"开始获得图片数据");
    NSData *imgdata=[NSData  dataWithContentsOfURL:url];
    NSLog(@"得到数据");
    
    [self  performSelectorOnMainThread:@selector(upDataUI:) withObject:imgdata waitUntilDone:YES];
    

}
-(void)upDataUI:(id)obj
{    NSLog(@"主线程----%@",[NSThread currentThread]);

    NSData*data=(NSData*)obj;
 
    imageView.image=[UIImage  imageWithData:data];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
