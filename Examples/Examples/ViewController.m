#import "ViewController.h"

@interface ViewController () {
    NSArray *pickerData;
    NSString *pickerName;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    pickerData = @[@"ZipCodeSingleLookup", @"ZipCodeMultipleLookups",
                @"StreetSingleAddress", @"StreetMultipleAddresses"];
    pickerName = pickerData[0];
    
    [_submitButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //Connect Data
    self.picker.dataSource = self;
    self.picker.delegate = self;
}

- (void)buttonPressed:(UIButton*)button {
    if ([pickerName isEqualToString:@"ZipCodeSingleLookup"]) {
        SSZipCodeSingleLookupExample *example = [[SSZipCodeSingleLookupExample alloc] init];
        NSString *result = [example runCode];
        self.resultsTextView.text = result;
    }
    else if ([pickerName isEqualToString:@"ZipCodeMultipleLookups"]) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerData[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    pickerName = pickerData[row];
}

@end