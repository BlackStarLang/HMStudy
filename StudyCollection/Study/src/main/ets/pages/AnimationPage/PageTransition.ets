import { AppUtil } from "@pura/harmony-utils";
import { NaviView } from "../../Component/NaviView";
import { CustomTransition } from "../PageTransitionSupport/PageTransitionSupport";

@Entry
@Component
struct PageTransition {
  @Consume('NavPathStack') navPath: NavPathStack;
  @Consume naviMode: NavigationMode;
  private transitionType: string[] = ['平移', '旋转', '缩放', '透明度', '组合'];
  @State translateOpt: TranslateOptions = { x: '0', y: '0' };
  @State rotationAngle: number = 0;
  @State translateScale: number = 0;
  @State animateAlpha: number = 1;
  private pageId: string = '0';
  private animateType: number = 0;

  build() {
    NavDestination() {
      NaviView({
        title: 'PageTransition',
        menus: [],
        backButtonClick: () => {
          this.navPath.pop(true);
        }
      })

      Grid() {
        ForEach(this.transitionType, (item: string, index: number) => {
          GridItem() {
            Text(item)
              .fontSize(20)
              .textAlign(TextAlign.Center)
              .fontColor('#ffffffff')
              .backgroundColor('#ffff2828')
              .borderRadius(4)
              .padding({
                top: 8,
                bottom: 8,
                left: 10,
                right: 10
              })
              .onClick(() => {
                this.animateType = index;
                this.navPath.pop(true);
              })
          }
        })
      }
      .rowsTemplate('1fr 1fr')
      .columnsTemplate('1fr 1fr 1fr')
      .rowsGap(10)
      .columnsGap(10)
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
    .scale({ x: this.translateScale, y: this.translateScale })
    .rotate({ angle: this.rotationAngle })
    .translate(this.translateOpt)
    .opacity(this.animateAlpha)
  }

  registerCallback() {
    CustomTransition.getInstance().registerNavParam(
      {
        animateId: this.pageId,
        // 设置转场动画起点，根据不同的转场类型分别设置
        beginState: (isPush: boolean, isAppear: boolean) => {
          if (isPush) {
            if (isAppear) {
              this.translateScale = 0;
              this.rotationAngle = 0;
            }
          } else {
            if (!isAppear) {
              this.popAnimation(true);
            }
          }
        },
        // 设置转场动画终点，根据不同的转场类型分别设置
        endState: (isPush: boolean, isAppear: boolean) => {
          if (isPush) {
            if (isAppear) {
              this.translateScale = 1;
              this.rotationAngle = 360;
            }
          } else {
            if (!isAppear) {
              this.popAnimation(false);
            }
          }
        }
      });
  }

  popAnimation(startState: boolean) {
    if (startState) {
      if (this.animateType === 0) {
        this.translateOpt = { x: '0', y: '0' };
      } else if (this.animateType === 1) {
        this.rotationAngle = 0;
      } else if (this.animateType === 2) {
        this.translateScale = 1;
      } else if (this.animateType === 3) {
        this.animateAlpha = 1;
      } else {
        this.translateOpt = { x: '0', y: '0' };
        this.rotationAngle = 0;
        this.translateScale = 1;
        this.animateAlpha = 1;
      }
    } else {
      if (this.animateType === 0) {
        this.translateOpt = { x: '100%', y: '100%' };
      } else if (this.animateType === 1) {
        this.rotationAngle = 360;
      } else if (this.animateType === 2) {
        this.translateScale = 0.3;
      } else if (this.animateType === 3) {
        this.animateAlpha = 0;
      } else {
        this.translateOpt = { x: '100%', y: '100%' };
        this.rotationAngle = 360;
        this.translateScale = 0.3;
        this.animateAlpha = 0;
      }
    }
  }
}


@Builder
export function PageTransitionEntry() {
  PageTransition();
}