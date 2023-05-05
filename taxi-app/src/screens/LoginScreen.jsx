import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet } from 'react-native';


const LoginScreen = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  const handleUsernameChange = (username) => {
    setUsername(username);
  };

  const handlePasswordChange = (password) => {
    setPassword(password);
  };

  const handleLogin = () => {
    console.log('Username:', username);
    console.log('Password:', password);
  };

  return(
    <View>

    </View>
  )
}

const syles = StyleSheet.create({
  Container:{
    padding: 20,
    bottom:10,
  }
})

export default LoginScreen;

