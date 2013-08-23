//
//  HelloWorldLayer.m
//  Lesson1
//
//  Created by Zeeshan Khaliq on 8/22/13.
//  Copyright Zeeshan Khaliq 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Import touch handling interface
#import "CCTouchDispatcher.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

CCSprite *seeker1;
CCSprite *cocosGuy;

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// set up the menus
- (void) setUpMenus
{
    // create some menu items
    CCMenuItemImage *menuItem1 = [CCMenuItemImage itemWithNormalImage:@"myfirstbutton.png"
                                                        selectedImage:@"myfirstbutton_selected.png"
                                                               target:self
                                                             selector:@selector(doSomethingOne:)];
    
    CCMenuItemImage *menuItem2 = [CCMenuItemImage itemWithNormalImage:@"mysecondbutton.png"
                                                        selectedImage:@"mysecondbutton_selected.png"
                                                               target:self
                                                             selector:@selector(doSomethingTwo:)];
    
    CCMenuItemImage *menuItem3 = [CCMenuItemImage itemWithNormalImage:@"mythirdbutton.png"
                                                        selectedImage:@"mythirdbutton_selected.png"
                                                               target:self
                                                             selector:@selector(doSomethingThree:)];
    
    // create a menu and add your menu items to it
    CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
    
    // arrange the menu items vertically
    [myMenu alignItemsVertically];
    
    // add the menu to your scene
    [self addChild:myMenu];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
		// create and initialize our seeker sprite, and add it to this layer
        seeker1 = [CCSprite spriteWithFile:@"seeker.png"];
        seeker1.position = ccp(50, 100);
        [self addChild:seeker1];
        
        // do the same for the cocos2d guy, reusing the app icon as its image
        cocosGuy = [CCSprite spriteWithFile:@"Icon.png"];
        cocosGuy.position = ccp(200, 300);
        [self addChild:cocosGuy];
        
        // schedule a repeating callback on every frame
        [self schedule:@selector(nextFrame:)];
        [self setUpMenus];
        
        self.touchEnabled = YES;
	}
    
	return self;
}

- (void) registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

// updates each frame
- (void) nextFrame:(ccTime)dt
{
    seeker1.position = ccp(seeker1.position.x + 100*dt, seeker1.position.y);
    if (seeker1.position.x > 480+32)
    {
        seeker1.position = ccp(-32, seeker1.position.y);
    }
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [self convertTouchToNodeSpace: touch];
    
    [cocosGuy stopAllActions];
    [cocosGuy runAction: [CCMoveTo actionWithDuration:1 position:location]];
}

- (void) doSomethingOne:(CCMenuItem *)menuItem
{
    NSLog(@"The first menu was called");
}

- (void) doSomethingTwo:(CCMenuItem *)menuItem
{
    NSLog(@"The second menu was called");
}

- (void) doSomethingThree:(CCMenuItem *)menuItem
{
    NSLog(@"The third menu was called");
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissViewControllerAnimated:YES completion:nil];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissViewControllerAnimated:YES completion:nil];
}
@end
