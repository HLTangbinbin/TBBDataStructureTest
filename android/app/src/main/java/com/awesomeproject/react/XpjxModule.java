package com.awesomeproject.react;

import android.content.Intent;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeArray;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.util.HashMap;


/**
 * Created by Administrator on 2018/4/15.
 */

public class XpjxModule extends ReactContextBaseJavaModule {
    private static final String TAG = "XpjxModule";
    ReactApplicationContext mContext;
    static ReactApplicationContext context;
    static boolean loginFromShop = false;

    public XpjxModule(ReactApplicationContext reactContext) {
        super(reactContext);
        mContext = reactContext;
        context = reactContext;
    }

    @Override
    public String getName() {
        return "XpjxModule";
    }

    public static void sendEventToRn(String eventName, WritableMap paramss) {
        context.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit(eventName, paramss);
    }

    public static void sendEventToRnNoCheck(String eventName, WritableMap paramss) {
        context
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, paramss);
    }

    public static void loginFailed() {
        loginFromShop = false;
    }


    @ReactMethod
    public void handleMessage(ReadableMap data, Promise promise) {
        Log.d(TAG, "handleMessage ");
        try {
            Intent intent;
            if (data.hasKey("type")) {
                String type = data.getString("type");
                Log.d(TAG, "handleMessage " + type);
                switch (type) {
                    case "change_status_color":
                        String color = data.getString("color");
                        break;
                    case "showLogin":
                        ReadableArray acceptArray =  data.getArray("city");
                        ReadableMap acceptMap = data.getMap("hobby");
                        HashMap mMap = acceptMap.toHashMap();
                        Log.d(TAG,"----------------已收到消息 ：" + data.getInt("age")
                        + "," + data.getBoolean("man"));

                        for (int i = 0; i < acceptArray.size(); i++) {
                            Log.d(TAG, acceptArray.getString(i));
                        }
                        for (int j = 1; j <= acceptArray.size(); j++) {
                            Log.d(TAG, mMap.get("hobby"+j).toString());
                        }
                        Log.d(TAG,"----------------消息接收完毕");

                        String name = "张三";
                        boolean man = true;
                        int age = 20;
                        double money = 100.00;
                        float height = 175.1f;

                        WritableArray array = new WritableNativeArray();
                        array.pushString("北京");
                        array.pushString("上海");
                        array.pushString("广州");
                        array.pushString("深圳");

                        WritableMap params = Arguments.createMap();
                        params.putString("name",name);
                        params.putBoolean("man", man);
                        params.putInt("age", age);
                        params.putDouble("money", money);
                        params.putDouble("height", height);
                        params.putArray("city",array);
                        params.putString("cityName",null);

                        XpjxModule.sendEventToRn("getSessionIdEvent", params);
                        Log.d(TAG,"已发送消息");
                        break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
