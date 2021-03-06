//
//  UIFont_Name_GrabberViewController.m
//  UIFont Name Grabber
//
//  Created by Nick Forge on 4/08/10.
//  Copyright Nick Forge 2010. All rights reserved.
//

#import "UIFont_Name_GrabberViewController.h"


@implementation UIFont_Name_GrabberViewController

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];

}

- (void)sendMail
{
	// Grab a list of fonts available on the system
	NSMutableDictionary *fontsByFamilyName = [NSMutableDictionary dictionary];
	NSMutableString *fontsString = [NSMutableString string];
	
	NSArray *sortDescriptors = [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES] autorelease]];
	
	NSArray *familyNames = [[UIFont familyNames] sortedArrayUsingDescriptors:sortDescriptors];
	for (NSString *aFamilyName in familyNames) {
		NSArray *fontNames = [[UIFont fontNamesForFamilyName:aFamilyName] sortedArrayUsingDescriptors:sortDescriptors];

		[fontsByFamilyName setObject:fontNames forKey:aFamilyName];

		[fontsString appendFormat:@"%@\n", aFamilyName];
		for (NSString *aFontName in fontNames) {
			[fontsString appendFormat:@"\t%@\n", aFontName];
		}
		[fontsString appendString:@"\n"];
	}

	// Create an XML plist data representation of the dictionary
	NSData *fontsPlistAsData = [NSPropertyListSerialization dataFromPropertyList:fontsByFamilyName
																		  format:NSPropertyListXMLFormat_v1_0
																errorDescription:nil];
	
	// Create a UTF8 data representation of the string
	NSData *fontsTxtAsData = [fontsString dataUsingEncoding:NSUTF8StringEncoding];
	
	// Send the data via email
	if ([MFMailComposeViewController canSendMail]) {
		MFMailComposeViewController *vc = [[[MFMailComposeViewController alloc] init] autorelease];
		vc.mailComposeDelegate = self;
		[vc setSubject:[NSString stringWithFormat:@"UIFont names for %@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion]];
		[vc setMessageBody:@"" isHTML:NO];
		[vc addAttachmentData:fontsPlistAsData
					 mimeType:@"plist"
					 fileName:[NSString stringWithFormat:@"UIFont Names for %@ %@.plist", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion]];
		[vc addAttachmentData:fontsTxtAsData
					 mimeType:@"text"
					 fileName:[NSString stringWithFormat:@"UIFont Names for %@ %@.txt", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion]];
		[self presentModalViewController:vc animated:NO];
	}
	else {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Can't send mail"
														 message:@"You need to have a mail account setup in order to email you the .plist file."
														delegate:nil
											   cancelButtonTitle:@"OK"
											   otherButtonTitles:nil] autorelease];
		[alert show];
	}
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

@end
