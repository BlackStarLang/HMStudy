@Entry
@Component
struct MediaPage {
  build() {
    Column() {
      Text('MediaPage').fontSize(50).fontWeight(FontWeight.Bold)
    }
  }
}

@Builder
export function MediaPageEntry() {
  MediaPage();
}