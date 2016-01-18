//
//  ViewController.m
//  RainyMood
//
//  Created by RaulStudio on 16/1/6.
//  Copyright © 2016年 RaulStudio. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "PopupWindowView.h"

@interface ViewController ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) AVAudioPlayer *audioPlayerRain1;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerRain2;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerRain3;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerRain4;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerThunder;


@property (strong, nonatomic) IBOutlet UIView *btn_Show;

@property (strong, nonatomic) UIView *bgView;


@end

@implementation ViewController



-(void)loadView
{
    [super loadView];
    _bgView =[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:_bgView];
    [self.view sendSubviewToBack:_bgView];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSURL *fileURL1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"rain1.mp4" ofType:nil]];
    [self createVideoPlayer:fileURL1];
    [self multedOnOff];
    [self playerAudio];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}
- (IBAction)btnShow:(id)sender {
    PopupWindowView *view = [[PopupWindowView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
}

- (void)playerAudio
{
    NSString *path =  [[NSBundle mainBundle] pathForResource:@"rain5" ofType:@"m4a"];
    self.audioPlayerRain1 = [[AVAudioPlayer alloc]initWithData:[NSData dataWithContentsOfFile:path] error:nil];
    self.audioPlayerRain1.numberOfLoops = 0;
    self.audioPlayerRain1.volume = 1;
    [self.audioPlayerRain1 play];
    
    NSString *pathThunder =  [[NSBundle mainBundle] pathForResource:@"thunder" ofType:@"m4a"];
    self.audioPlayerThunder = [[AVAudioPlayer alloc]initWithData:[NSData dataWithContentsOfFile:pathThunder] error:nil];
    self.audioPlayerThunder.numberOfLoops = 0;
    self.audioPlayerThunder.volume = 1;
    [self.audioPlayerThunder play];
}

//加载视频

- (void)createVideoPlayer:(NSURL *)contentURL  {
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:contentURL];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    self.player.volume =  0;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.videoGravity = AVLayerVideoGravityResize;
    playerLayer.frame = [UIScreen mainScreen].bounds;
    
    [self.bgView.layer addSublayer:playerLayer];
    [self.player play];
    
    
    [self.player.currentItem addObserver:self forKeyPath:AVPlayerItemDidPlayToEndTimeNotification options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    //    [[NSNotificationCenter]]
}

#pragma mark - observer of player
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
}

- (void)multedOnOff
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
    [audioSession setActive:YES error:nil];
    
}


// 视频循环播放
- (void)moviePlayDidEnd:(NSNotification*)notification{
    
    AVPlayerItem *item = [notification object];
    [item seekToTime:kCMTimeZero];
    [self.player play];
}

- (void)playerReplay
{
    NSLog(@"replay");
    [self.player play];
}



- (void)videoPlayWillEnterForeground:(NSNotification *)notice
{
    [self.player play];
    NSLog(@"Play");
    [self.audioPlayerRain1 play];
    [self.audioPlayerThunder play];
    
}

- (void)videoPlayDidEnterBackground:(NSNotification *)notice
{
    [self.player pause];
    NSLog(@"Play");
//    [self.audioPlayerRain1 play];
//    [self.audioPlayerThunder play];
}


-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
