package com.projects.juan.journeys.models;

/**
 * Created by juan on 13/02/18.
 */

public class Journey {
    private int id;
    private String code;
    private String start;
    private String end;
    private int capacity;
    private int price;
    private int duration;
    private String journey_stop;
    private String tags;

    public Journey(int id, String start, String end, int capacity, int price, int duration, String journey_stop, String tags) {
        this.id = id;
        this.start = start;
        this.end = end;
        this.capacity = capacity;
        this.price = price;
        this.journey_stop = journey_stop;
        this.duration = duration;
        this.tags = tags;
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
}
