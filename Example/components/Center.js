import React, { Component } from "react";
import { StyleSheet, View, Button, Platform } from "react-native";

import { AppTourView } from "react-native-app-tour";

class Center extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Button
          title={"Center Left"}
          ref={ref => {
            let props = {
              title: "This is a target button 3",
              description: "We have the best targets, believe me",
              outerCircleColor: "#3f52ae",
            };

            this.props.addAppTourTarget &&
              this.props.addAppTourTarget(AppTourView.for(ref, { ...props }));
          }}
          onPress={() => {}}
        />
        <Button
          title={"Center Center"}
          ref={ref => {
            let props = {
              title: "This is a target button 4",
              description: "We have the best targets, believe me",
              outerCircleColor: "#f24481",
            };

            this.props.addAppTourTarget &&
              this.props.addAppTourTarget(AppTourView.for(ref, { ...props }));
          }}
          onPress={() => {}}
        />
        <Button
          title={"Center Right"}
          ref={ref => {
            let props = {
              title: "This is a target button 5",
              description: "We have the best targets, believe me",
              outerCircleColor: "#3f52ae",
              isSkipButtonVisible: true,
              skipButtonBackgroundColor: '#F64C4C',
              skipText: "SKIP TOUR",
              skipTextSize: 24,
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

export default Center;
