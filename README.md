<p align="center">
  <a href="https://www.npmjs.com/package/react-native-taptargetview"><img src="http://img.shields.io/npm/v/react-native-taptargetview.svg?style=flat" /></a>
  <a href="https://github.com/prscX/react-native-taptargetview/pulls"><img alt="PRs Welcome" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" /></a>
  <a href="https://github.com/prscX/react-native-taptargetview#License"><img src="https://img.shields.io/npm/l/react-native-taptargetview.svg?style=flat" /></a>
</p>

# React Native: Native App Tour Library

This library is a React Native bridge around native app tour libraries. It allows show/guide beautiful tours:

| **Android: [KeepSafe/TapTargetView](https://github.com/KeepSafe/TapTargetView)**             |
| ----------------- |
| <img src="https://github.com/KeepSafe/TapTargetView/raw/master/.github/video.gif" width="300" height="600" />                  |


| **iOS: [aromajoin/material-showcase-ios](https://github.com/aromajoin/material-showcase-ios)**             |
| ----------------- |
| <img src="https://github.com/aromajoin/material-showcase-ios/raw/master/art/material-showcase.gif" width="300" height="600" />                  |


## Installation

`$ npm install react-native-app-tour --save`

`$ react-native link react-native-app-tour`

- **Android**

  - Please add below script in your `build.gradle`

```
buildscript {
    repositories {
        jcenter()
        maven { url "https://jitpack.io" }
    }
}

allprojects {
    repositories {
        maven { url "https://jitpack.io" }
    }
}
```

> **Note**
>
> * Android SDK 25 > is supported


- **iOS**
  - Run Command if Pods is not installed in your app: `cd ios/ && pod init`
  - Add [aromajoin/material-showcase-ios](https://github.com/aromajoin/material-showcase-ios) in your app `Podfile`
    ```
      #pod 'MaterialShowcase'
      pod 'MaterialShowcase', '~> 0.5.1'
      
      post_install do |installer|
          installer.pods_project.targets.each do |target|
              if target.name.include?('MaterialShowcase')
                  target.build_configurations.each do |config|
                      # swift version 4.0 for xcode 9
                      config.build_settings['SWIFT_VERSION'] = '4.0'
                      # swift version 3.2 for xcode 8
                      #config.build_settings['SWIFT_VERSION'] = '3.2'
                  end
              end
          end
      end
    ```
  - Run Command to install native library: `cd ios/ && pod install`: If it has error => try `pod repo update` then `pod install`
  - Add [aromajoin/material-showcase-ios](https://github.com/aromajoin/material-showcase-ios) in Embedded Binaries & Linked Frameworks and Libraries. You can find this library from below path:

`ios/Pods/Pods.xcodeproj`

<img src="./Example/assets/linking.png" />

## Setup Issue References
If you encounter issues with respect to setup, please refer below issues which might help you in order to resolve the same:

- [ISSUE - 3: File not found in iOS and No resourcefound in android](https://github.com/prscX/react-native-app-tour/issues/3)


## API's

* AppTourView.for: AppTourTarget

```
let appTourTarget = AppTourView.for(Button, {...native-library-props})

AppTour.ShowFor(appTourTarget)
```

> **Note:**
> - App Tour Target Properties are same as defined by [KeepSafe/TapTargetView](https://github.com/KeepSafe/TapTargetView) & [aromajoin/material-showcase-ios](https://github.com/aromajoin/material-showcase-ios)
> - Please use the same props for the same.

* AppTourSequence
  * add(AppTourTarget)
  * remove(AppTourTarget)
  * removeAll
  * get(AppTourTarget)
  * getAll

```
let appTourSequence = new AppTourSequence()
this.appTourTargets.forEach(appTourTarget => {
appTourSequence.add(appTourTarget)
})

AppTour.ShowSequence(appTourSequence)
```

* AppTour
  * ShowFor(AppTourTarget)
  * ShowSequence(AppTourTargets)

## Credits

- Android: [KeepSafe/TapTargetView](https://github.com/KeepSafe/TapTargetView)
- iOS: [aromajoin/material-showcase-ios](https://github.com/aromajoin/material-showcase-ios)


## Contribution
Contributions are welcome and are greatly appreciated! Every little bit helps, and credit will always be given.

## License
This library is provided under the MIT License.

RNAppTour @ Pranav Raj Singh Chauhan


## Other Contributions

| [awesome-react-native-native-modules](https://github.com/prscX/awesome-react-native-native-modules)                            |
| ------------------------------------------------------------------------------------------------------------------------------ |
| <img src="https://github.com/prscX/awesome-react-native-native-modules/raw/master/assets/hero.png" width="600" height="300" /> |

| [react-native-spruce](https://github.com/prscX/react-native-spruce)                                                         |
| --------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/willowtreeapps/spruce-ios/raw/master/imgs/extensibility-tests.gif" width="600" height="300" /> |

| [react-native-bottom-action-sheet](https://github.com/prscX/react-native-bottom-action-sheet)                              |
| -------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/rubensousa/BottomSheetBuilder/raw/master/screens/normal_demo.gif" width="600" height="600" /> |

| [react-native-popover-menu](https://github.com/prscX/react-native-popover-menu)                                          |
| ------------------------------------------------------------------------------------------------------------------------ |
| <img src="https://github.com/zawadz88/MaterialPopupMenu/raw/master/art/components_menus.png" width="600" height="300" /> |

| [react-native-tooltips](https://github.com/prscX/react-native-tooltips)                                                                                                         |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://camo.githubusercontent.com/add1764d27026b81adb117e07a10781c9abbde1b/687474703a2f2f692e696d6775722e636f6d2f4f4e383257526c2e676966" width="600" height="300" /> |

| [react-native-shine-button](https://github.com/prscX/react-native-shine-button)                                             |
| --------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://raw.githubusercontent.com/ChadCSong/ShineButton/master/demo_shine_others.gif" width="600" height="300" /> |

| [react-native-iconic](https://github.com/prscX/react-native-iconic)                                                                                                                                                                                                                                         |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://camo.githubusercontent.com/b18993cbfe91de8abdc0019dc9a6cd44707eec21/68747470733a2f2f6431337961637572716a676172612e636c6f756466726f6e742e6e65742f75736572732f3338313133332f73637265656e73686f74732f313639363538302f766266706f70666c6174627574746f6e332e676966" width="600" height="300" /> |

| [react-native-download-button](https://github.com/prscX/react-native-download-button)                                                |
| ------------------------------------------------------------------------------------------------------------------------------------ |
| <img src="https://github.com/fenjuly/ArrowDownloadButton/raw/master/screenshots/arrowdownloadbutton.gif" width="600" height="600" /> |

| [react-native-siri-wave-view](https://github.com/prscX/react-native-siri-wave-view)                       |
| --------------------------------------------------------------------------------------------------------- |
| <img src="https://cdn.dribbble.com/users/341264/screenshots/2203511/wave.gif" width="600" height="300" /> |

| [react-native-material-shadows](https://github.com/prscX/react-native-material-shadows)                                         |
| ------------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://raw.githubusercontent.com/harjot-oberai/MaterialShadows/master/screens/cover.png" width="600" height="300" /> |

| [react-native-gradient-blur-view](https://github.com/prscX/react-native-gradient-blur-view)                                |
| -------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/prscX/react-native-gradient-blur-view/raw/master/assets/hero.png" width="600" height="300" /> |

| [react-native-about-libraries](https://github.com/prscX/react-native-about-libraries)                            |
| ---------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/prscX/react-native-about-libraries/raw/master/hero.png" width="600" height="600" /> |

| [vs-essential-plugins](https://github.com/prscX/vs-essential-plugins)                                               |
| ------------------------------------------------------------------------------------------------------------------- |
| <img src="https://pbs.twimg.com/profile_images/922911523328081920/jEKFRPKV_400x400.jpg" width="600" height="300" /> |

| [prettier-pack](https://github.com/prscX/prettier-pack)                                                                                 |
| --------------------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://raw.githubusercontent.com/prettier/prettier-logo/master/images/prettier-banner-light.png" width="600" height="300" /> |
