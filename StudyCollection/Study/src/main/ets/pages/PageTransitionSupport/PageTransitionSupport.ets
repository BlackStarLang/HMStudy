const customTransitionMap: Map<string, AnimateState> = new Map();

type AnimateCallBack = (isPush: boolean, isAppear: boolean) => void;

export class CustomTransition {
  static delegate = new CustomTransition();

  static getInstance() {
    return CustomTransition.delegate;
  }

  registerNavParam(animateState: AnimateState): void {
    if (customTransitionMap.has(animateState.animateId)) {
      let param = customTransitionMap.get(animateState.animateId);
      if (param != undefined) {
        customTransitionMap.set(animateState.animateId, animateState);
      } else {
        this.unRegisterNavParam(animateState.animateId);
      }
    } else {
      customTransitionMap.set(animateState.animateId, animateState);
    }
  }

  unRegisterNavParam(animateId: string): void {
    customTransitionMap.delete(animateId);
  }

  getAnimateParam(animateId: string): AnimateState {
    let animateState = customTransitionMap.get(animateId);
    if (!animateState) {
      animateState = {
        animateId: animateId,
        beginState: undefined,
        endState: undefined
      }
    }
    return animateState;
  }
}

export interface AnimateState {
  // 动画id，用于存储不同页面的动画参数
  // 可以使用context.navDestinationId作为动画id
  animateId: string;

  //动画开始时的状态设置回调
  beginState: AnimateCallBack | undefined;

  //动画结束时的状态设置回调
  endState: AnimateCallBack | undefined;
}
