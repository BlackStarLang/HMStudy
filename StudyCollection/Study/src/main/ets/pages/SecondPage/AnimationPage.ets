@Entry
@Component
struct AnimationPage {
  build() {
    NavDestination() {
      Column() {
        Text('AnimationPage')
          .fontSize(50)
          .textAlign(TextAlign.Center)
          .width('100%')
          .height('100%')
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .width('100%').height('100%')
    }
  }
}


@Builder
export function AnimationPageEntry() {
  AnimationPage();
}