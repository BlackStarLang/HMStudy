import { JSONUtil } from '@pura/harmony-utils';
import { NaviView } from '../../Component/NaviView';
import { router } from '@kit.ArkUI';


@Component
@Entry
struct ComponentAnimate {
  @Consume('NavPathStack') navPath: NavPathStack;
  @State transitionShow: boolean = true;
  @State geometryTransitionShow: boolean = true;

  build() {
    NavDestination() {
      Column() {
        NaviView({
          title: 'ComponentAnimate',
          menus: [],
          backButtonClick: () => {
            this.navPath.pop(true);
          }
        });

        Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceEvenly }) {

          Navigator({ target: 'pages/AnimationPage/ShareAnimation', type: NavigationType.Push }) {
            Image($r('app.media.startIcon'))
              .width(100)
              .height(100)
              .sharedTransition('sharedImage', { duration: 1000, curve: Curve.Linear, delay: 100 })
          }

          if (this.transitionShow) {
            Image($r('app.media.startIcon'))
              .width(100)
              .height(100)
              .transition(TransitionEffect.OPACITY.animation({ duration: 1000 })
                .combine(TransitionEffect.rotate({ angle: 180 }).animation({ duration: 1000 })))
          }

          if (this.geometryTransitionShow) {
            Image($r('app.media.startIcon'))
              .width(100)
              .height(100)
              .geometryTransition('shareImage')
              .transition(TransitionEffect.OPACITY)
          } else {
            Image($r('app.media.animateIcon'))
              .width(200)
              .height(200)
              .geometryTransition('shareImage')
              .transition(TransitionEffect.OPACITY)
          }
        }

        Blank().height(200);

        Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceEvenly }) {

          Text('共享元素转场')
            .testStyle()
            .onClick(() => {
              router.pushUrl({ url: 'pages/AnimationPage/ShareAnimation', params: { isSecond: true } })
            })

          Text('组件内转场')
            .testStyle()
            .onClick(() => {
              ///这里加不加 animateTo 都可以，不影响组件内转场动画，
              // 但是会影响其他组件是否做动画
              // 比如 transitionShow = 改变时，右侧的图片会不做动画，取决于这里是否有 animateTo
              animateTo({ duration: 1000 }, () => {
                this.transitionShow = !this.transitionShow;
              });
            });

          Text('组件内隐式共享元素转场')
            .testStyle()
            .onClick(() => {
              animateTo({ duration: 1000 }, () => {
                this.geometryTransitionShow = !this.geometryTransitionShow;
              })
            })
        }
      }
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
  }
}


@Extend(Text)
function testStyle() {
  .fontSize(20)
  .fontColor('#ffffffff')
  .backgroundColor('#ffff2828')
  .borderRadius(4)
  .width(150)
  .height(60)
  .textAlign(TextAlign.Center)
}

@Builder
function ComponentAnimateEntry() {
  ComponentAnimate();
}