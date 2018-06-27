import React, { Component } from 'react'
import { StyleSheet, View, Button, Platform } from 'react-native'

import { AppTourView } from 'react-native-app-tour'

class Bottom extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Button
          key={'Bottom Left'}
          title={'Bottom Left'}
          ref={ref => {
            if (!ref) return

            let props = {
              order: 32,
              title: 'This is a target button 6',
              description: 'We have the best targets, believe me',
              outerCircleColor: '#3f52ae'
            }

            this.props.addAppTourTarget &&
              this.props.addAppTourTarget(AppTourView.for(ref, { ...props }))
          }}
          onPress={() => {}}
        />
        <Button
          key={'Bottom Right'}
          title={'Bottom Right'}
          ref={ref => {
            if (!ref) return

            let props = {
              order: 31,
              title: 'This is a target button 7',
              description: 'We have the best targets, believe me',
              outerCircleColor: '#f24481'
            }

            this.props.addAppTourTarget &&
              this.props.addAppTourTarget(AppTourView.for(ref, { ...props }))
          }}
          onPress={() => {}}
        />
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    justifyContent: 'space-between'
  }
})

export default Bottom
