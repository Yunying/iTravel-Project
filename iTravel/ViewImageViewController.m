//
//  ViewImageViewController.m
//  iTravel
//
//  Created by YUNYING TU on 12/5/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#import "ViewImageViewController.h"

@interface ViewImageViewController ()

@end

@implementation ViewImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:browser];
    
    _photos = [[NSMutableArray alloc] init];
    for (int i=0; i<_rawPhotos.count; i++){
        [_photos addObject:[MWPhoto photoWithImage:_rawPhotos[i]]];
    }
    
    
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:0];
    
    // Present
    [self.navigationController pushViewController:nc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

@end
