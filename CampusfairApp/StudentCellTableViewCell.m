#import "StudentCellTableViewCell.h"

@implementation StudentCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.labelName.text= nil;
        self.labelEmail.text= nil;
        self.labelPhone.text = nil;
        self.labelMajor.text = nil;
        self.labelMinor.text = nil;
        self.labelSubscribe.text = nil;


    }
    return self;
}

- (void) fitAllLabelsForCell
{
    [self.labelName sizeToFit];
    [self.labelEmail sizeToFit];
    [self.labelPhone sizeToFit];
    [self.labelMajor sizeToFit];
    [self.labelMinor sizeToFit];
    [self.labelSubscribe sizeToFit];
}

//- (id)init
//{
//    self = [super init];
//  
//}

//-(id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    self.labelName.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
//    self.labelEmail.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
//    self.labelPhone.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
//    self.labelMajor.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
//    self.labelMinor.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
//    self.labelSubscribe.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
//    return self;
//}

//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    self.labelName.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
//    self.labelEmail.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
//    self.labelPhone.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
//    self.labelMajor.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
//    self.labelMinor.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
//    self.labelSubscribe.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
//    return self;
//
//}

@end
