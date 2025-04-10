import { NaviView } from "../../Component/NaviView";

@Entry
@Component
struct CanvasPage {
  dialSetting: RenderingContextSettings = new RenderingContextSettings();
  dialCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.dialSetting);
  setting: RenderingContextSettings = new RenderingContextSettings();
  ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.setting);
  @Consume('NavPathStack') navPath: NavPathStack;
  @Consume naviMode: NavigationMode;

  build() {
    NavDestination() {
      if (this.naviMode !== NavigationMode.Split) {
        NaviView({
          title: 'Canvas',
          menus: [],
          backButtonClick: () => {
            this.navPath.pop(true);
          }
        })
      }
      Stack() {
        Canvas(this.dialCtx)
          .width(300)
          .height(300)
          .onReady(() => {
            // this.drawTest(this.dialCtx);
            this.drawDial();
          })
        Canvas(this.ctx)
          .width(300)
          .height(300)
          .onReady(() => {
            this.animatePointer();
            setInterval(() => {
              this.animatePointer();
            }, 1000)
          })
      }
      .width("100%")
      .layoutWeight(1)
    }
    .hideTitleBar(true)
  }

  clear() {
    this.ctx.clearRect(0, 0, 300, 300);
  }

  drawDial() {
    this.dialCtx.save();
    this.dialCtx.translate(150, 150);
    this.dialCtx.beginPath();

    this.dialCtx.font = '45px Arial'; //文本尺寸
    this.dialCtx.fillStyle = '#000'; //指定绘制的填充色
    this.dialCtx.textAlign = 'center'; // 文本对齐
    this.dialCtx.textBaseline = 'middle'; //文本基线
    for (let n = 0; n < 12; n++) {
      let theta = (n - 2) * (Math.PI * 2) / 12;
      let x = clockRadius * 0.65 * Math.cos(theta);
      let y = clockRadius * 0.65 * Math.sin(theta);
      this.dialCtx.fillText(`${n + 1}`, x, y); // 表盘数字所在的位置
    }

    for (let index = 0; index < 60; index++) {
      let theta = index * (Math.PI * 2) / 60;
      this.dialCtx.beginPath();
      let x = clockRadius * 0.81 * Math.cos(theta);
      let y = clockRadius * 0.81 * Math.sin(theta);
      this.dialCtx.moveTo(x, y);

      if (index % 5 === 0) {
        let x1 = clockRadius * 0.75 * Math.cos(theta);
        let y1 = clockRadius * 0.75 * Math.sin(theta);
        this.dialCtx.lineTo(x1, y1);
        this.dialCtx.strokeStyle = '#ff2cb8ef';
        this.dialCtx.lineWidth = 3;
      } else {
        let x1 = clockRadius * 0.77 * Math.cos(theta);
        let y1 = clockRadius * 0.77 * Math.sin(theta);
        this.dialCtx.lineTo(x1, y1);
        this.dialCtx.strokeStyle = 'green';
        this.dialCtx.lineWidth = 2;
      }

      this.dialCtx.stroke();
    }
  }

  animatePointer() {
    this.clear();

    this.ctx.save();
    this.ctx.translate(150, 150);
    this.ctx.beginPath();

    let date = new Date();
    let hours = date.getHours();
    let minutes = date.getMinutes();
    let seconds = date.getSeconds();
    hours = hours > 12 ? hours - 12 : hours;
    let hour = hours + minutes / 60;
    let minute = minutes + seconds / 60;

    const grad = this.ctx.createLinearGradient(0, -2, clockRadius * 0.3 / 2, 2);
    grad.addColorStop(0.0, 'green');
    grad.addColorStop(1, '#ff318def');

    const hTheta: number = (hour - 3) * 2 * Math.PI / 12;
    this.drawPointer(hTheta, 0.3, grad, 10, 4);

    const grad1 = this.ctx.createLinearGradient(0, -2, clockRadius * 0.8 / 2, 2);
    grad1.addColorStop(0.0, '#ffff8bbe');
    grad1.addColorStop(1, '#ff0ccfe9');
    const mTheta: number = (minute - 15) * 2 * Math.PI / 60;
    this.drawPointer(mTheta, 0.45, grad1, 8, 4);

    const sTheta: number = (seconds - 15) * 2 * Math.PI / 60;
    this.drawPointer(sTheta, 0.6, '#ffb305a2', 4, 2);

    this.ctx.restore();
  }

  drawPointer(theta: number, scale: number, style: string | number | CanvasGradient | CanvasPattern, rootW: number,
    headerW: number) {
    this.ctx.save();
    this.ctx.rotate(theta);
    this.ctx.beginPath();
    this.ctx.moveTo(-15, -rootW / 2);
    this.ctx.lineTo(-15, rootW / 2)
    this.ctx.lineTo(clockRadius * scale, headerW / 2);
    this.ctx.lineTo(clockRadius * scale, -headerW / 2);
    this.ctx.fillStyle = style;
    this.ctx.fill();
    this.ctx.restore();
  }
}

const clockRadius = 180;


@Builder
export function CanvasPageEntry() {
  CanvasPage();
}