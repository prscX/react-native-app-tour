import React, { Component } from "react";
import { StyleSheet, View, Button, Platform } from "react-native";

import { AppTour, AppTourView } from "react-native-app-tour";

class Top extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Button
          title={"Top Left"}
          ref={ref => {
            this.button1 = ref;

            let props = {
              title: "This is a target button 1",
              description: "We have the best targets, believe me",
              outerCircleColor: "#3f52ae",
              cancelable: false,
              isRect: true,
              rectHighLightColor: "#FFFFFF",
              rectTargetBorderRadius: 4,
              transparentTarget: true,
              isSkipButtonVisible: true,
              skipText: 'SKIP',
              skipButtonBackgroundColor: '#0000FF',
              skipTextColor: '#FFFFFF',
              dimColor: '#000000',
              skipButtonMarginHorizontal: 40
            };
            ref &&
              this.props.addAppTourTarget &&
              this.props.addAppTourTarget(AppTourView.for(ref, { ...props }));
          }}
          onPress={() => {
            let props = {
              title: "This is a target button 1",
              description: "We have the best targets, believe me",
              outerCircleColor: "#f24481",
              isRect: true,
              // rectHighLightColor, isSkipButtonVisible not support with showFor
              // Only support ShowSequence
              // isSkipButtonVisible: true,
              // rectHighLightColor: "#FF0000",
            };

            let targetView = AppTourView.for(this.button1, {
              ...props,
            });

            AppTour.ShowFor(targetView);
          }}
        />
        <Button
          title={"Top Right"}
          ref={ref => {
            this.button2 = ref;

            let props = {
              title: "This is a target button 2",
              description: "We have the best targets, believe me",
              backgroundPromptColor: "#3f52ae",
              outerCircleColor: "#f24481",
              targetRadius: 100,
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

export default Top;
