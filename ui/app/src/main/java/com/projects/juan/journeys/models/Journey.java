package com.projects.juan.journeys.models;


import org.json.JSONArray;
import org.json.JSONException;

import java.util.ArrayList;

/**
 * Created by juan on 13/02/18.
 */

public class Journey{
    private int id;
    private String code;
    private String start;
    private String end;
    private int capacity;
    private int price;
    private int duration;
    private String journey_stop;
    private String tags;
    private ArrayList<String> users;
    private User driver;

    public Journey(int id, String code, String start, String end, int capacity, int price, int duration, String journey_stop, String tags, JSONArray users, User driver) {
        this.id = id;
        this.code = code;
        this.start = start;
        this.end = end;
        this.capacity = capacity;
        this.price = price;
        this.journey_stop = journey_stop;
        this.duration = duration;
        this.tags = tags;
        this.users = new ArrayList<>();
        for(int i = 0; i < users.length(); i++) {
            try {
                this.users.add(users.getJSONObject(i).getString("first_name").toString() + " " + users.getJSONObject(i).getString("last_name").toString());
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        this.driver = driver;
    }

    public int getId() {
        return id;
    }

    public String getCode() {
        return code;
    }

    public String getStart() {
        return start;
    }

    public String getEnd() {
        return end;
    }

    public int getCapacity() {
        return capacity;
    }

    public int getPrice() {
        return price;
    }

    public int getDuration() {
        return duration;
    }

    public String getJourney_stop() {
        return journey_stop;
    }

    public String getTags() {
        return tags;
    }

    public ArrayList<String> getUsers() {
        return users;
    }

    public User getDriver() {
        return driver;
    }
}
