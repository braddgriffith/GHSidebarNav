//
//  AvailCell.m
//  Gametime
//
//  Created by Brad Grifffith on 3/6/13.
//
//

#import "AvailCell.h"

@implementation AvailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.clipsToBounds = YES;
		
		UIView *bgView = [[UIView alloc] init];
		bgView.backgroundColor = [UIColor clearColor];//[UIColor blackColor];//[UIColor lightGrayColor];//[UIColor colorWithRed:(38.0f/255.0f) green:(44.0f/255.0f) blue:(58.0f/255.0f) alpha:1.0f];
		self.selectedBackgroundView = bgView;
		
		self.imageView.contentMode = UIViewContentModeCenter;
		
		self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:([UIFont systemFontSize] * 1.2f)];
		self.textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		self.textLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.25f];
		self.textLabel.textColor = [UIColor lightTextColor];//[UIColor colorWithRed:(196.0f/255.0f) green:(204.0f/255.0f) blue:(218.0f/255.0f) alpha:1.0f];
		
	}
	return self;
}

#pragma mark UIView
- (void)layoutSubviews {
	[super layoutSubviews];
	self.textLabel.frame = CGRectMake(20.0f, 0.0f, 200.0f, 43.0f);
    self.imageView.frame = CGRectMake(-50.0f, 0.0f, 0.0f, 43.0f);
	//self.imageView.frame = CGRectMake(0.0f, 0.0f, 50.0f, 43.0f);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)configureForAvail:(id)theListing
//{
//    self.nameLabel.text = theOffer.merchant.name;
//    
//    //self.artistNameLabel.text = theOffer.full_description;
//    self.artistNameLabel.text = theOffer.caption;
//    
//    [self.artworkImageView setImageWithURL:[NSURL URLWithString:theOffer.image_url] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
//}
//
//- (void)prepareForReuse
//{
//    [super prepareForReuse];
//    [self.artworkImageView cancelImageRequestOperation];
//    self.nameLabel.text = nil;
//    self.artistNameLabel.text = nil;
//}

@end
