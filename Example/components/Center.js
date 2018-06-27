import React, { Component } from 'react'
import { StyleSheet, View, Button, Platform } from 'react-native'

import { AppTourView } from 'react-native-app-tour'

class Center extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Button
          key={'Center Left'}
          title={'Center Left'}
          ref={ref => {
            if (!ref) return

            let props = {
              order: 23,
              title: 'This is a target button 3',
              description: 'We have the best targets, believe me',
              outerCircleColor: '#3f52ae'
            }

            this.props.addAppTourTarget &&
              this.props.addAppTourTarget(AppTourView.for(ref, { ...props }))
          }}
          onPress={() => {}}
        />
        <Button
          key={'Center Center'}
          title={'Center Center'}
          ref={ref => {
            if (!ref) return

            let props = {
              order: 21,
              title: 'This is a target button 4',
              description: 'We have the best targets, believe me',
              outerCircleColor: '#f24481'
            }

            this.props.addAppTourTarget &&
              this.props.addAppTourTarget(AppTourView.for(ref, { ...props }))
          }}
          onPress={() => {}}
        />
        <Button
          key={'Center Right'}
          title={'Center Right'}
          ref={ref => {
            if (!ref) return

            let props = {
              order: 22,
              title: 'This is a target button 5',
              description: 'We have the best targets, believe me',
              outerCircleColor: '#3f52ae'
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

export default Center
