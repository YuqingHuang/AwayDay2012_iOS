#import "AgendaListRetriever.h"
#import "AppConstant.h"

@implementation AgendaListRetriever

-(id)init {
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:(NSString *)kServiceLoadSessionList];
//        AF *request = [ASIHTTPRequest requestWithURL:url];
//        [request setDelegate:self];
//        [request setTimeOutSeconds:10.0f];
//        [request setTag:tag_req_load_session_list];
//        [request startAsynchronous];

    }
    return self;
}
@end
