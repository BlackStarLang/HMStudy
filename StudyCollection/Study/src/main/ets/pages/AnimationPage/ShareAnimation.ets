import { NaviView } from "../../Component/NaviView";
import { router } from "@kit.ArkUI";

@Entry
@Component
struct ShareAnimation {
  build() {
    Column() {
      NaviView({
        title: 'ShareAnimation',
        menus: [],
        backButtonClick: () => {
          router.back();
        }
      })

      Blank();

      Image($r('app.media.startIcon'))
        .width(200)
        .height(200)
        .sharedTransition('sharedImage', { duration: 1000, curve: Curve.Linear, delay: 100 })
        .margin({ bottom: 40 })

      Blank();
    }
    .height('100%')
    .width('100%')
  }
}


@Builder
export function ShareAnimationEntry() {
  ShareAnimation();
}
