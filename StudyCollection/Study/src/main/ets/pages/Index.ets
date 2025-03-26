import router from '@ohos.router';

@Entry
@Component
struct Index {
  private dataArr: ListItemModel[] = ListItemModel.getListPageModels();
  private navPath: NavPathStack = new NavPathStack();

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
                  this.navPath.replacePath({ name: item.pathName, isEntry: true } , true);
                  // router.pushUrl({ url: item.pageUrl });
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
    .onAppear(()=>{
      this.navPath.pushPath({ name: this.dataArr[0].pathName, isEntry: true });
    })
    .title('HMStudy')
    .titleMode(NavigationTitleMode.Full)
    .mode(NavigationMode.Auto)
    .navBarWidth(280)
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