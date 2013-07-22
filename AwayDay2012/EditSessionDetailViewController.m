//
//  EditSessionDetailViewController.m
//  AwayDay2012
//
//  Created by Huang Yuqing on 7/20/13.
//
//

#import "EditSessionDetailViewController.h"
#import "Session.h"
#import "AFJSONRequestOperation.h"

@interface EditSessionDetailViewController ()

@end

@implementation EditSessionDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    _titleField.text = _session.sessionTitle;
    _speakerField.text = _session.sessionSpeaker;
    _timeField.text = _session.sessionDuration;
    _roomField.text = _session.sessionAddress;
    _descriptionField.text = _session.sessionNote;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:singleFingerTap];
}

- (void)dismissKeyboard {
    [_titleField resignFirstResponder];
    [_speakerField resignFirstResponder];
    [_timeField resignFirstResponder];
    [_roomField resignFirstResponder];
    [_descriptionField resignFirstResponder];
}

- (void)setSession:(Session *)session {
    _session = session;
}

- (IBAction)save:(id)sender {
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:self.session.sessionID];

    NSDictionary *updateSessionDic = @{
            @"session_id" : myNumber,
            @"session_title" : self.titleField.text,
            @"session_speaker" : self.speakerField.text,
            @"session_start" : [self extractUpdatedStartTime],
            @"session_end" : [self extractUpdatedEndTime],
            @"session_description" : self.descriptionField.text,
            @"session_location" : self.roomField.text
    };

    Session *updateSession = [Session createSession:updateSessionDic];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?username=%@", kServiceSuperUserAuthentication, inputUserName]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest
                                                                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                                   NSLog(@"success response:%@", JSON);
                                                                                                   [self handleSuperUserAuth:JSON withInputName:inputUserName];
                                                                                               }
                                                                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                                   NSLog(@"fail response:%@", JSON);
                                                                                                   [self handleSuperUserAuthFailure];
                                                                                               }
    ];
    [requestOperation start];


}

- (NSString *)extractUpdatedStartTime {
    NSArray *array = [self.timeField.text componentsSeparatedByString:@" ~ "];
    NSLog(@"start:%@", array[0]);
    return array[0];
}

- (NSString *)extractUpdatedEndTime {
    NSArray *array = [self.timeField.text componentsSeparatedByString:@" ~ "];
    NSLog(@"end:%@", array[1]);
    return array[1];
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
