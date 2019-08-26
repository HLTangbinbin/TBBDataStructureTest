import React, {Fragment,Component} from 'react';
import { createStackNavigator, createAppContainer } from "react-navigation";
import HomeScreen from "./HomeScreen";

const AppNavigator = createStackNavigator({
  HomeScreen: HomeScreen
});
const AppContainer = createAppContainer(AppNavigator);
export default class App extends Component {
  render() {
    return <AppContainer />;
  }
}