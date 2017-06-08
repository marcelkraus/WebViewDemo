#import "ThirdWebViewController.h"
#import <WebKit/WebKit.h>

@interface ThirdWebViewController () <WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation ThirdWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *one = @"window.ck_tracking = {};";
    NSString *two = @"window.ck_tracking.track = function(json) { window.webkit.messageHandlers.foo.postMessage(json); }";
    WKUserScript *oneScript = [[WKUserScript alloc] initWithSource:one injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    WKUserScript *twoScript = [[WKUserScript alloc] initWithSource:two injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];

    WKUserContentController *contentController = [WKUserContentController new];
    [contentController addUserScript:oneScript];
    [contentController addUserScript:twoScript];
    [contentController addScriptMessageHandler:self name:@"foo"];

    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = contentController;
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];

    [self.view addSubview:self.webView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSURLRequest *request = [NSURLRequest requestWithURL:self.magazineURL];
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    [mutableRequest addValue:@"1" forHTTPHeaderField:@"X-Chefkoch-App-Integration"];
    [self.webView loadRequest:mutableRequest];
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"foo"]) {
        NSData *JSONData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON %@", dictionary);
    }
}

@end
