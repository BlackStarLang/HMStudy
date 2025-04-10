import { AppUtil } from "@pura/harmony-utils";

@Component
export struct NaviView {
  title: string = '';
  menus: NaviMenu[] = [];
  @Prop hiddenBackButton: boolean = false;
  @Require backButtonClick: VoidCallback | undefined;

  build() {
    Stack() {
      Row() {
        Image($r('app.media.navi_back'))
          .width(30)
          .height(30)
          .margin({ left: 20 })
          .visibility(this.hiddenBackButton ? Visibility.Hidden : Visibility.Visible)
          .onClick(() => {
            if (this.backButtonClick) {
              this.backButtonClick();
            }
          })

        Row() {
          ForEach(this.menus, (item: NaviMenu, index) => {
            Column() {
              if (item.icon) {
                Image(item.icon)
                  .width(30)
                  .height(30)
                  .margin({ right: 20 })
              }
              if (item.title) {
                Text(item.title)
                  .fontSize(20)
                  .fontWeight(500)
                  .margin({ right: 20 })
              }
            }
            .justifyContent(FlexAlign.SpaceEvenly)
            .onClick(() => {
              if (item.menuClick) {
                item.menuClick(index);
              }
            })
          })
        }
      }
      .width("100%")
      .height("100%")

      Text(this.title)
        .fontSize(20)
        .fontWeight(500)
        .margin({ left: 60, right: 60 })
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
    }
    .alignContent(Alignment.Center)
    .height(64)

    // .margin({ top: px2vp(AppUtil.getStatusBarHeight()) })
  }
}

class NaviMenu {
  title: string | undefined;
  icon: string | Resource | undefined;
  menuClick: ((index: number) => void) | undefined;
}