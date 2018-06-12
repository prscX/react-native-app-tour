import { findNodeHandle, NativeModules } from "react-native";

const { RNAppTour } = NativeModules;

class AppTour {
  static ShowSequence(sequence) {
    let appTourTargets = sequence.getAll();

    let viewIds = [];
    let props = {};

    appTourTargets &&
      appTourTargets.forEach((appTourTarget, key, appTourTargets) => {
        viewIds.push(appTourTarget.view);
        props[appTourTarget.view] = appTourTarget.props;
      });

    RNAppTour.ShowSequence(viewIds, props);
  }

  static ShowFor(appTourTarget) {
    RNAppTour.ShowFor(appTourTarget.view, appTourTarget.props);
  }
}

class AppTourSequence {
  constructor() {
    this.appTourTargets = new Map();
  }

  add(appTourTarget) {
    this.appTourTargets.set(appTourTarget.key, appTourTarget);
  }

  remove(appTourTarget) {
    this.appTourTargets.delete(appTourTarget.key);
  }

  removeAll() {
    this.appTourTargets = new Map();
  }

  get(appTourTarget) {
    return this.appTourTargets.get(appTourTarget);
  }

  getAll() {
    return this.appTourTargets;
  }
}

class AppTourView {
  static for(view, props) {
    return {
      key: view._reactInternalFiber.key,
      view: findNodeHandle(view),
      props: props
    };
  }
}

export { AppTourView, AppTourSequence, AppTour };
