import React, { Component } from "react";
import { StyleSheet, View, Button, Platform } from "react-native";

import { AppTourView } from "react-native-app-tour";

class Bottom extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Button
          title={"Bottom Left"}
          ref={ref => {
            let props = {
              title: "This is a target button 6",
              description: "We have the best targets, believe me",
              outerCircleColor: "#3f52ae",
              transparentTarget: true,
              isSkipButtonVisible: true,
              skipText: 'SKIP',
              skipButtonBackgroundColor: '#0000FF',
              skipTextColor: '#FFFFFF',
              dimColor: '#000000',
            };

            this.props.addAppTourTarget &&
              this.props.addAppTourTarget(AppTourView.for(ref, { ...props }));
          }}
          onPress={() => {}}
        />
        <Button
          title={"Bottom Right"}
          ref={ref => {
            let props = {
              title: "This is a target button 7",
              description: "We have the best targets, believe me",
              outerCircleColor: "#f24481",
              transparentTarget: true,
              isSkipButtonVisible: true,
              skipText: 'SKIP',
              skipButtonBackgroundColor: '#0000FF',
              skipTextColor: '#FFFFFF',
              dimColor: '#000000',
            };

            this.props.addAppTourTarget &&
              this.props.addAppTourTarget(AppTourView.for(ref, { ...props }));
          }}
          onPress={() => {}}
        />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    justifyContent: "space-between",
  },
});

export default Bottom;
