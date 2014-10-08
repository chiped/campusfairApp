enum MAJORVALIDATIONERRORS {MAJORVALIDATIONSUCCESS, MAJORVALIDATIONOTHERSUCCESS, MAJORVALIDATIONOTHERERROR, MAJORVALIDATIONERROR};

#define kOFFSET_FOR_KEYBOARD 80.0

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textfieldFirstName;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textfieldLastName;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textfieldEmail;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textfieldPhone;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textfieldMajor;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textfieldOther;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textfieldMinor;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOtherHeight;
@property (weak, nonatomic) IBOutlet UISwitch *switchSubscribe;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeTextField;
@property (strong, nonatomic) IBOutlet UIView *formView;
@property (weak, nonatomic) IBOutlet UILabel *subscribeLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *adminButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

-(void) configureView
{    
    [self hideOthersOption];
    [self addBorders];
    [self defaultImageForMajor];
    self.subscribeLabel.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:18.0f];
    self.submitButton.titleLabel.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:22.0f];
    self.adminButton.titleLabel.font = [UIFont fontWithName:@"BarclaycardCoLt-Regular" size:20.0f];
    self.textfieldOther.errorMessage = @"Enter valid Major";
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void) addBorders
{
    [self.textfieldFirstName addBottomBorder];
    [self.textfieldLastName addBottomBorder];
    [self.textfieldLastName addLeftBorder];
    [self.textfieldEmail addBottomBorder];
    [self.textfieldPhone addBottomBorder];
    [self.textfieldMajor addBottomBorder];
    [self.textfieldOther addBottomBorder];
    [self.textfieldMinor addBottomBorder];
    [self.textfieldMinor addBottomBorder];
}

-(void) showOthersOption
{
    self.constraintOtherHeight.constant = 70;
}

-(void)hideOthersOption
{
    self.constraintOtherHeight.constant = 0;
    [self.textfieldOther setDefaultAppearance];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
    {
        NSDictionary* info = [notification userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.width, 0.0);
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
        
        CGRect aRect = self.view.frame;
        aRect.size.height -= kbSize.height;
        if((self.formView.frame.origin.y + self.activeTextField.frame.origin.y + self.activeTextField.frame.size.height) > (self.view.frame.size.height - kbSize.width)) {
            [self.scrollView scrollRectToVisible:self.activeTextField.frame animated:YES];
        }
    }
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

-(void)keyboardWillHide:(NSNotification *)note
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (IBAction)tapReceived:(id)sender {
    [self.view endEditing:YES];
}

-(void)selectedMajor:(NSString *)newMajor
{
    self.textfieldMajor.text = newMajor;
    [self populateSelectedMajor];
}

-(void)authenticate:(bool)success
{
    if(success) {
        [self performSegueWithIdentifier:@"viewDataSegue" sender:self];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Authentication failed. Try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"majorSegue"]) {
        MajorTableViewController *destination = segue.destinationViewController;
        destination.delegate = self;
    } else if([segue.identifier isEqualToString:@"authenticationSegue"]) {
        AuthenticationViewController *destination = segue.destinationViewController;
        destination.delegate = self;
        destination.view.superview.bounds = CGRectMake(0, 0, 140, 125);
    }
}

