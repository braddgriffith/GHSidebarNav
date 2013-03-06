//
//  Listing.h
//  Gametime
//
//  Created by Brad Grifffith on 3/5/13.
//
//

#import <Foundation/Foundation.h>

@class Listing;

@interface Listing : NSObject 

@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * section_id;
@property (nonatomic, copy) NSString * row;
@property (nonatomic, copy) NSNumber * original_price;
@property (nonatomic, copy) NSNumber * current_price;
//@property (nonatomic, strong) Ticket *    ticket_id;
//@property (nonatomic, strong) Event *     event_id;

//- (CLLocationCoordinate2D)coordinate;

@end
