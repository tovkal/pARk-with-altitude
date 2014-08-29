/*
     File: pARkViewController.m
 Abstract: Simple view controller for the pARk example. Provides a hard-coded list of places-of-interest to its associated ARView when loaded, starts the ARView when it appears, and stops it when it disappears.
  Version: 1.0
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2012 Apple Inc. All Rights Reserved.
 
 */

#import "pARkViewController.h"
#import "PlaceOfInterest.h"
#import "ARView.h"

#import <CoreLocation/CoreLocation.h>

@implementation pARkViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	ARView *arView = (ARView *)self.view;
	
	// Create array of hard-coded places-of-interest, in this case some famous parks
    const char *poiNames[] = {
		"Torre Asima",
		"Puig de Son Espanyol",
		"Puig Major",
		"Pujol des Gat",
		"Sa Falconera",
		"Puig de Son Nací",
		"Puig de Son Poc",
		"Puig de n'Angelè",
		"Puig de s'Artijar",
		"Penyal d'Honor"
	};
	
    CLLocationCoordinate2D poiCoords[] = {
		{39.601748, 2.673369},
		{39.6439214070001, 2.63452117100007},
		{39.808105448, 2.79431146500008},
		{39.590271617, 2.56347608800007},
		{39.691669, 2.669703},
		{39.699852, 2.678229},
		{39.7031250220001, 2.68371576300007},
		{39.722153, 2.662731},
		{39.734574, 2.711631},
		{39.716307, 2.7227}
	};
	
	double altures[] = {
		60,
		209.35,
		1436,
		509.46,
		530.37,
		575.62,
		493.81,
		969.14,
		1026.31,
		808.54
	};
	
	if (sizeof(poiNames) / 4 != sizeof(poiCoords)/16) {
		NSLog(@"# Names!=coordenades");
		abort();
	} else {
		if (sizeof(poiNames) / 4 != sizeof(altures) / 8) {
			NSLog(@"# Names!=altures");
			abort();
		}
	}
    
    int numPois = sizeof(poiCoords) / sizeof(CLLocationCoordinate2D);	
		
	NSMutableArray *placesOfInterest = [NSMutableArray arrayWithCapacity:numPois];
	for (int i = 0; i < numPois; i++) {
		UILabel *label = [[[UILabel alloc] init] autorelease];
		label.adjustsFontSizeToFitWidth = NO;
		label.opaque = NO;
		label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f];
		label.center = CGPointMake(200.0f, 200.0f);
		label.textAlignment = UITextAlignmentCenter;
		label.textColor = [UIColor whiteColor];
		label.text = [NSString stringWithCString:poiNames[i] encoding:NSASCIIStringEncoding];		
		CGSize size = [label.text sizeWithFont:label.font];
		label.bounds = CGRectMake(0.0f, 0.0f, size.width, size.height);
				
		PlaceOfInterest *poi = [PlaceOfInterest placeOfInterestWithView:label at:[[[CLLocation alloc] initWithLatitude:poiCoords[i].latitude longitude:poiCoords[i].longitude] autorelease]];
		poi.altitude = altures[i];
		[placesOfInterest insertObject:poi atIndex:i];
	}	
	[arView setPlacesOfInterest:placesOfInterest];	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	ARView *arView = (ARView *)self.view;
	[arView start];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	ARView *arView = (ARView *)self.view;
	[arView stop];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return interfaceOrientation == UIInterfaceOrientationPortrait;
}

@end
