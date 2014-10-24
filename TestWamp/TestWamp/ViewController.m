//
//  ViewController.m
//  TestWamp
//
//  Created by Nguyen Hoan on 10/24/14.
//  Copyright (c) 2014 Nguyen Hoan. All rights reserved.
//

#import "ViewController.h"
#import "TestSocketViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)goTestSocket:(id)sender {
    TestSocketViewController * testVC = [[TestSocketViewController alloc] initWithNibName:@"TestSocketViewController" bundle:nil];
    [self.navigationController pushViewController:testVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
