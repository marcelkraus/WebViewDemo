#import <UIKit/UIKit.h>

/**
 * Öffentliches Property dieser Klasse ist ausschließlich die Magazin-URL. Diese
 * wird als Typ NSURL gesetzt und daraus innerhalb der Implementierung ein
 * NSURLRequest instanziert.
 * 
 * Zu klären: Warum wird hier das Attribut "copy" verwendet, anstatt "weak" oder
 * "strong" zu verwenden. Vermutung: Pass-by-reference ist Standardverhalten. 
 */
@interface FirstWebController : UIViewController
@property (nonatomic, copy) NSURL *magazineURL;
@end
