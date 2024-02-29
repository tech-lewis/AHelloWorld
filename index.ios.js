/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import { AppRegistry, View, TextInput, Button, Text, StyleSheet } from 'react-native';
import Main from './lib/main'

class AHelloWorld extends Component {
  // 初始化方法 ---> viewDidLoad ---> 返回具体的组件内容
  constructor() {
    super();
    this.state = {
      binaryTitle: 'Binary:',
      octalTitle: 'Octal:',
      decimalTitle: 'Decimal:',
      hexTitle: 'Hex:',
      showTitle: false,
      binary: '',
      octal: '',
      decimal: '',
      hex: ''
    }
  }
  // Methods to convert the values
  convertBinaryToOther = (binary) => {
    const decimal = parseInt(binary, 2);
    const octal = decimal.toString(8);
    const hex = decimal.toString(16);
    this.setState({ decimal, octal, hex });
  }

  // 写结构和内容
  render() {
    return (
      <View style={styles.container}>
        <Main/>
        <Text style={styles.title}>{this.state.binaryTitle}</Text>
        <TextInput style={styles.input} onChangeText={binary => {
          if (/^[01]*$/.test(binary)) {
            this.setState({ binary })
            this.convertBinaryToOther(binary)
          }
        }} />
        <Text style={styles.title}>{this.state.octalTitle}</Text>
        <Text style={styles.output}>{this.state.octal}</Text>
        <Text style={styles.title}>{this.state.decimalTitle}</Text>
        <Text style={styles.output}>{this.state.decimal}</Text>
        <Text style={styles.title}>{this.state.hexTitle}</Text>
        <Text style={styles.output}>{this.state.hex}</Text>
        {/* 
        <Button
          title="Toggle Title"
          onPress={() =>
            this.setState({ showTitle: !this.state.showTitle })
          }
        /> */}
      </View>
    );
  }
}

const  newStyle = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'red',
  },
  welcome: {
    fontSize: 30,
    textAlign: 'center',
    margin: 20,
  }
});

const styles = StyleSheet.create({
  container: {
    padding: 20,
  },
  title: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  input: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    padding: 10,
  },
  output: {
    marginBottom: 10,
  },
});

AppRegistry.registerComponent('AHelloWorld', () => AHelloWorld);
