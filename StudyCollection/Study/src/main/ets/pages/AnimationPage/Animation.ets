import { NaviView } from "../../Component/NaviView";

@Entry
@Component
struct Animation {
  @Consume('NavPathStack') navPath: NavPathStack;
  @Consume naviMode: NavigationMode;
  private animateTypes: string[] = ['平移', '旋转', '缩放', '透明度', '组合'];
  @State translateX: number = 0;
  @State rotation: number = 0;
  @State animateScale: number = 1;
  @State animateAlpha: number = 1;
  private columns: GridRowColumnOption = { xs: 3, sm: 5 }

  build() {
    NavDestination() {
      NaviView({
        title: 'Animation',
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
        .translate({ x: this.translateX, y: 0 })
        .rotate({
          x: 0,
          y: 0,
          z: 1,
          angle: this.rotation
        })
        .scale({ x: this.animateScale, y: this.animateScale, z: 1 })
        .opacity(this.animateAlpha)
        .animation({
          duration: 2000,
          iterations: 1,
          curve: Curve.EaseOut,
          playMode: PlayMode.Normal,
          onFinish: () => {
            this.translateX = 0;
            this.rotation = 0;
            this.animateScale = 1;
            this.animateAlpha = 1;
          }
        })

        GridRow({
          columns: this.columns,
          gutter: { x: 15, y: 10 },
          breakpoints: { value: ['600vp'], reference: BreakpointsReference.ComponentSize },
          direction: GridRowDirection.Row
        }) {
          ForEach(this.animateTypes, (item: string, index) => {
            GridCol({ span: 1 }) {
              Text(item)
                .fontSize(20)
                .textAlign(TextAlign.Center)
                .fontColor('#ffffffff')
                .backgroundColor('#ffff2828')
                .borderRadius(4)
                .padding({ top: 8, bottom: 8 })
                .width(80)
                .onClick(() => {
                  this.animateWithIndex(index);
                })
            }
          }, (item: string) => item)
        }
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .layoutWeight(1)
    }
    .hideTitleBar(true)
  }

  animateWithIndex(index: number) {
    if (index === 0) {
      this.translateX = 200;
    } else if (index === 1) {
      this.rotation = 90;
    } else if (index === 2) {
      this.animateScale = 2;
    } else if (index === 3) {
      this.animateAlpha = 0;
    } else if (index === 4) {
      this.translateX = 200;
      this.rotation = 90;
      this.animateScale = 2;
      this.animateAlpha = 0;
    }
  }
}

@Builder
export function AnimationEntry() {
  Animation();
}