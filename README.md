<p align="center">
  <a href="https://www.npmjs.com/package/react-native-taptargetview"><img src="http://img.shields.io/npm/v/react-native-taptargetview.svg?style=flat" /></a>
  <a href="https://github.com/prscX/react-native-taptargetview/pulls"><img alt="PRs Welcome" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" /></a>
  <a href="https://github.com/prscX/react-native-taptargetview#License"><img src="https://img.shields.io/npm/l/react-native-taptargetview.svg?style=flat" /></a>
</p>

# React Native: Native App Tour Library

This library is a React Native bridge around native app tour libraries. It allows show/guide beautiful tours:

| **Android: [KeepSafe/TapTargetView](https://github.com/KeepSafe/TapTargetView)**                              |
| ------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/KeepSafe/TapTargetView/raw/master/.github/video.gif" width="300" height="600" /> |

| **iOS: [aromajoin/material-showcase-ios](https://github.com/aromajoin/material-showcase-ios)**                                 |
| ------------------------------------------------------------------------------------------------------------------------------ |
| <img src="https://github.com/aromajoin/material-showcase-ios/raw/master/art/material-showcase.gif" width="300" height="600" /> |

## Installation

`$ npm install react-native-app-tour --save`

`$ react-native link react-native-app-tour`

- **Android**

  - Please add below script in your `build.gradle`

```
buildscript {
    repositories {
        jcenter()
        maven { url "https://maven.google.com" }
        maven { url "https://jitpack.io" }
        ...
    }
}

allprojects {
    repositories {
        mavenLocal()
        jcenter()
        maven { url "https://maven.google.com" }
        maven { url "https://jitpack.io" }
        ...
    }
}
```

> **Note**
>
> - Android SDK 27 > is supported

- **iOS**

  - Run Command: `cd ../node_modules/react-native-app-tour/ios && pod install`. If it has error => try `pod repo update` then `pod install`
  - - Add [aromajoin/material-showcase-ios](https://github.com/aromajoin/material-showcase-ios) in your app Embedded Binaries & Linked Frameworks and Libraries. Please follow below video in order to achieve the same:

  - Please refer below installation video created by @Noitidart:

[![iOS Installation Guide](https://img.youtube.com/vi/iBjsCrEtYW4/0.jpg)](https://www.youtube.com/watch?v=iBjsCrEtYW4)

- Now build your iOS app through Xcode

## ISSUES

- If you encounter `File not found in iOS` issue while setup, please refer [ISSUE - 3](https://github.com/prscX/react-native-app-tour/issues/3) issue which might help you in order to resolve.
- If you have problems with `Android` Trying to resolve view with tag which doesn't exist or can't resolve tag. Please add props `collapasable: false` to your View

## API's

- AppTourView.for: AppTourTarget

```
let appTourTarget = AppTourView.for(Button, {...native-library-props})

AppTour.ShowFor(appTourTarget)
```

- AppTourSequence
  - add(AppTourTarget)
  - remove(AppTourTarget)
  - removeAll
  - get(AppTourTarget)
  - getAll

```
let appTourSequence = new AppTourSequence()
this.appTourTargets.forEach(appTourTarget => {
appTourSequence.add(appTourTarget)
})

AppTour.ShowSequence(appTourSequence)
```

- AppTour
  - ShowFor(AppTourTarget)
  - ShowSequence(AppTourTargets)

## Props

> **Note:**
>
> - Each component which is to be rendered in the tour should have a `key` prop. It is mandatory.
> - App Tour Target Properties are same as defined by [KeepSafe/TapTargetView](https://github.com/KeepSafe/TapTargetView) & [aromajoin/material-showcase-ios](https://github.com/aromajoin/material-showcase-ios)

- **General(iOS & Android)**

| Prop                   | Type                | Default | Note                                             |
| ---------------------- | ------------------- | ------- | ------------------------------------------------ |
| `order: mandatory`     | `number`            |         | Specify the order of tour target                 |
| `title`                | `string`            |         | Specify the title of tour                        |
| `description`          | `string`            |         | Specify the description of tour                  |
| `outerCircleColor`     | `string: HEX-COLOR` |         | Specify a color for the outer circle             |
| `targetCircleColor`    | `string: HEX-COLOR` |         | Specify a color for the target circle            |
| `titleTextSize`        | `number`            | 20      | Specify the size (in sp) of the title text       |
| `titleTextColor`       | `string: HEX-COLOR` |         | Specify the color of the title text              |
| `descriptionTextSize`  | `number`            | 10      | Specify the size (in sp) of the description text |
| `descriptionTextColor` | `string: HEX-COLOR` |         | Specify the color of the description text        |
| `targetRadius`         | `number`            | 60      | Specify the target radius (in dp)                |
| `cancelable`           | `bool`              | true    | Whether tapping anywhere dismisses the view      |

- **Android**

| Prop                | Type                | Default | Note                                                                        |
| ------------------- | ------------------- | ------- | --------------------------------------------------------------------------- |
| `outerCircleAlpha`  | `number`            | 0.96f   | Specify the alpha amount for the outer circle                               |
| `textColor`         | `string: HEX-COLOR` |         | Specify a color for both the title and description text                     |
| `dimColor`          | `string: HEX-COLOR` |         | If set, will dim behind the view with 30% opacity of the given color        |
| `drawShadow`        | `bool`              | true    | Whether to draw a drop shadow or not                                        |
| `tintTarget`        | `bool`              | true    | Whether to tint the target view's color                                     |
| `transparentTarget` | `bool`              | true    | Specify whether the target is transparent (displays the content underneath) |

- **iOS**

| Prop                         | Type                | Default      | Note                                                       |
| ---------------------------- | ------------------- | ------------ | ---------------------------------------------------------- |
| `backgroundPromptColor`      | `string: HEX-COLOR` | UIColor.blue | Specify background prompt color                            |
| `backgroundPromptColorAlpha` | `number`            | 0.96         | Specify background prompt color alpha                      |
| `titleTextAlignment`         | `string`            | left         | Specify primary text alignment: Left, Right, Top, Bottom   |
| `descriptionTextAlignment`   | `string`            | left         | Specify secondary text alignment: Left, Right, Top, Bottom |
| `aniComeInDuration`          | `number`            | 0.5          | Specify animation come In Duration                         |
| `aniGoOutDuration`           | `number`            | 1.5          | Specify animation Go Out Duration                          |
| `aniRippleColor`             | `string: HEX-COLOR` | #FFFFFF      | Specify ripple color                                       |
| `aniRippleAlpha`             | `number`            | 0.2          | Specify ripple alpha                                       |

## Breaking Changes

- [V0.0.4](https://github.com/prscX/react-native-app-tour/releases/tag/v0.0.4)
  - Generalized props across platforms @congnguyen91
  - Migrated License to Apache 2.0

## Credits

- Android: [KeepSafe/TapTargetView](https://github.com/KeepSafe/TapTargetView)
- iOS: [aromajoin/material-showcase-ios](https://github.com/aromajoin/material-showcase-ios)

## Contribution

Contributions are welcome and are greatly appreciated! Every little bit helps, and credit will always be given.

## License

This library is provided under the Apache 2.0 License.

RNAppTour @ Pranav Raj Singh Chauhan
