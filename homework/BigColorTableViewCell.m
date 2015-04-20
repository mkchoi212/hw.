
#import "BigColorTableViewCell.h"

@interface UIColor (Intensity)
- (NSInteger)overallIntensity;
@end

@implementation UIColor (Intensity)

// See http://stackoverflow.com/questions/3942878/how-to-decide-font-color-in-white-or-black-depending-on-background-color
- (NSInteger)overallIntensity
{
    CGFloat red, blue, green, alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];

    NSInteger intensity = (red * 255 * 0.299 + green * 255 * 0.578 + blue * 255 * 0.114);
    return intensity;
}

@end

@interface BigColorTableViewCell ()

@end

@implementation BigColorTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) { return nil; }

    self.colorNameLabel = [[UILabel alloc] init];
    self.colorNameLabel.font = [UIFont systemFontOfSize:18];
    self.colorNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.colorNameLabel];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    _titleField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(10, self.frame.size.height, screenRect.size.width-10, self.frame.size.height+20)];
    
    _titleField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Title", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    _titleField.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:40];
    _titleField.floatingLabelFont = [UIFont boldSystemFontOfSize:15];
    _titleField.textAlignment = NSTextAlignmentCenter;
    _titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _titleField.placeholderYPadding = 15.0f;

    [self addSubview:_titleField];
    _titleField.hidden = YES;
    _titleField.translatesAutoresizingMaskIntoConstraints = NO;

    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat height = self.frame.size.height;
    self.colorNameLabel.frame = CGRectMake(0,
                                           self.frame.size.height - height,
                                           self.frame.size.width,
                                           height);
}

#pragma mark - 

- (void)setColor:(UIColor *)color
{
    self.backgroundColor = color;

    if ([color overallIntensity] < 186) {
        self.colorNameLabel.textColor = [UIColor whiteColor];
        self.titleField.floatingLabelActiveTextColor = [UIColor whiteColor];
        self.titleField.floatingLabelTextColor = [UIColor whiteColor];
        self.titleField.textColor = [UIColor whiteColor];
        [[JVFloatLabeledTextField appearance] setTintColor:[UIColor whiteColor]];
    } else {
        self.colorNameLabel.textColor = [UIColor blackColor];
        self.titleField.floatingLabelActiveTextColor = [UIColor blackColor];
        self.titleField.floatingLabelTextColor = [UIColor blackColor];
        self.titleField.textColor = [UIColor blackColor];
        [[JVFloatLabeledTextField appearance] setTintColor:[UIColor blackColor]];


    }
}

- (void)setColorName:(NSString *)colorName
{
    self.colorNameLabel.text = [colorName lowercaseString];
}

@end
