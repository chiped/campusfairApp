#import "AuthenticationViewController.h"

@interface AuthenticationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passcodeTextfield;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation AuthenticationViewController

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
    self.loginButton.titleLabel.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:17.0f];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.view.superview.bounds = CGRectMake(0, 0, 300, 165);
}

- (IBAction)onClickLogin:(id)sender {
    if(self.delegate) {
        if([self.passcodeTextfield.text isEqualToString:@"Happy123"]) {
            [self.delegate authenticate:YES];
        } else {
            [self.delegate authenticate:NO];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onClickClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
