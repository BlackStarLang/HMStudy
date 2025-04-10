import { NaviView } from "../../Component/NaviView";

@Entry
@Component
struct KeyframeAnimate {
  @Consume('NavPathStack') navPath: NavPathStack;
  @Consume naviMode: NavigationMode;
  @State translateY: number = 0;
  @State rotation: number = 0;
  @State animateScale: number = 1;
  @State animateAlpha: number = 1;
  private columns: GridRowColumnOption = {
    xs: 3,
    sm: 6,
    md: 6,
    lg: 6,
    xl: 6
  }

  build() {
    NavDestination() {
      NaviView({
        title: 'KeyframeAnimate',
        menus: [],
        backButtonClick: () => {
          this.navPath.pop(true);
        }
      })

      Column() {
        Shape() {
          Rect()
            .fill('#ff3683ff')
            .width("100%")
            .height("100%")
        }
        .margin({ top: 100, bottom: 100 })
        .height(50)
        .width(50)
        .translate({ x: 0, y: this.translateY })
        .rotate({
          x: 0,
          y: 0,
          z: 1,
          angle: this.rotation
        })
        .scale({ x: this.animateScale, y: this.animateScale, z: 1 })
        .opacity(this.animateAlpha)

        Text('开始播放')
          .fontSize(20)
          .textAlign(TextAlign.Center)
          .fontColor('#ffffffff')
          .backgroundColor('#ffff2828')
          .borderRadius(4)
          .padding({ top: 8, bottom: 8 , left: 10, right: 10 })
          .onClick(() => {
            this.startAnimate();
          })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .layoutWeight(1)
    }
    .hideTitleBar(true)
  }

  startAnimate() {
    this.getUIContext().keyframeAnimateTo({
      iterations: 2,
      onFinish: () => {
        this.translateY = 0;
        this.rotation = 0;
        this.animateScale = 1;
        this.animateAlpha = 1;
      }
    }, [
      {
        duration: 1000,
        curve: Curve.EaseIn,
        event: () => {
          this.translateY = -200;
        }
      },
      {
        duration: 1000,
        curve: Curve.Linear,
        event: () => {
          this.rotation = 180;
        }
      },
      {
        duration: 2000,
        curve: Curve.Linear,
        event: () => {
          this.rotation = 180 + 360;
          this.animateAlpha = 0;
          this.animateScale = 2.5;
        }
      }
    ])
  }
}

@Builder
export function KeyframeAnimateEntry() {
  KeyframeAnimate();
}