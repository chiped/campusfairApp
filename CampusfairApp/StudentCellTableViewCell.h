@interface StudentCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelEmail;
@property (weak, nonatomic) IBOutlet UILabel *labelPhone;
@property (weak, nonatomic) IBOutlet UILabel *labelMajor;
@property (weak, nonatomic) IBOutlet UILabel *labelMinor;
@property (weak, nonatomic) IBOutlet UILabel *labelSubscribe;

- (void) fitAllLabelsForCell;

@end