#pragma mark - textfield delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.textfieldFirstName) {
        [self.textfieldFirstName resignFirstResponder];
        [self.textfieldLastName becomeFirstResponder];
    } else if(textField == self.textfieldLastName) {
        [self.textfieldLastName resignFirstResponder];
        [self.textfieldEmail becomeFirstResponder];
    } else if(textField == self.textfieldEmail) {
        [self.textfieldEmail resignFirstResponder];
        [self.textfieldPhone becomeFirstResponder];
    } else if(textField == self.textfieldPhone) {
        [self.textfieldPhone resignFirstResponder];
        [self.textfieldMajor becomeFirstResponder];
    } else if(textField == self.textfieldMajor) {
        [self.textfieldMajor resignFirstResponder];
        if([self.textfieldMajor.text isEqualToString:@"Other"]) {
            [self.textfieldOther becomeFirstResponder];
        } else {
            [self.textfieldMinor becomeFirstResponder];
        }
    } else if(textField == self.textfieldOther) {
        [self.textfieldOther resignFirstResponder];
        [self.textfieldMinor becomeFirstResponder];
    } else if(textField == self.textfieldMinor) {
        [self.textfieldMinor resignFirstResponder];
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeTextField = nil;
    if(textField == self.textfieldFirstName) {
        [self checkFirstName];
    } else if(textField == self.textfieldLastName) {
        [self checkLastName];
    } else if(textField == self.textfieldEmail) {
        [self checkEmail];
    } else if(textField == self.textfieldPhone) {
        [self checkPhone];
    } else if(textField == self.textfieldMajor || textField == self.textfieldOther) {
        [self checkMajor];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeTextField = textField;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [((JVFloatLabeledTextField *) textField) setDefaultAppearance];
    if(textField == self.textfieldMajor)
    {
        [self.view endEditing:YES];
        [self performSegueWithIdentifier:@"majorSegue" sender: self];
        return NO;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == self.textfieldPhone) {
        int length = [self getLength:textField.text];
        if(length == 10) {
            if(range.length == 0)
                return NO;
        }
        if(length == 3) {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"(%@) ",num];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
        else if(length == 6) {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
    }
    return YES;
}

#pragma mark - helper methods

-(void)defaultImageForMajor
{
    self.textfieldMajor.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chevron"]];
    self.textfieldMajor.rightViewMode = UITextFieldViewModeAlways;
}
-(NSString*)formatNumber:(NSString*)mobileNumber
{
    mobileNumber = [self phoneNumberByIgnoringCharactersFromString:mobileNumber];
    int length = [mobileNumber length];
    if(length > 10) {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
    }
    return mobileNumber;
}

-(int)getLength:(NSString*)mobileNumber
{
    mobileNumber = [self phoneNumberByIgnoringCharactersFromString:mobileNumber];
    int length = [mobileNumber length];
    return length;
}

-(NSString *)phoneNumberByIgnoringCharactersFromString:(NSString *)phoneNumber
{
    NSString *modfiedPhone = phoneNumber;
    modfiedPhone = [modfiedPhone stringByReplacingOccurrencesOfString:@"(" withString:@""];
    modfiedPhone = [modfiedPhone stringByReplacingOccurrencesOfString:@")" withString:@""];
    modfiedPhone = [modfiedPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    modfiedPhone = [modfiedPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    modfiedPhone = [modfiedPhone stringByReplacingOccurrencesOfString:@"+" withString:@""];
    return modfiedPhone;
}

-(void)showSuccessAlert
{    
    [self performSegueWithIdentifier:@"successSegue" sender:self];
}

-(void)showFailureAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Please fill the mandatory fields and try again."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

-(void)clearAllTextFields
{
    self.textfieldFirstName.text = @"";
    self.textfieldLastName.text = @"";
    self.textfieldEmail.text = @"";
    self.textfieldPhone.text = @"";
    self.textfieldMajor.text = @"";
    self.textfieldOther.text = @"";
    self.textfieldMinor.text = @"";
    
    [self.textfieldFirstName setDefaultAppearance];
    [self.textfieldLastName setDefaultAppearance];
    [self.textfieldEmail setDefaultAppearance];
    [self.textfieldPhone setDefaultAppearance];
    [self.textfieldMajor setDefaultAppearance];
    [self.textfieldMinor setDefaultAppearance];
    [self.switchSubscribe setOn:YES animated:YES];
    [MajorTableViewController resetSelection];
    [self hideOthersOption];
}

-(void)populateSelectedMajor
{
    if([self.textfieldMajor.text isEqualToString:@"None"]) {
        self.textfieldMajor.text = @"";
        [self hideOthersOption];
    } else if([self.textfieldMajor.text isEqualToString:@"Other"]) {
        [self showOthersOption];
    } else {
        [self hideOthersOption];
    }
    [self checkMajor];
}

#pragma mark - IBActions

- (IBAction)onCLickSubmit:(id)sender {
    if([self validateFields]) {
        [self writeToFile];
        [self showSuccessAlert];
        [self clearAllTextFields];
    } else {
        [self showFailureAlert];
    }
}

#pragma mark - file writing

-(void)writeToFile
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = @"/exportedData.csv";
    NSString *absolutePath = [documentsDirectory stringByAppendingString:fileName];
    NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath: absolutePath];
    if(file == nil) {
        [manager createFileAtPath:absolutePath contents:nil attributes:nil];
        file = [NSFileHandle fileHandleForWritingAtPath: absolutePath];
        NSString *headers = [self stringWithHeaders];
        [file writeData:[headers dataUsingEncoding:NSUTF8StringEncoding]];
    }
    NSString *record = [self stringWithUserData];
    [file seekToEndOfFile];
    [file writeData:[record dataUsingEncoding:NSUTF8StringEncoding]];
    [file closeFile];
}

-(NSString *)stringWithHeaders
{
    NSMutableString *record = [[NSMutableString alloc] init];
    [record appendFormat:@"%@,",@"First Name"];
    [record appendFormat:@"%@,",@"Last Name"];
    [record appendFormat:@"%@,",@"Email"];
    [record appendFormat:@"%@,",@"Phone"];
    [record appendFormat:@"%@,",@"Major"];
    [record appendFormat:@"%@,",@"Minor"];
    [record appendFormat:@"%@\n",@"Subscribe"];
    return record;
    
}

-(NSString *)stringWithUserData
{
    NSMutableString *record = [[NSMutableString alloc] init];
    [record appendFormat:@"%@,",self.textfieldFirstName.text];
    [record appendFormat:@"%@,",self.textfieldLastName.text];
    [record appendFormat:@"%@,",self.textfieldEmail.text];
    [record appendFormat:@"%@,",self.textfieldPhone.text];
    if([self.textfieldMajor.text isEqualToString:@"Other"]) {
        [record appendFormat:@"%@,",self.textfieldOther.text];
    } else {
        [record appendFormat:@"%@,",self.textfieldMajor.text];
    }
    [record appendFormat:@"%@,",self.textfieldMinor.text];
    [record appendFormat:@"%@\n",self.switchSubscribe.isOn?@"YES":@"NO"];
    return record;
}


#pragma mark - validation

-(BOOL)validateFields
{
    bool success = YES;
    success &= [self validateFirstName];
    success &= [self validateLastName];
    success &= [self validatePhoneNumber];
    success &= [self validateEmail];
    enum MAJORVALIDATIONERRORS errorCode = [self validateMajor];
    success &= errorCode == MAJORVALIDATIONSUCCESS || errorCode == MAJORVALIDATIONOTHERSUCCESS;
    return success;
}

-(void) checkFirstName
{
    if([self validateFirstName]) {
        [self.textfieldFirstName setSuccessAppearance];
    } else {
        [self.textfieldFirstName setErrorAppearance];
    }
}

-(BOOL)validateFirstName
{
    NSString *firstName = self.textfieldFirstName.text;
    NSString *nameRegex = @"[a-zA-z ]+";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:firstName];
}

-(void) checkLastName
{
    if([self.textfieldLastName.text isEqualToString:@""]) {
        [self.textfieldLastName setDefaultAppearance];
    }
    else if([self validateLastName]) {
        [self.textfieldLastName setSuccessAppearance];
    } else {
        [self.textfieldLastName setErrorAppearance];
    }
}

-(BOOL)validateLastName
{
    NSString *lastName = self.textfieldLastName.text;
    NSString *nameRegex = @"[a-zA-z ]*";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:lastName];
}

