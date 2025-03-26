@Entry
@Component
struct OtherPage {
  build() {
    Column() {

    }
  }
}

@Builder
export function OtherPageEntry() {
  OtherPage();
}