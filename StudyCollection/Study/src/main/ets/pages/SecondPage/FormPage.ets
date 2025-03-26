@Entry
@Component
struct FormPage {
  build() {
    Column() {
      Text('FormPage').fontSize(50).fontWeight(FontWeight.Bold).margin({ top: 20 })
      Button('submit').onClick(() => {
        console.log('submit')
      }).margin({ top: 20 })
      Button('reset').onClick(() => {
        console.log('reset')
      }).margin({ top: 20 })
      Button('cancel').onClick(() => {
        console.log('cancel')
      })
    }
  }
}

@Builder
export function FormPageEntry() {
  FormPage();
}