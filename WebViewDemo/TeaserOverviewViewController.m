#import "TeaserOverviewViewController.h"
#import "MyWebViewController.h"

@interface TeaserOverviewViewController()
@property (nonatomic, weak) IBOutlet UIButton *firstWebButton;
@property (nonatomic, weak) IBOutlet UIButton *secondWebButton;
@property (nonatomic, weak) IBOutlet UIButton *thirdWebButton;
@end

@implementation TeaserOverviewViewController

/**
 * Diese Methode dient als Einstiegspunkt unmittelbar bevor die View erscheint.
 * Die Aktionen der Buttons werden hier - zumindest teilweise - registiert.
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.firstWebButton addTarget:self action:@selector(firstWebButtonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.thirdWebButton addTarget:self action:@selector(thirdWebButtonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Actions

/**
 * Variante 1: Button wird über viewWillAppear: verlinkt. Es existiert keine
 * IBAction-Kennzeichnung und damit kein "Bubble" auf der linken Seite neben der
 * Methode in Xcode.
 */
- (void)firstWebButtonWasPressed:(UIButton *)sender {
    MyWebViewController *webViewController = [[MyWebViewController alloc] init];
    
    webViewController.magazineURL = [NSURL URLWithString:@"http://www.chefkoch.de/"];
    [self.navigationController pushViewController:webViewController animated:YES];
}

/**
 * Variante 2: Button wird über eine IBAction verlinkt. Der Rückgabewert der
 * Methode ist IBAction, es exisiert kein Aufruf in der Methode viewWillAppear:.
 */
- (IBAction)secondWebButtonWasPressed:(UIButton *)sender {
    MyWebViewController *webViewController = [[MyWebViewController alloc] init];
    
    webViewController.magazineURL = [NSURL URLWithString:@"http://www.chefkoch.de/magazin/artikel/897,0/AEG/Leckereien-rund-ums-Ei.html"];
    [self.navigationController pushViewController:webViewController animated:YES];
}

/**
 * Variante 3: Button wird über viewWillAppear: verlinkt, verfügt aber über eine
 * "leere" IBAction-"Bubble". Falle: Das leere IBaction-"Bubble" signalisiert
 * eine nicht verknüpfte Action, die eventuell entfernt werden kann. Achtung
 * dabei, in dem Fall kann (IBAction) auch gegen (void) getauscht werden.
 */
- (IBAction)thirdWebButtonWasPressed:(UIButton *)sender {
    MyWebViewController *webViewController = [[MyWebViewController alloc] init];
    
    webViewController.magazineURL = [NSURL URLWithString:@"https://www.myknight.de/"];
    [self.navigationController pushViewController:webViewController animated:YES];
}

@end
