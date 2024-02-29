import React, { Component } from 'react';
import {View, Text, StyleSheet} from 'react-native';
import Svg,{
  Circle,
  Ellipse,
  G,
  LinearGradient,
  RadialGradient,
  Line,
  Path,
  Polygon,
  Polyline,
  Rect,
  Symbol,
  Text as RNString,
  Use,
  Defs,
  Stop
} from 'react-native-svg';

class Main extends Component {
  constructor() {
    super();
    this.state = {
      time: new Date()
    };
  }

  componentDidMount() {
    this.timerID = setInterval(() => this.tick(), 1000);
  }

  componentWillUnmount() {
    clearInterval(this.timerID);
  }

  tick() {
    this.setState({
      time: new Date()
    });
  }

  render() {
    const handRotation = this.state.time.getSeconds() / 60 * 720;

    return (
      <View style={styles.container}>
        <Text>Current second pointer</Text>
        <Svg height="202" width="202">
          <Circle
              cx="101"
              cy="101"
              r="100"
              stroke="gray"
              strokeWidth="1"
              fill="orange"
          />
          <Line
            x1="101"
            y1="0"
            x2="101"
            y2="101"
            stroke="red"
            strokeWidth="2"
            rotate = {handRotation}
            origin="101, 101"
          />
          <RNString
            fill="none"
            stroke="purple"
            fontSize="15"
            fontWeight="bold"
            x="101"
            y="0"
            textAnchor="middle"
          >60 or 0s</RNString>
          <RNString
            fill="none"
            stroke="purple"
            fontSize="20"
            fontWeight="bold"
            x="170"
            y="85"
            textAnchor="middle"
          >15s</RNString>
          <RNString
            fill="none"
            stroke="purple"
            fontSize="20"
            fontWeight="bold"
            x="101"
            y="170"
            textAnchor="middle"
          >30s</RNString>
          <RNString
            fill="none"
            stroke="purple"
            fontSize="20"
            fontWeight="bold"
            x="25"
            y="85"
            textAnchor="middle"
          >45s</RNString>
        </Svg>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
});

export default Main;
