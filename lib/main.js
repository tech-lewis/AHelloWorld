import React, { Component } from 'react';
import { View, TextInput, Button, Text, StyleSheet } from 'react-native';

class HexConverter extends Component {
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

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.title}>{this.state.binaryTitle}</Text>
        <TextInput style={styles.input} onChangeText={this.convertBinaryToOther} />
        <Text style={styles.title}>{this.state.octalTitle}</Text>
        <Text style={styles.output}>{this.state.octal}</Text>
        <Text style={styles.title}>{this.state.decimalTitle}</Text>
        <Text style={styles.output}>{this.state.decimal}</Text>
        <Text style={styles.title}>{this.state.hexTitle}</Text>
        <Text style={styles.output}>{this.state.hex}</Text>
        <Button
          title="Toggle Title"
          onPress={() =>
            this.setState({ showTitle: !this.state.showTitle })
          }
        />
      </View>
    );
  }
}

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
    marginBottom: 10,
  },
  output: {
    marginBottom: 10,
  },
});

export default HexConverter;
