//  MIDDLE SCREEN
//  GHRootViewController.m
//  GHSidebarNav
//
//  Created by Greg Haines on 11/20/11.
//

#import "GHRootViewController.h"


#pragma mark -
#pragma mark Private Interface
@interface GHRootViewController ()
- (void)revealSidebar;
@end

#pragma mark -
#pragma mark Implementation
@implementation GHRootViewController

#pragma mark Memory Management
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock {
    if (self = [super initWithNibName:nil bundle:nil]) {
		self.title = title;
		_revealBlock = [revealBlock copy];
		self.navigationItem.leftBarButtonItem = 
        [[UIBarButtonItem alloc] initWithImage:([UIImage imageNamed:@"ButtonMenu.png"])
                                         style:normal
                                        target:self
                                        action:@selector(revealSidebar)];
	}
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	return self;
}

#pragma mark UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

#pragma mark Private Methods
- (void)revealSidebar {
	_revealBlock();
}

@end
