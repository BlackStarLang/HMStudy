import { AppUtil } from "@pura/harmony-utils";
import { NaviView } from "../../Component/NaviView";

@Entry
@Component
struct PageTransition {
  @Consume('NavPathStack') navPath: NavPathStack;
  @Consume naviMode: NavigationMode;
  private transitionType: string[] = ['平移', '旋转', '缩放', '透明度', '组合'];
  @State transitionX: number = 0;

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
  }

  pageTransition() {
    PageTransitionEnter({ duration: 1200, curve: Curve.Linear })
      .onEnter((type: RouteType, progress: number) => {
        if (type === RouteType.Push || type === RouteType.Pop) {
          this.transitionX = 500 * progress;
        }
      })
  }
}


@Builder
export function PageTransitionEntry() {
  PageTransition();
}