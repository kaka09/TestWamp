//
//  TestSocketViewController.m
//  QuizApp
//
//  Created by Hoang Le Huy on 9/23/14.
//  Copyright (c) 2014 Rikkeisoft Co., Ltd. All rights reserved.
//

#import "TestSocketViewController.h"
#import "WampManager.h"

@interface TestSocketViewController ()<WampDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf_topicId;
@property (weak, nonatomic) IBOutlet UITextField *tf_challengeId;
- (IBAction)receiveChallenge:(id)sender;
- (IBAction)challenge:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbl_user;

@end

@implementation TestSocketViewController

- (IBAction)hidKeyboad:(id)sender {
    [_tf_challengeId resignFirstResponder];
    [_tf_topicId resignFirstResponder];;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
    
    
//    UserEntity * user = GET_OBJECT(K_USER_INFO);
//    _lbl_user.text = [NSString stringWithFormat:@"USER:%@   id: %d",user.name, user.userId];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)subcribe:(id)sender
{
    [[WampManager sharedInstance] subscribeChatWithUserId:89 andDelegate:self andCompleteBlock:^(BOOL success, id result) {
        if (success) {
            NSLog(@"subscribeChat Sucessfull");
        }else {
           NSLog(@"subscribeChat unsucessfull");
        }
    }];
}

- (IBAction)unsubcribe:(id)sender
{
    [[WampManager sharedInstance] unSubscribeChatWithUserId:89 andCompleteBlock:^(BOOL success, id result) {
        if (success) {
            NSLog(@"UnsubscribeChat Sucessfull");
        }else {
            NSLog(@"UnsubscribeChat unsucessfull");
        }
    }];
    
//    [[WampManager sharedInstance] dissconnect:^(BOOL success, id result) {
//    }];

}

#pragma mark - WAMP DELEGATE



@end
