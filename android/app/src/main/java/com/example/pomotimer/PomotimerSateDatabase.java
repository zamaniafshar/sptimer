package com.example.pomotimer;

import android.content.Context;
import android.content.SharedPreferences;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.ToNumberPolicy;
import com.google.gson.reflect.TypeToken;
import java.util.HashMap;
import java.util.Map;
public class PomotimerSateDatabase {
    public PomotimerSateDatabase(Context context) {
        this.sharedPreferences = context.getSharedPreferences("SateSharedPref", Context.MODE_PRIVATE);
    }

    private final SharedPreferences sharedPreferences;


    public void saveState(Map<String, Object> map) {
        Gson gson = new Gson();
        String hashMapString = gson.toJson(map);
        sharedPreferences.edit()
                .putString("stateString", hashMapString)
                .commit();
    }

    public Map<String, Object> getState() {
        Gson gson = new GsonBuilder()
                .setObjectToNumberStrategy(ToNumberPolicy.LONG_OR_DOUBLE)
                .create();
        String storedHashMapString = sharedPreferences.getString("stateString", null);
        sharedPreferences.edit().putString("stateString", null).commit();
        java.lang.reflect.Type type = new TypeToken<HashMap<String, Object>>() {
        }.getType();
        return gson.fromJson(storedHashMapString, type);
    }

}
