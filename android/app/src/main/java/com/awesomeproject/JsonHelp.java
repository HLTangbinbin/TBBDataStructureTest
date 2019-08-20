package com.awesomeproject;


import com.google.gson.Gson;

import org.json.JSONArray;

import java.util.ArrayList;
import java.util.List;

/**
 * json帮助类-gson
 **/
public class JsonHelp<T> {

    private final static String TAG = "JsonHelp";
    private final Gson gson;
    private final Class<T> clazz;

    public JsonHelp(Class<T> clazz) {
        gson = new Gson();
        this.clazz = clazz;
    }

    // json转对象
    public T getItem(String jsonStr) {
        if (jsonStr != null && !("").equals(jsonStr)) {
            try {
                T t = gson.fromJson(jsonStr, clazz);
                return t;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    // json转对象列表
    public List<T> getItemList(String jsonListStr) {
        List<T> list = new ArrayList<T>();
        if (jsonListStr != null && !("").equals(jsonListStr)) {
            try {
                JSONArray jarry = new JSONArray(jsonListStr);
                int size = jarry.length();
                if (size > 0) {
                    for (int i = 0; i < size; i++) {
                        String item = jarry.getString(i);
                        list.add(getItem(item));
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    // 对象转json
    public String item2Json(T t) {
        try {
            String jsonStr = gson.toJson(t);
            return jsonStr;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    // 对象列表转json
    public String list2Json(List<T> list) {
        try {
            String jsonStr = gson.toJson(list);
            return jsonStr;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

}