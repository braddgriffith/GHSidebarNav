//
//  AvailViewController.m
//  GHSidebarNav
//
//  Created by Brad Grifffith on 3/4/13.
//
//

#import "AvailViewController.h"
#import "GHRootViewController.h"
#import "Listing.h"
#import "AFJSONRequestOperation.h"
#import "AvailCell.h"
//#import "AFImageCache.h"

static NSString *const URLtoSearch = @"http://glacial-atoll-6400.herokuapp.com/event/sanfrancisco/giants/nexthomegame";

@interface AvailViewController ()

@end

@implementation AvailViewController{
    NSMutableArray *allListings;
    BOOL isLoading;
    NSOperationQueue *queue;
}

float frameBorder = 2.0;
float photoBorder = 2.0;
int cellHeight = 150;
int bannerHeight = 30;
int locationLabelIndent = 4;
int locationLabelWidth = 300;
int locationLabelHeight = 34;
int priceLabelWidth = 150;
int priceBuffer = 3;

#pragma mark AvailableSeats
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock
{
    if(self = [super initWithTitle:title withRevealBlock:revealBlock]){
    }
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self parseListings];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect seatsViewFrame = CGRectMake(0.0, 40.0f, self.view.frame.size.width, self.view.frame.size.height - 40.0f);
    UITableView *seatsView = [[UITableView alloc] initWithFrame:seatsViewFrame];
    seatsView.dataSource = self;
    seatsView.delegate = self;
    
    seatsView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:seatsView];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"AvailCell";
//    AvailCell *cell = (AvailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[AvailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    
//	NSDictionary *info = _cellInfos[indexPath.section][indexPath.row];
//	cell.textLabel.text = info[kSidebarCellTextKey];
//	cell.imageView.image = info[kSidebarCellImageKey];
//    
//    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, cell.frame.size.height-1.0, [UIScreen mainScreen].bounds.size.height, 1.0f)];
//    bottomLine.backgroundColor = [UIColor whiteColor];
//    [cell addSubview:bottomLine];
//    
//    return cell;
    
// ORIGINAL
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.contentView setBackgroundColor:[UIColor blackColor]];
    [cell.contentView setFrame:CGRectMake(0,0,tableView.frame.size.width,cellHeight)];
    
    int frameWidth = cell.contentView.frame.size.width-(2*frameBorder);
    int frameHeight = cell.contentView.frame.size.height-(2*frameBorder);
    
    //Photo Frame
    UIView *frameView = [[UIView alloc] initWithFrame:CGRectMake(frameBorder,frameBorder,frameWidth,frameHeight)];
    [frameView setBackgroundColor:[UIColor lightGrayColor]];
    [cell.contentView addSubview:(frameView)];
    
    //Photo
    UIView *photoView = [[UIView alloc] initWithFrame:CGRectMake(frameBorder + photoBorder, frameBorder + photoBorder, frameWidth - 2*photoBorder, frameHeight - 2*photoBorder)];
    [photoView setBackgroundColor:[UIColor blueColor]];
    [cell.contentView addSubview:(photoView)];
    
    //PhotoIcon
    //seatView
    
    //Banner Starts - the banner is composed of the bannerView, locationLabel, priceLabel and worsePriceLabel - banner can slide down
    int bannerXStart = frameBorder + photoBorder;
    int bannerYStart = cellHeight-frameBorder-photoBorder-bannerHeight;
    int bannerWidth = frameWidth - 2*photoBorder;
    
    UIView *bannerView = [[UIView alloc] initWithFrame:CGRectMake(bannerXStart, cellHeight-frameBorder-photoBorder-bannerHeight, bannerWidth, bannerHeight)];
    [bannerView setBackgroundColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.7]];
    [cell.contentView addSubview:(bannerView)];
    
    int locationYStart = bannerYStart+(bannerHeight/2)-(locationLabelHeight/2);
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(bannerXStart+locationLabelIndent, locationYStart, locationLabelWidth, locationLabelHeight)];
    [locationLabel setBackgroundColor:[UIColor clearColor]];
    [locationLabel setText:@"View Reserve 325, Row 5"];
    [cell.contentView addSubview:locationLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(bannerXStart+bannerWidth-priceLabelWidth-locationLabelIndent, locationYStart, priceLabelWidth, locationLabelHeight)];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    [priceLabel setTextColor:[UIColor whiteColor]];
    [priceLabel setText:@"$58"];
    priceLabel.textAlignment = NSTextAlignmentRight;
    NSString *currentFont = priceLabel.font.fontName;
    CGSize priceLabelSize = [@"$58" sizeWithFont:[UIFont fontWithName:currentFont size:priceLabel.font.pointSize]];
    [cell.contentView addSubview:priceLabel];
    
    UILabel *worsePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(bannerXStart+bannerWidth-locationLabelIndent-2*priceLabelSize.width-priceBuffer, locationYStart, priceLabelSize.width, locationLabelHeight)];
    [worsePriceLabel setBackgroundColor:[UIColor clearColor]];
    [worsePriceLabel setTextColor:[UIColor darkTextColor]];
    [worsePriceLabel setText:@"$75"];
    worsePriceLabel.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:worsePriceLabel];

    //Need to connect all this stuff and animate this down
    