-(void) checkPhone
{
    if([self validatePhoneNumber]) {
        [self.textfieldPhone setSuccessAppearance];
    } else {
        [self.textfieldPhone setErrorAppearance];
    }
}

-(BOOL)validatePhoneNumber
{
    NSString *phoneNumber = self.textfieldPhone.text;
    phoneNumber = [self phoneNumberByIgnoringCharactersFromString:phoneNumber];
    NSString *phoneRegex = @"[123456789][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}

-(void) checkEmail
{
    if([self validateEmail]) {
        [self.textfieldEmail setSuccessAppearance];
    } else {
        [self.textfieldEmail setErrorAppearance];
    }
}

- (BOOL)validateEmail
{
    NSString *email = self.textfieldEmail.text;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(void) checkMajor
{
    switch ([self validateMajor]) {
        case MAJORVALIDATIONSUCCESS:
            [self.textfieldMajor setSuccessAppearance];
            break;
        case MAJORVALIDATIONOTHERSUCCESS:
            [self.textfieldMajor setDefaultAppearance];
            [self.textfieldOther setSuccessAppearance];
            break;
        case MAJORVALIDATIONOTHERERROR:
            [self.textfieldMajor setDefaultAppearance];
            [self.textfieldOther setErrorAppearance];
            break;
        case MAJORVALIDATIONERROR:
            [self.textfieldMajor setErrorAppearance];
            break;
        default:
            break;
    }
    [self defaultImageForMajor];
}

-(enum MAJORVALIDATIONERRORS)validateMajor
{
    if([self.textfieldMajor.text isEqualToString:@""] || [self.textfieldMajor.text isEqualToString:@"None"] ) {
        return MAJORVALIDATIONERROR;
    }
    if([self.textfieldMajor.text isEqualToString:@"Other"]) {
        NSString *majorOther = self.textfieldOther.text;
        NSString *majorRegex = @"[a-zA-Z0-9 ()-]+";
        NSPredicate *otherTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", majorRegex];
        if([otherTest evaluateWithObject:majorOther]) {
            return MAJORVALIDATIONOTHERSUCCESS;
        } else {
            return MAJORVALIDATIONOTHERERROR;
        }
    }
    return MAJORVALIDATIONSUCCESS;
}

@end
