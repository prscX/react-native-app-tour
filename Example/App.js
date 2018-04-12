/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  Button,
  DeviceEventEmitter,
} from 'react-native';

import { AppTour, AppTourSequence, AppTourView } from 'react-native-app-tour';

import Top from './components/Top';
import Center from './components/Center';
import Bottom from './components/Bottom';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

export default class App extends Component<{}> {
  constructor(props) {
    super(props);

    this.appTourTargets = [];
  }

  componentWillMount() {
    this.unregisterAppTourEvent();
    this.registerFinishAppTour();
  }

  componentDidMount() {
    setTimeout(() => {
      let appTourSequence = new AppTourSequence();
      this.appTourTargets.forEach(appTourTarget => {
        appTourSequence.add(appTourTarget);
      });
      AppTour.ShowSequence(appTourSequence);
    }, 1000);
  }

  componentWillUnmount() {
    this.unregisterAppTourEvent();
  }

  registerFinishAppTour = () => {
    this.unregisterAppTourEvent();
    this.finishAppTour = DeviceEventEmitter.addListener('onFinishSequenceEvent', (e: Event) => {
      console.log(e);
    });
    this.cancelAppTour = DeviceEventEmitter.addListener('onCancelStepEvent', (e: Event) => {
      console.log(e);
    });
    this.stepAppTour = DeviceEventEmitter.addListener(
      'onShowSequenceStepEvent',
      (e: Event) => {
        console.log(e);
      }
    );
  };

  unregisterAppTourEvent = () => {
    if (this.finishAppTour) {
      this.finishAppTour.remove();
    }
    if (this.cancelAppTour) {
      this.cancelAppTour.remove();
    }
    if (this.stepAppTour) {
      this.stepAppTour.remove();
    }
};


  render() {
    return (
      <View style={styles.container}>
        <Top
          style={styles.top}
          addAppTourTarget={appTourTarget => {
            this.appTourTargets.push(appTourTarget);
          }}
        />
        <Center
          style={styles.center}
          addAppTourTarget={appTourTarget => {
            this.appTourTargets.push(appTourTarget);
          }}
        />
        <Bottom
          style={styles.bottom}
          addAppTourTarget={appTourTarget => {
            this.appTourTargets.push(appTourTarget);
          }}
        />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'space-between',
  },
  top: {
    flex: 1,
  },
  center: {
    flex: 1,
  },
  bottom: {
    flex: 1,
  },
});
