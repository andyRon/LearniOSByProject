//
//  ViewController.m
//  ARSocketDemo
//
//  Created by andyron on 2017/9/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *recvLabel;
@property (strong, nonatomic) IBOutlet UITextField *hostText;
@property (strong, nonatomic) IBOutlet UITextField *portText;
@property (strong, nonatomic) IBOutlet UITextField *messageText;

@property (nonatomic, assign) int clientSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)connection:(id)sender {
    if ([self connection:self.hostText.text port:self.portText.text.intValue]) {
        self.recvLabel.text = @"connection success";
        NSLog( @"connection success");
    } else {
        self.recvLabel.text = @"connection error";
        NSLog( @"connection error");
    }
}

- (IBAction)send:(id)sender {
    self.recvLabel.text = [self sendAndRecv:self.messageText.text];

}

// MARK: Socket
- (BOOL)connection:(NSString *)hostText port:(int)port {
    
    self.clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    
    if (self.clientSocket > 0) {
        NSLog(@"Socket 创建成功 %d", self.clientSocket);
    } else {
        NSLog(@"Socket 创建失败");
    }
    
    struct sockaddr_in serverAddress;
    
    serverAddress.sin_family = AF_INET;
    
    serverAddress.sin_addr.s_addr = inet_addr(hostText.UTF8String);
    
    serverAddress.sin_port = htons(port);
    
    int result = connect(self.clientSocket, (const struct sockaddr *)&serverAddress, sizeof(serverAddress));
    
    return (result == 0);
}

- (NSString *)sendAndRecv: (NSString *)message {
    
    ssize_t sendLen = send(self.clientSocket, message.UTF8String, strlen(message.UTF8String), 0);
    NSLog(@"%ld", sendLen);
    
    uint8_t buffer[1024];
    
    ssize_t recvLen = recv(self.clientSocket, buffer, sizeof(buffer), 0);
    
    NSData *data = [NSData dataWithBytes:buffer length:recvLen];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}

- (void)disConnection {
    close(self.clientSocket);
}


@end
