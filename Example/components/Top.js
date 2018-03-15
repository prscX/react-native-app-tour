import React, { Component } from 'react';
import { StyleSheet, View, Button, Platform } from 'react-native';

import { AppTour, AppTourView } from 'react-native-app-tour';

class Top extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Button
          title={'Top Left'}
          ref={ref => {
            this.button1 = ref;

            let props;
            if (Platform.OS === "ios") {
              props = {
                primaryText: "This is a target button 1",
                secondaryText:
                  "We have the best targets, believe me",
                targetTintColor: "#3f52ae"
              }
            } else if (Platform.OS === "android") {
              props = {
                title: "This is a target button 1",
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
          onPress={() => {
            let props;
            if (Platform.OS === "ios") {
              props = {
                primaryText: "This is a target button 1",
                secondaryText:
                  "We have the best targets, believe me",
                backgroundPromptColor: "#3f52ae"
              }
            } else if (Platform.OS === "android") {
              props = {
                title: "This is a target button 1",
                description: "We have the best targets, believe me",
                outerCircleColor: "#f24481"
              }
            }

            let targetView = AppTourView.for(this.button1, {
              ...props
            });

            AppTour.ShowFor(targetView);
          }}
        />
        <Button
          title={'Top Right'}
          ref={ref => {
            this.button2 = ref;

            let props;
            if (Platform.OS === "ios") {
              props = {
                primaryText: "This is a target button 2",
                secondaryText:
                  "We have the best targets, believe me",
                backgroundPromptColor: "#3f52ae",
                targetHolderRadius: 100
              }
            } else if (Platform.OS === "android") {
              props = {
                title: "This is a target button 2",
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
          onPress={() => {
            
          }}
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

export default Top;
