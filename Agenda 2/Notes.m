//
//  Notes.m
//  Agenda 2
//
//  Created by Lee Hamilton on 12/5/11.
//  Copyright 2011 Lee Hamilton. All rights reserved.
//

#import "Notes.h"

@implementation Notes
@synthesize notesText,inputAccView2;

-(IBAction)emailNotes:(id)sender{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mvc = [[MFMailComposeViewController alloc]init];
        mvc.mailComposeDelegate = self;
        [mvc setSubject:@"Notes"];
        [mvc setMessageBody:notesText.text isHTML:NO];
        [self presentModalViewController:mvc animated:YES];
        [mvc release];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to send mail at this time. Please try again later or contact support." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)tweetNotes:(id)sender{
    if([MFMessageComposeViewController canSendText]){
        MFMessageComposeViewController *textController = [[MFMessageComposeViewController alloc]init];
        textController.body = notesText.text;
        textController.messageComposeDelegate = self;
        [self presentModalViewController:textController animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to send text at this time. Please try again later or contact support." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}
-(IBAction)facebookNotes:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://facebook.com/share.php?u=%@", notesText.text]]];
}

-(void)createInputAccessoryView{
    inputAccView2 = [[UIView alloc]initWithFrame:CGRectMake(10.0, 0.0,[[UIScreen mainScreen] bounds].size.width, 40.0)];
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
    UIBarButtonItem *doneBttn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(endEdit:)];
    [toolbar setItems:[NSArray arrayWithObject:doneBttn]];
    [inputAccView2 addSubview:toolbar];
    [toolbar release];
    [doneBttn release];
    return;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [textView setInputAccessoryView:inputAccView2];
    return YES;
}

-(IBAction)endEdit:(id)sender{
    NSData *dataToWrite = [[NSString stringWithString:notesText.text] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent:@"notes.txt"];
    // Write the file
    [dataToWrite writeToFile:path atomically:YES];
    [notesText resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createInputAccessoryView]; //Adds the toolbar to the keyboard.
    
    //Load the notes.txt file into the UITextView
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent:@"notes.txt"];
    NSString *notesContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    notesText.text = notesContents;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    [notesText release];
    notesText = nil;
    [inputAccView2 release];
    [super dealloc];
}

@end
