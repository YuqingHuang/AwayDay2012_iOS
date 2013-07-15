#import "AgendaListRetriever.h"
#import "AppConstant.h"
#import "AFJSONRequestOperation.h"

@implementation AgendaListRetriever {
    AFJSONRequestOperation *requestOperation;

}

- (id)init {
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:(NSString *) kServiceLoadSessionList];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest
                                                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                               NSLog(@"success response:%@", JSON);
                                                                           }
                                                                           failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                               NSLog(@"fail response:%@", JSON);
                                                                           }
        ];
    }
    return self;
}

- (void)beginRetrieving {
    [requestOperation start];
}
@end
