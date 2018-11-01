import { findNodeHandle, NativeModules } from 'react-native'

const { RNAppTour } = NativeModules

class AppTour {
  static ShowSequence(sequence) {
    let appTourTargets = sequence.getAll()

    let viewIds = new Map(),
      sortedViewIds = [],
      props = {}

    appTourTargets &&
      appTourTargets.forEach((appTourTarget, key, appTourTargets) => {
        if (
          appTourTarget.props.order === undefined ||
          appTourTarget.props.order === null
        )
          throw new Error(
            'Each tour target should have a order mandatory props.'
          )

        viewIds.set(appTourTarget.props.order, appTourTarget.view)
        props[appTourTarget.view] = appTourTarget.props
      })

    let viewOrder = Array.from(viewIds.keys())
    viewOrder = viewOrder.sort((a, b) => a - b)

    viewOrder.forEach(vOrder => {
      sortedViewIds.push(viewIds.get(vOrder))
    })

    RNAppTour.ShowSequence(sortedViewIds, props)
  }

  static ShowFor(appTourTarget) {
    RNAppTour.ShowFor(appTourTarget.view, appTourTarget.props)
  }
}

class AppTourSequence {
  constructor() {
    this.appTourTargets = new Map()
  }

  add(appTourTarget) {
    this.appTourTargets.set(appTourTarget.key, appTourTarget)
  }

  remove(appTourTarget) {
    this.appTourTargets.delete(appTourTarget.key)
  }

  removeAll() {
    this.appTourTargets = new Map()
  }

  get(appTourTarget) {
    return this.appTourTargets.get(appTourTarget)
  }

  getAll() {
    return this.appTourTargets
  }
}

class AppTourView {
  static for(view, props) {
    if (view === undefined || view === null)
      throw new Error(
        'Provided tour view reference is undefined or null, please add a preliminary validation before adding for tour.'
      )

    if (
      view._reactInternalFiber === undefined ||
      view._reactInternalFiber === null) {
      throw new Error("Tour view does not have React Internal Fiber.");
    }

    if (
      view._reactInternalFiber.key === undefined ||
      view._reactInternalFiber.key === null
    )
      throw new Error(
        'Each tour view should have a key prop. Please check the tour component props.'
      )

    return {
      key: view._reactInternalFiber.key,
      view: findNodeHandle(view),
      props: props
    }
  }
}

export { AppTourView, AppTourSequence, AppTour }
