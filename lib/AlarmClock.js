import React, { Component } from 'react';
import { View, Button, ActionSheetIOS, StyleSheet, Text } from 'react-native';

class AlarmClock extends Component {
  constructor() {
    super();
    this.state = {
      alarmTime: '00:00',
    };
  }

  setAlarmTime = () => {
    const hours = Array.from({length: 24}, (_, i) => i.toString().padStart(2, '0'));
    const minutes = Array.from({length: 60}, (_, i) => i.toString().padStart(2, '0'));

    ActionSheetIOS.showActionSheetWithOptions(
      {
        options: ['Cancel', ...hours],
        cancelButtonIndex: 0,
      },
      (buttonIndex) => {
        if (buttonIndex !== 0) {
          this.setState({
            alarmTime: `${hours[buttonIndex-1]}:${this.state.alarmTime.split(':')[1]}`
          }, () => {
            ActionSheetIOS.showActionSheetWithOptions(
              {
                options: ['Cancel', ...minutes],
                cancelButtonIndex: 0,
              },
              (buttonIndex) => {
                if (buttonIndex !== 0) {
                  this.setState({
                    alarmTime: `${this.state.alarmTime.split(':')[0]}:${minutes[buttonIndex-1]}`
                  });
                }
              }
            );
          });
        }
      },
    );
  };

  render() {
    return (
      <View style={styles.container}>
        <Button title="Set Alarm Time" onPress={this.setAlarmTime} />
        <Text style={styles.text}>Alarm Time: {this.state.alarmTime}</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  text: {
    marginTop: 20,
    fontSize: 20,
  },
});

export default AlarmClock;
