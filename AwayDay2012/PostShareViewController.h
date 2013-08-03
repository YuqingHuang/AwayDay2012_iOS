//
// Created by hyq on 8/3/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import <UIKit/UIKit.h>
#import "Session.h"
#import "UserPath.h"

@interface PostShareViewController: UIViewController <UIActionSheetDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, strong) Session *session;
@property(nonatomic, strong) UIImage *userImage;
@property(nonatomic, strong) IBOutlet UITextView *textView;
@property(nonatomic, strong) IBOutlet UILabel *textCountLabel;
@property(nonatomic, strong) IBOutlet UILabel *sessionTextLabel;
@property(nonatomic, strong) IBOutlet UIImageView *imageIconView;

-(IBAction)backButtonPressed:(id)sender;
-(IBAction)sendButtonPressed:(id)sender;
-(IBAction)addImageButtonPressed:(id)sender;

-(void)postUserShare2Server;
-(void)postUserPath2Server:(UserPath *)userPath;

@end