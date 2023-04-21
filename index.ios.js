/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,  // 注册
  StyleSheet,   // 样式
  Text,  // 文本组件
  View,   // 视图组件
  Image,
  TextInput,
} from 'react-native';


class AHelloWorld extends Component {
  // 初始化方法 ---> viewDidLoad ---> 返回具体的组件内容
  // 写结构和内容
  render() {
    // 返回
    return (
        <View style={styles.container}>
          <Text style={styles.welcome}>
          你好,世界!
          </Text>
        </View>
    );
  }
}

const  newStyle = StyleSheet.create({

});

const styles = StyleSheet.create({
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

AppRegistry.registerComponent('AHelloWorld', () => AHelloWorld);
