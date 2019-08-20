package com.awesomeproject;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.awesomeproject.bean.SinglePerson;
import com.awesomeproject.react.XpjxModule;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.WritableMap;
import com.google.gson.Gson;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.List;

import androidx.appcompat.app.AppCompatActivity;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class NetworkActivity extends AppCompatActivity {

    private static String TAG = "NetworkActivity";
    private static String url_jh = "http://v.juhe.cn/toutiao/index";
    private static String key_jh = "5cdce9169ca8c04157f2f97e0b879c77";

    private static String singlePerson = "http://192.168.1.103:9999/index/index/singlePerson";
    private static String manyPerson = "http://192.168.1.103:9999/index/index/manyPerson";
    private static String emptyArray = "http://192.168.1.103:9999/index/index/emptyArray";
    private static String emptyString = "http://192.168.1.103:9999/index/index/emptyString";
    private static String nullData = "http://192.168.1.103:9999/index/index/nullData";
    private static String emptyData = "http://192.168.1.103:9999/index/index/emptyData";


    TextView tv;
    Button button;
    Button button2;
    Button button3;
    Button button4;
    Button button5;
    Button button6;
    Button button7;
    Button button8;
    Button button9;
    Button button10;
    SinglePerson singlePersonBean;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_network);

        tv = findViewById(R.id.text);
        button = findViewById(R.id.button);
        button2 = findViewById(R.id.button2);
        button3 = findViewById(R.id.button3);
        button4 = findViewById(R.id.button4);
        button5 = findViewById(R.id.button5);
        button6 = findViewById(R.id.button6);
        button7 = findViewById(R.id.button7);
        button8 = findViewById(R.id.button8);
        button9 = findViewById(R.id.button9);
        button10 = findViewById(R.id.button10);

        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                requestNetwork (singlePerson, 1);
            }
        });
        button2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                requestNetwork (manyPerson, 2);
            }
        });
        button3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                requestNetwork (emptyArray, 3);
            }
        });
        button4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                requestNetwork (emptyString, 4);
            }
        });
        button5.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                requestNetwork (nullData, 5);
            }
        });

        button9.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String name = "张三";
                boolean man = true;
                int age = 20;
                double money = 100.00;
                float height = 175.1f;

                WritableMap params = Arguments.createMap();
                params.putString("name",name);
                params.putString("man", man+"");
                params.putString("age", age+"");
                params.putString("money", money+"");
                params.putString("height", height+"");
                XpjxModule.sendEventToRn("getSessionIdEvent", params);

               startActivity(new Intent(NetworkActivity.this, MainActivity.class));
            }
        });

        /*-------------------------------------------------------*/

        button6.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                requestNetwork (emptyData, 6);
            }
        });
        button10.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                tv.setText("");
            }
        });
    }

    public void requestNetwork (String url, int num) {
        Log.d(TAG,"---------------------------------------网络请求------------------------------------------");
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    OkHttpClient client = new OkHttpClient();

                   /* RequestBody requestBody = new FormBody.Builder()
                            .add("type","")
                            .add("key","5cdce9169ca8c04157f2f97e0b879c77")
                            .build();*/

                    Request request = new Request.Builder()
                            .url(url)
                            //.post(requestBody)
                            .build();

                    Response response = client.newCall(request).execute();
                    if (response.body()!=null){
                        String responseData = response.body().string();
                        try {
                            JSONObject jsonObject = new JSONObject(responseData);
                            Log.d(TAG,jsonObject.toString());

                            switch (num) {
                                case 1:
                                    singlePersonBean = new JsonHelp<>(SinglePerson.class).getItem(jsonObject.getString("data"));
                                    Log.d(TAG,singlePersonBean.getName()+"," + singlePersonBean.getAge() +"," + singlePersonBean.getRich() +"," + singlePersonBean.isSex()
                                            +"," + singlePersonBean.getComputer().getType() +"," +singlePersonBean.getPhone().get(1).getType());
                                    break;
                                case 2:
                                    List<SinglePerson> singlePeople = new JsonHelp<>(SinglePerson.class).getItemList(jsonObject.getString("data"));
                                    Log.d(TAG,singlePeople.size()+","+singlePeople.get(0).getName());
                                    break;
                                case 3:
                                    /*List<SinglePerson> list = new JsonHelp<>(SinglePerson.class).getItemList(jsonObject.getString("data"));
                                    Log.d(TAG,list.size()+"");*/
                                    singlePersonBean = new JsonHelp<>(SinglePerson.class).getItem(jsonObject.getString("data"));
                                    Log.d(TAG,singlePersonBean==null ? "null" : "非null");
                                    break;
                                case 4:
                                    singlePersonBean = new JsonHelp<>(SinglePerson.class).getItem(jsonObject.getString("data"));
                                    Log.d(TAG,singlePersonBean==null ? "null" : "非null");
                                    //Log.d(TAG,singlePersonBean.getName());
                                    break;
                                case 5:
                                    singlePersonBean = new JsonHelp<>(SinglePerson.class).getItem(jsonObject.getString("data"));
                                    Log.d(TAG,singlePersonBean==null ? "null" : "非null");
                                    //Log.d(TAG,singlePersonBean.getName());
                                    break;
                                case 6:
                                    singlePersonBean = new JsonHelp<>(SinglePerson.class).getItem(jsonObject.getString("data"));
                                    Log.d(TAG,singlePersonBean==null ? "null" : "非null");
                                    //Log.d(TAG,singlePersonBean.getName());
                                    break;
                            }

                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                        showResponse(responseData);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }

    private void showResponse(final String response) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                tv.setText(response);
            }
        });
    }
}
