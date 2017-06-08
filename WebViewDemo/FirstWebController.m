#import "FirstWebController.h"
#import <WebKit/WebKit.h>

/**
 * Die Klasse implementiert das Delegate WKNavigationDelegate um über den
 * Fortschritt des Ladens der Web-Inhalte informiert zu werden. Auch Fehler
 * werden über das Delegate zugreifbar.
 */
@interface FirstWebController () <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation FirstWebController

/**
 * Die Methode wird aufgerufen, unmittelbar nachdem die View geladen wurde.
 *
 * Es wird eine Standard-Konfiguration für eine WKWebView (aus dem
 * WebKit-Framework) erzeugt und daraus eine WKWebView erzeugt. Die Größe des
 * Fensters entspricht dem aktuellen Rahmen der aktuellen View und damit dem
 * vollständigen Bildschirminhalt. Die neu erstellte WKWebView wird der
 * aktuellen View als Subview hinzugefügt.
 *
 * Statt WKWebView hätte auch eine UIWebView erzeugt werden können, doch diese
 * ist ressourcenhungriger und deutlich in "die Jahre gekommen".
 *
 * Ebenfalls in dieser Methode wird der WKWebView mitgeteilt, dass die aktuelle
 * Klasse (self) für das NavigationDelegate zuständigt ist.
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    self.webView.navigationDelegate = self;

    [self.view addSubview:self.webView];
}

/**
 * Unmittelbar vor dem Erscheinen der View wird aus der gewünschten URL (NSURL)
 * ein NSURLRequest erzeugt und in der WKWebView geladen.
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSURLRequest *request = [NSURLRequest requestWithURL:self.magazineURL];
    [self.webView loadRequest:request];
}

/**
 * Die nachfolgenden Methode ist Bestandteil des Delegates, weitere können
 * optional implementiert werden.
 *
 * In diesem Beispiel wird die Methode für die Evaluierung des Javascripts über
 * den DOM verwendet.
 *
 * Pragma Marks werden innherhalb des Teams als bevorzugtes Mittel der optischen
 * Trennung zwischen Abschnitten in Klassen verwendet. Der Bindestrich sorgt für
 * eine Trennlinie in Xcode.
 */

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString *javaScript = @"document.body.getAttribute('data-tracking')";
    [webView evaluateJavaScript:javaScript completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        result ? NSLog(@"result %@", result) : NSLog(@"error %@", error);
    }];
}

@end
