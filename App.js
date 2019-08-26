import React, {Component} from 'react';
import { createStackNavigator, createAppContainer } from "react-navigation";
import HomeScreen from "./HomeScreen";
import DetailPage from "./DetailPage";

const AppNavigator = createStackNavigator({
      Home: HomeScreen,
      Details: DetailPage
    },
    {
      initialRouteName: "Home"
    }
)
const AppContainer = createAppContainer(AppNavigator);
export default class App extends Component {
  render() {
    return <AppContainer />;
  }
}