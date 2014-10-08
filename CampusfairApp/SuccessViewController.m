#import "SuccessViewController.h"

@interface SuccessViewController ()
@property (weak, nonatomic) IBOutlet UILabel *successLabel;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;

@end

@implementation SuccessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.successLabel.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
    self.returnButton.titleLabel.font  = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:20.0f];
}

- (IBAction)onClickReturn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
