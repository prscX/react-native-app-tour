<h1 align="center">

  <p align="center">
    <a href="https://www.npmjs.com/package/react-native-app-tour"><img src="http://img.shields.io/npm/v/react-native-app-tour.svg?style=flat" /></a>
    <a href="https://github.com/prscX/react-native-app-tour/pulls"><img alt="PRs Welcome" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" /></a>
    <a href="https://github.com/prscX/react-native-app-tour#License"><img src="https://img.shields.io/npm/l/react-native-app-tour.svg?style=flat" /></a>
  </p>

    ReactNative: Native App Tour Library (Android/iOS)

If this project has helped you out, please support us with a star 🌟

</h1>

This library is a React Native bridge around native app tour libraries. It allows show/guide beautiful tours:

| **Android: [KeepSafe/TapTargetView](https://github.com/KeepSafe/TapTargetView)**                              |
| ------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/KeepSafe/TapTargetView/raw/master/.github/video.gif" width="300" height="600" /> |

| **iOS: [aromajoin/material-showcase-ios](https://github.com/aromajoin/material-showcase-ios)**                                 |
| ------------------------------------------------------------------------------------------------------------------------------ |
| <img src="https://github.com/aromajoin/material-showcase-ios/raw/master/art/material-showcase.gif" width="300" height="600" /> |

## 📖 Getting started

> **iOS Prerequisite:** Please make sure `CocoaPods` is installed on your system

## **RN60 >= RNBAS V1 >**

> RN60 above please use `react-native-app-tour` V1 and above

- **iOS**

	- Add the following to your `Podfile` -> `ios/Podfile` and run pod update:


```
  use_native_modules!

  pod 'RNAppTour', :path => '../node_modules/react-native-app-tour/ios'

  use_frameworks!

  pod 'MaterialShowcase', :git => 'https://github.com/prscX/material-showcase-ios', :branch => 'swift-version-fix'
```

- **Android**

Please add below snippet into your app `build.gradle`

```
allprojects {
    repositories {
        maven { url 'https://jitpack.io' }
    }
}
```

## **RN60 < RNBAS V1 <**

> RN60 below please use `react-native-app-tour` V.0.*


`$ npm install react-native-app-tour --save`

`$ react-native link react-native-app-tour`

- **Android**

  - Please add below script in your `build.gradle`

allprojects {
    repositories {
        maven { url "https://jitpack.io" }
        ...
    }
}
```

> **Note**
>
> - Android SDK 27 > is supported

- **iOS**

  - After `react-native link react-native-app-tour`, please verify `node_modules/react-native-app-tour/ios/` contains `Pods` folder. If does not exist please execute `pod install` command on `node_modules/react-native-app-tour/ios/`, if any error => try `pod repo update` then `pod install`
  - After verification, open your project and create a folder 'RNAppTour' under Libraries.
  - Drag `node_modules/react-native-app-tour/ios/pods/Pods.xcodeproject` into RNAppTour, as well as the RNAppTour.xcodeproject if it does not exist.
  - Add the `MaterialShowcase.framework` into your project's `Embedded Binaries` and make sure the framework is also in linked libraries.
  - Go to your project's `Build Settings -> Frameworks Search Path` and add `${BUILT_PRODUCTS_DIR}/MaterialShowcase` non-recursive.

  - Now build your iOS app through Xcode

## 💬 ISSUES

- If you install this package and get an error saying postinstall failed this most likely means
  - You are trying to run install modules from outside of project root (react-native-git-upgrade) 
    - FIX: remove react-native-app-tour from package.json and rerun
  - Pods version is out of date.
    - `pod repo update`
- If you encounter `File not found in iOS` issue while setup, please refer [ISSUE - 3](https://github.com/prscX/react-native-app-tour/issues/3) issue which might help you in order to resolve.
- If you have problems with `Android` Trying to resolve view with tag which doesn't exist or can't resolve tag. Please add props `collapasable: false` to your View

## 🎨 API's

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

## 💡 Props

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

| Prop                     | Type                | Default | Note                                                                                                                                                                           |
| ------------------------ | ------------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `collapsable: mandatory` | `bool`              |         | Specify collapsable `false` if your view just contains children. Please read [view#collapsable](https://facebook.github.io/react-native/docs/view#collapsable) for the details |
| `outerCircleAlpha`       | `number`            | 0.96f   | Specify the alpha amount for the outer circle                                                                                                                                  |
| `textColor`              | `string: HEX-COLOR` |         | Specify a color for both the title and description text                                                                                                                        |
| `dimColor`               | `string: HEX-COLOR` |         | If set, will dim behind the view with 30% opacity of the given color                                                                                                           |
| `drawShadow`             | `bool`              | true    | Whether to draw a drop shadow or not                                                                                                                                           |
| `tintTarget`             | `bool`              | true    | Whether to tint the target view's color                                                                                                                                        |
| `transparentTarget`      | `bool`              | true    | Specify whether the target is transparent (displays the content underneath)                                                                                                    |

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

## 🔧 Breaking Changes

- [V0.0.4](https://github.com/prscX/react-native-app-tour/releases/tag/v0.0.4)

  - Generalized props across platforms @congnguyen91
  - Migrated License to Apache 2.0

- [V0.0.10](https://github.com/prscX/react-native-app-tour/releases/tag/v0.0.10)
  - Added `order` as a mandatory property to each target
  - Each component which is to be rendered in the tour should have a `key` prop. It is mandatory.

## ✨ Credits

- Android: [KeepSafe/TapTargetView](https://github.com/KeepSafe/TapTargetView)
- iOS: [aromajoin/material-showcase-ios](https://github.com/aromajoin/material-showcase-ios)

## 🤔 How to contribute

Have an idea? Found a bug? Please raise to [ISSUES](https://github.com/prscX/react-native-app-tour/issues).
Contributions are welcome and are greatly appreciated! Every little bit helps, and credit will always be given.

## 💫 Where is this library used?

If you are using this library in one of your projects, add it in this list below. ✨

## 📜 License

This library is provided under the Apache 2 License.

RNAppTour @ [prscX](https://github.com/prscX)

## 💖 Support my projects

I open-source almost everything I can, and I try to reply everyone needing help using these projects. Obviously, this takes time. You can integrate and use these projects in your applications for free! You can even change the source code and redistribute (even resell it).

However, if you get some profit from this or just want to encourage me to continue creating stuff, there are few ways you can do it:

- Starring and sharing the projects you like 🚀
- If you're feeling especially charitable, please follow [prscX](https://github.com/prscX) on GitHub.

  <a href="https://www.buymeacoffee.com/prscX" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>

  Thanks! ❤️
  <br/>
  [prscX.github.io](https://prscx.github.io)
  <br/>
  </ Pranav >
