import { NaviView } from "../../Component/NaviView";

@Entry
@Component
struct AnimationPage {
  @Consume('NavPathStack') navPath: NavPathStack;
  @Consume naviMode: NavigationMode;
  private animateTypes: string[] =
    ['属性动画', '显式动画', '关键帧动画', '页面间转场', '组件内转场', '共享元素转场', '组件内隐式共享元素转场',
      '路径动画', '粒子动画', '显式动画立即下发'];
  private pushTarget: string[] =
    ['Animation', 'AnimateTo', 'KeyframeAnimate', 'PageTransition', 'KeyframeAnimate', 'KeyframeAnimate',
      'KeyframeAnimate',
      'KeyframeAnimate', 'KeyframeAnimate', 'KeyframeAnimate'];

  build() {
    NavDestination() {
      NaviView({
        title: 'AnimationPage',
        menus: [],
        backButtonClick: () => {
          this.navPath.pop(true);
        },
        hiddenBackButton: this.naviMode === NavigationMode.Split
      })

      List() {
        ForEach(this.animateTypes, (item: string, index) => {
          ListItem() {
            Text(item)
              .fontSize(20)
              .padding({ left: 20, right: 20 })
              .textAlign(TextAlign.Start)
          }
          .align(Alignment.Start)
          .height(60)
          .width('100%')
          .onClick(() => {
            this.navPath.pushDestinationByName(this.pushTarget[index], undefined, true);
          })
        }, (item: string) => item)
      }
      .divider({ strokeWidth: 0.5, color: '#4d000000', startMargin: 20 })
      .layoutWeight(1)
    }
    .hideTitleBar(true)
  }
}


@Builder
export function AnimationPageEntry() {
  AnimationPage();
}