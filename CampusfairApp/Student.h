@interface Student : NSObject

@property (strong, readwrite, nonatomic) NSString *firstName;
@property (strong, readwrite, nonatomic) NSString *lastName;
@property (strong, readwrite, nonatomic) NSString *email;
@property (strong, readwrite, nonatomic) NSString *phone;
@property (strong, readwrite, nonatomic) NSString *major;
@property (strong, readwrite, nonatomic) NSString *minor;
@property (strong, readwrite, nonatomic) NSString *subscribe;

+(NSArray *) studentsFromFile: (NSString *) filePath;

@end