//    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//        if (isLoading) {
//            return [tableView dequeueReusableCellWithIdentifier:LoadingCellIdentifier];
//        } else if ([allListings count] == 0) {
//            return [tableView dequeueReusableCellWithIdentifier:NothingFoundCellIdentifier];
//        } else {
//            OfferCell *cell = (OfferCell *)[tableView dequeueReusableCellWithIdentifier:SearchResultCellIdentifier];
//            if (!cell) {
//                cell = [[OfferCell alloc] init];
//            }
//            Offer *theOffer = [allListings objectAtIndex:indexPath.row];
//            [cell configureForSearchResult:theOffer];
//            
//            return cell;
//        }
//        return [tableView dequeueReusableCellWithIdentifier:LoadingCellIdentifier];
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // return numberAvailable.count;
    return 5;
//    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//    {
//        if (isLoading) {
//            return 1;
//        } else if (allListings == nil) {
//            return 0;
//        } else if ([allListings count] == 0) {
//            return 1;
//        } else {
//            return [allListings count];
//        }
//    }
}

//
// Here we start retreiving data from the server...
//

- (NSURL *)urlWithSearchText:(NSString *)searchText
{
    NSString *urlString = searchText;
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

- (Listing *)parseListing:(NSDictionary *)dictionary
{
    Listing *listing = [[Listing alloc] init];
    
    //NSDictionary *ticketDataDict = [dictionary objectForKey:@"ticket_data"];
    listing.id = [dictionary objectForKey:@"id"];
    listing.section_id = [dictionary objectForKey:@"alias"];
    listing.row = [dictionary objectForKey:@"row_desc"];
    listing.original_price = [dictionary objectForKey:@"curPr"];
    listing.current_price = [dictionary objectForKey:@"curPr"]; //NEED TO CHANGE THIS TO FORMER PRICE
    
    NSLog(@"Listing: %@", listing);
    NSLog(@"Listing section: %@", listing.section_id);
    NSLog(@"Listing current price: %@", listing.current_price);
    return listing;
}

- (void)parseDictionary:(NSDictionary *)dictionary
{
    NSArray *array = [dictionary objectForKey:@"ticket_data"];
    if (array == nil) {
        NSLog(@"Expected 'listings' array");
        return;
    }
    for (NSDictionary *resultDict in array) {
        Listing *pullResult;
        pullResult = [self parseListing:resultDict];
        if (pullResult != nil) {
            [allListings addObject:pullResult];
        }
    }
}

- (void)parseListings
{
    allListings = [NSMutableArray arrayWithCapacity:3];
    
    [queue cancelAllOperations];
    //[[AFImageCache sharedImageCache] removeAllObjects];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    isLoading = YES;
    [self.seatsView reloadData];
    
    NSURL *url = [NSURL URLWithString:URLtoSearch];
    NSLog(@"URL = %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"Request = %@", request);
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             NSLog(@"Operation succeeded");
                                             [self parseDictionary:JSON];
                                             //[allListings sortUsingSelector:@selector(compareName:)];
                                             isLoading = NO;
                                             [self.seatsView reloadData];
                                             NSLog(@"%@", JSON);
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"Operation failed");
                                             [self showNetworkError];
                                             isLoading = NO;
                                             [self.seatsView reloadData];
                                         }];
    
    //operation.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
    [queue addOperation:operation];
    NSLog(@"Operation added");
    [operation start]; 
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


- (void)showNetworkError
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Whoops..."
                              message:@"There was an error reading from the web. There may be a bad connection. Please try again in one minute."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    
    [alertView show];
}

@end
