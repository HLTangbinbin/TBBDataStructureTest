import React, {Component} from 'react';
import {View, Text,Button} from "react-native"


export default class DetailPage extends Component {
    render() {
        return (
            <View style={{flex:1,alignItems:"center",justifyContent:"center"}}>
                <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
                    <Text>Details Screen</Text>
                    <Button
                        title="Go to Details... again"
                        onPress={() => this.props.navigation.push('Details')}
                    />
                    <Button
                        title="Go to Home"
                        onPress={() => this.props.navigation.navigate('Home')}
                    />
                    <Button
                        title="Go back"
                        onPress={() => this.props.navigation.goBack()}
                    />
                </View>
            </View>
        )
    }
}