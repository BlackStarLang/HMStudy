import router from '@ohos.router';

@Entry
@Component
struct Index {
  private dataArr: ListItemModel[] = ListItemModel.getListPageModels();
  @Provide('NavPathStack') navPath: NavPathStack = new NavPathStack();
  @Provide naviMode: NavigationMode = NavigationMode.Auto;//分栏检测
  @State currentIndex : number = 0;

  build() {
    Navigation(this.navPath) {
      List() {
        ForEach(this.dataArr, (item: ListItemModel, index) => {
          ListItem() {
            Row() {
              Text(item.title)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .width('100%')
                .height('55')
                .margin({ left: '20', right: '20' })
                .onClick(() => {
                  console.log('lang : count = ' , this.navPath.size());
                  if (this.currentIndex === index && this.naviMode === NavigationMode.Split && this.navPath.size() <= 1 ) {
                    return;
                  }
                  if (this.naviMode === NavigationMode.Split) {
                    if (this.navPath.size() <= 1) {
                      this.navPath.replacePath({ name: item.pathName }, true);
                    } else {
                      this.navPath.popToIndex(0, false);
                      if (this.currentIndex !== index){
                        this.navPath.replacePath({ name: item.pathName }, true);
                      }
                    }
                  } else {
                    this.navPath.pushPath({ name: item.pathName }, true);
                  }
                  this.currentIndex = index;
                })
            }
            .width('100%')
            .height('55')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }
        })
      }
      .divider({
        strokeWidth: '0.5',
        color: "#27000000",
        startMargin: '20',
        endMargin: '20'
      })
      .width('100%')
      .height('100%')
    }
    .title('HMStudy')
    .titleMode(NavigationTitleMode.Full)
    .mode(NavigationMode.Auto)
    .navBarWidth(280)
    .onNavigationModeChange((mode: NavigationMode) => {
      this.naviMode = mode;
      if (this.naviMode === NavigationMode.Split && this.navPath.size() <= 0) {
        this.navPath.replacePath({ name: 'CanvasPage' }, true);
        this.currentIndex = 0;
      }
    })
  }
}


class ListItemModel {
  public title: string = '';
  public pageUrl: string = '';
  public pathName: string = '';

  static getListPageModels(): ListItemModel[] {
    return [
      { title: '画布', pageUrl: 'pages/CanvasPage', pathName: 'CanvasPage' },
      { title: '动画', pageUrl: 'pages/AnimationPage', pathName: 'AnimationPage' },
      { title: '手势', pageUrl: 'pages/GesturePage', pathName: 'GesturePage' },
      { title: '布局', pageUrl: 'pages/LayoutPage', pathName: 'LayoutPage' },
      { title: '列表', pageUrl: 'pages/ListPage', pathName: 'ListPage' },
      { title: '表单', pageUrl: 'pages/FormPage', pathName: 'FormPage' },
      { title: '媒体', pageUrl: 'pages/MediaPage', pathName: 'MediaPage' },
      { title: '导航', pageUrl: 'pages/NavigationPage', pathName: 'NavigationPage' },
      { title: '设备', pageUrl: 'pages/DevicePage', pathName: 'DevicePage' },
      { title: '系统', pageUrl: 'pages/SystemPage', pathName: 'SystemPage' },
      { title: '其他', pageUrl: 'pages/OtherPage', pathName: 'OtherPage' }
    ];
  }
}