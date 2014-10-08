#define FIRST_NAME_INDEX 0
#define LAST_NAME_INDEX 1
#define EMAIL_INDEX 2
#define PHONE_INDEX 3
#define MAJOR_INDEX 4
#define MINOR_INDEX 5
#define SUBSCRIBE_INDEX 6


#import "Student.h"

@implementation Student

- (Student *) initWithString : (NSString *) line
{
    if(!self){
     self =  [super init];
    }
    
    NSArray* tokens = [line componentsSeparatedByString:@","];
    self.firstName = tokens[FIRST_NAME_INDEX];
    self.lastName = tokens[LAST_NAME_INDEX];
    self.email = tokens[EMAIL_INDEX];
    self.phone = tokens[PHONE_INDEX];
    self.major = tokens[MAJOR_INDEX];
    self.minor =  tokens[MINOR_INDEX];
    self.subscribe = tokens[SUBSCRIBE_INDEX];
    return self;
}

+ (NSArray *) studentsFromFile: (NSString *) filePath
{
    NSMutableArray *students = [[NSMutableArray alloc]init];
    NSString* fileContent = [NSString stringWithContentsOfFile:filePath encoding: NSUTF8StringEncoding error:nil];
    NSArray *lines = [fileContent componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    for (int i=1; i<lines.count; i++) {
        NSString *line = lines[i];
        if(![line isEqualToString:@""]) {
            [students addObject: [[Student alloc] initWithString: line] ];
        }
    }
    return [NSArray arrayWithArray:students];
}


@end



