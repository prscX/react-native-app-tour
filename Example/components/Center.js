import React, { Component } from 'react';
import { StyleSheet, View, Button, Platform } from 'react-native';

import { AppTourView } from 'react-native-app-tour';

class Center extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Button
          title={'Center Left'}
          ref={ref => {
            let props;
            if (Platform.OS === "ios") {
              props = {
                primaryText: "This is a target button 3",
                secondaryText:
                  "We have the best targets, believe me"
              }
            } else if (Platform.OS === "android") {
              props = {
                title: "This is a target button 3",
                description:
                  "We have the best targets, believe me",
                outerCircleColor: "#3f52ae"
              }
            }

            this.props.addAppTourTarget && this.props.addAppTourTarget(AppTourView.for(
                  ref,
                  { ...props }
                ));
          }}
          onPress={() => {}}
        />
        <Button
          title={'Center Center'}
          ref={ref => {
            let props;
            if (Platform.OS === "ios") {
              props = {
                primaryText: "This is a target button 4",
                secondaryText:
                  "We have the best targets, believe me"
              }
            } else if (Platform.OS === "android") {
              props = {
                title: "This is a target button 4",
                description:
                  "We have the best targets, believe me",
                outerCircleColor: "#f24481"
              }
            }

            this.props.addAppTourTarget && this.props.addAppTourTarget(AppTourView.for(
                  ref,
                  { ...props }
                ));
          }}
          onPress={() => {}}
        />
        <Button
          title={'Center Right'}
          ref={ref => {
            let props;
            if (Platform.OS === "ios") {
              props = {
                primaryText: "This is a target button 5",
                secondaryText:
                  "We have the best targets, believe me\nsecondaryTextAlignment",
                secondaryTextAlignment: "right"
              }
            } else if (Platform.OS === "android") {
              props = {
                title: "This is a target button 5",
                description:
                  "We have the best targets, believe me",
                outerCircleColor: "#3f52ae"
              }
            }

            this.props.addAppTourTarget && this.props.addAppTourTarget(AppTourView.for(
                  ref,
                  { ...props }
                ));
          }}
          onPress={() => {}}
        />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
});

export default Center;
