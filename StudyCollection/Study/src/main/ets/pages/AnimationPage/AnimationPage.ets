import { NaviView } from "../../Component/NaviView";
import { CustomTransition } from "../PageTransitionSupport/PageTransitionSupport";

@Entry
@Component
struct AnimationPage {
  @Consume('NavPathStack') navPath: NavPathStack;
  @Consume naviMode: NavigationMode;
  private animateTypes: string[] =
    ['属性动画(完成)', '显式动画(完成)', '关键帧动画(完成)', 'Navigation页面间转场(完成)', '组件内动画(完成)',
      '路径动画', '粒子动画',];
  private pushTarget: string[] =
    ['Animation', 'AnimateTo', 'KeyframeAnimate', 'PageTransition', 'ComponentAnimate', 'KeyframeAnimate',
      'KeyframeAnimate'];
  private pageId: string = '';

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
      .width('100%')
      .divider({ strokeWidth: 0.5, color: '#4d000000', startMargin: 20 })
      .layoutWeight(1)
    }
    .hideTitleBar(true)
    .onDisAppear(() => {
      // 页面销毁时解注册自定义转场动画参数
      CustomTransition.getInstance().unRegisterNavParam(this.pageId);
    })
    .onReady((context: NavDestinationContext) => {
      if (context.navDestinationId) {
        this.pageId = context.navDestinationId;
        this.registerCallback();
      }
    })
  }

  registerCallback() {
    CustomTransition.getInstance().registerNavParam({
      animateId: this.pageId,
      beginState: () => {
      },
      endState: () => {
      }
    });
  }
}


@Builder
export function AnimationPageEntry() {
  AnimationPage();
}