#import "SecondViewController.h"

@interface SecondViewController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSURLRequest *request = [NSURLRequest requestWithURL:self.magazineURL];
    [self.webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *javaScript = @"document.body.getAttribute('data-tracking')";
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:javaScript];

    NSData *JSONData = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"JSON %@", dictionary);
}

@end
