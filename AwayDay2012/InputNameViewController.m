//
//  InputNameViewController.m
//  AwayDay2012
//
//  Created by xuehai zeng on 12-8-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InputNameViewController.h"
#import "AppDelegate.h"
#import "AppConstant.h"
#import "AFJSONRequestOperation.h"

@implementation InputNameViewController
@synthesize userNameField=_userNameField;
@synthesize cancelButton=_cancelButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate hideMenuView];
    [self.userNameField becomeFirstResponder];
    
    NSString *userName=[appDelegate.userState objectForKey:kUserNameKey];
    if(userName!=nil && userName.length>0){
        [self.userNameField setText:userName];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate showMenuView];
}

#pragma mark - UIAction method
-(IBAction)inputDoneButtonPressed:(id)sender{
    NSString *inputUserName = self.userNameField.text;
    NSString *name=[inputUserName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(name.length==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Please input your name" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate.userState setObject:inputUserName forKey:kUserNameKey];
    [appDelegate saveUserState];


    //loading start

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", kServiceSuperUserAuthentication, inputUserName]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest
                                                                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                                   NSLog(@"success response:%@", JSON);
                                                                                                   [self handleSuperUserAuth:JSON];
                                                                                               }
                                                                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                                   NSLog(@"fail response:%@", JSON);
                                                                                                   [self handleSuperUserAuthFailure];
                                                                                               }
    ];
    [requestOperation start];



}

- (void)handleSuperUserAuthFailure {
    //stop loading
    [self dismissModalViewControllerAnimated:YES];
}

- (void)handleSuperUserAuth:(NSDictionary *)JSON {
    if ([JSON[@"result"] isEqual:@"true"]) {
        //enterSuperUserMode
        //stoploading
        [self dismissModalViewControllerAnimated:YES];
    } else {
        [self handleSuperUserAuthFailure];
    }
}

-(IBAction)cancelButtonPressed:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

@end
