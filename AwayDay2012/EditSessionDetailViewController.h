//
//  EditSessionDetailViewController.h
//  AwayDay2012
//
//  Created by Huang Yuqing on 7/20/13.
//
//

#import <UIKit/UIKit.h>

@class Session;

@interface EditSessionDetailViewController : UIViewController

@property(nonatomic, strong) Session *session;

@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) IBOutlet UITextField *speakerField;
@property (strong, nonatomic) IBOutlet UITextField *timeField;
@property (strong, nonatomic) IBOutlet UITextField *roomField;
@property (strong, nonatomic) IBOutlet UITextField *descriptionField;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end
