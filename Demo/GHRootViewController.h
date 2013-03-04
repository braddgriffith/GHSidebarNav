//
//  GHRootViewController.h
//  GHSidebarNav
//
//  Created by Greg Haines on 11/20/11.
//

#import <Foundation/Foundation.h>

typedef void (^RevealBlock)();

@interface GHRootViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {}

- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock;

@property (copy,nonatomic)RevealBlock revealBlock;

@end
