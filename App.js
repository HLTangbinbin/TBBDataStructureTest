/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Fragment,Component} from 'react';
import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
  TouchableOpacity,
  NativeEventEmitter,
  NativeModules,
  DeviceEventEmitter,
  Platform,
} from 'react-native';

import {
  Header,
  LearnMoreLinks,
  Colors,
  DebugInstructions,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

class App extends Component {

    constructor(props){
        super();
        this.state = {
            a:"11",
            singlePerson: 'index/index/singlePerson',
            manyPerson: 'index/index/manyPerson',
            emptyArray: 'index/index/emptyArray',
            emptyString: 'index/index/emptyString',
            nullData: 'index/index/nullData',
            data: '{"code":200,"msg":"success","time":1566272544,"data":[{"age":20,"name":"张大千","rich":12.2,"sex":true},{"age":20,"name":"张大千","rich":12.2,"sex":false},{"age":20,"name":"张大千","rich":12.2,"sex":true},{"age":20,"name":"张大千","rich":12.2,"sex":false},{"age":20,"name":"张大千","rich":12.2,"sex":true}]}'

        };
        this.fetchBookinfoList = this.fetchBookinfoList.bind(this)
    }

    componentDidMount(){
        // this.fetchBookinfoList();
        // alert("result")

        // setTimeout(()=>{

            this.listener = new NativeEventEmitter(NativeModules.XpjxModule).addListener("getSessionIdEvent", (result) => {
                if (Platform.OS === 'android') {
                    alert(result.name +'---' + result.man +'---' + result.age +'---' + result.money +'---' + result.height +'---' + result.city);
                    console.log(typeof(result.name))
                    console.log(typeof(result.man))
                    console.log(typeof(result.age))
                    console.log(typeof(result.money))
                    console.log(typeof(result.height))
                    console.log(result.city instanceof Array)
                }else{
                    alert(result.sessionId +'---' + result.type +'---'+ result.page +'---' + result.money);
                    console.log(typeof(result.sessionId))
                    console.log(typeof(result.type))
                    console.log(typeof(result.page))
                    console.log(typeof(result.money))
                }
            })
        // },10000);

    }

    componentWillUnmount() {
        this.listener && this.listener.remove();
    }

    toggleModal() {
        NativeModules.XpjxModule.handleMessage({
            type: 'showLogin',
            age: 20,
            man: false,
            city: ['北京','上海','深圳'],
            hobby: {
                hobby1: 'reading',
                hobby2: 'reading',
                hobby3: 'reading',
                hobby4: 'reading'
            },
            data: null
        }).then(() => {
            // this.showToast("清除缓存成功");
        })
    }
    fetchBookinfoList() {
        // alert('yyy')
        fetch("http://192.168.1.103:9999/index/index/manyperson",{
          method: 'GET',
          headers: {'Content-Type': "application/json"},
          // body: {}
        }).then((response) => response.text())
          .then((responseData) => {
              // alert(responseData)
              let res = this.state.data;
              responseData = JSON.parse(responseData);
              res = JSON.parse(res);
              console.log(res.data[0].name);
              console.log(responseData.data);
              alert(res.data[0].name);
              if(responseData.code == '200'){
                  // alert(responseData.data.computer.size_a == '15.6');
              }else{
                  // alert('error')
              }
              // alert(responseData.code);
              // alert(responseData.msg);
              // alert(responseData.time);
              // if(responseData.code == 200){
              //     alert(responseData.data)
              // }
          })
          .catch((err) => {
              alert('err')
          });

    }

    render(){
  return (
    <Fragment>
      <StatusBar barStyle="dark-content" />
      <SafeAreaView>
        <ScrollView
          contentInsetAdjustmentBehavior="automatic"
          style={styles.scrollView}>
          <Header />
          {global.HermesInternal == null ? null : (
            <View style={styles.engine}>
              <Text style={styles.footer}>Engine: Hermes</Text>
            </View>
          )}
          <View style={styles.body}>
            <TouchableOpacity onPress={()=>this.toggleModal()}>
              <Text>服务</Text>
            </TouchableOpacity>
            <View style={styles.sectionContainer}>
              <Text>{this.state.a}</Text>
              <Text style={styles.sectionTitle}>Step One</Text>
              <Text style={styles.sectionDescription}>
                Edit <Text style={styles.highlight}>App.js</Text> to change this
                screen and then come back to see your edits.
              </Text>
            </View>
            <View style={styles.sectionContainer}>
              <Text style={styles.sectionTitle}>See Your Changes</Text>
              <Text style={styles.sectionDescription}>
                <ReloadInstructions />
              </Text>
            </View>
            <View style={styles.sectionContainer}>
              <Text style={styles.sectionTitle}>Debug</Text>
              <Text style={styles.sectionDescription}>
                <DebugInstructions />
              </Text>
            </View>
            <View style={styles.sectionContainer}>
              <Text style={styles.sectionTitle}>Learn More</Text>
              <Text style={styles.sectionDescription}>
                Read the docs to discover what to do next:
              </Text>
            </View>
            <LearnMoreLinks />
          </View>
        </ScrollView>
      </SafeAreaView>
    </Fragment>
  );
    }
};



const styles = StyleSheet.create({
  scrollView: {
    backgroundColor: Colors.lighter,
  },
  engine: {
    position: 'absolute',
    right: 0,
  },
  body: {
    backgroundColor: Colors.white,
  },
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
    color: Colors.black,
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
    color: Colors.dark,
  },
  highlight: {
    fontWeight: '700',
  },
  footer: {
    color: Colors.dark,
    fontSize: 12,
    fontWeight: '600',
    padding: 4,
    paddingRight: 12,
    textAlign: 'right',
  },
});

export default App;
