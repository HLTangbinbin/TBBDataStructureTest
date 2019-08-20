package com.awesomeproject.react;

import android.content.Intent;
import android.util.Log;
import android.view.KeyEvent;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;


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
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
