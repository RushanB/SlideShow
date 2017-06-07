//
//  TextAndTitleViewController.m
//  SlideShow
//
//  Created by Mandeep on 2017-06-01.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "TextAndTitleViewController.h"

#import "AppDelegate.h"

@interface TextAndTitleViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTF;

@property (weak, nonatomic) IBOutlet UITextView *details;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) NSString *detailsPlaceholder;
@property (nonatomic)AppDelegate *appDelegate;
@property (nonatomic)NSManagedObjectContext *context;

@end

@implementation TextAndTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.appDelegate.persistentContainer.viewContext;
    self.imageView.image = [UIImage imageWithData:self.photo.savedImage];
    
    self.titleTF.text = self.photo.titleText;
    self.details.text = self.photo.detailsText;
    
    self.details.delegate = self;
    // Do any additional setup after loading the view.
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:tapGesture];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(goBack)];
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects: backButton, nil];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(savePhoto)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:saveButton, nil];
    
    
}

-(void)hideKeyBoard {
    [self.details resignFirstResponder];
    [self.titleTF resignFirstResponder];
}

-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)savePhoto{
    
    self.photo.detailsText = self.details.text;
    self.photo.titleText = self.titleTF.text;
    [self.appDelegate saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)addBullet:(id)sender {
    
    NSString *text = self.details.text;

    NSArray *lines = [text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    NSMutableString *result = [NSMutableString new];
    
    for (NSInteger i = 0; i < lines.count; i++) {
        NSString *line = lines[i];
        if (i == lines.count-1) {
            [result appendString:[NSString stringWithFormat:@"- %@", line]];
            break;
        }
       [result appendString:[NSString stringWithFormat:@"%@\n", line]];
    }

    self.details.text = [result copy];
}


@end
