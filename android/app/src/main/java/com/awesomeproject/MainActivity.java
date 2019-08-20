package com.awesomeproject;

import android.app.Activity;
import android.os.Bundle;
import android.text.TextUtils;

import com.facebook.react.ReactActivity;
import com.facebook.react.ReactActivityDelegate;

import javax.annotation.Nullable;

public class MainActivity extends ReactActivity {

    /**
     * Returns the name of the main component registered from JavaScript.
     * This is used to schedule rendering of the component.
     */
    @Override
    protected String getMainComponentName() {
        return "AwesomeProject";
    }

    @Override
    protected ReactActivityDelegate createReactActivityDelegate() {
        return super.createReactActivityDelegate();
    }


    class GJReactActivityDelegate extends ReactActivityDelegate {

        public GJReactActivityDelegate(Activity activity, @Nullable String mainComponentName) {
            super(activity, mainComponentName);
        }

        @Nullable
        @Override
        protected Bundle getLaunchOptions() {

            String name = "张三";
            boolean man = true;
            int age = 20;
            double money = 100.00;
            float height = 175.1f;

            Bundle bundle = new Bundle();
            bundle.putString("name", name);
            bundle.putString("age", age + "");
            bundle.putString("money", money + "");
            bundle.putString("height", height + "");
            bundle.putString("man", man + "");
            return bundle;
        }
    }
}
