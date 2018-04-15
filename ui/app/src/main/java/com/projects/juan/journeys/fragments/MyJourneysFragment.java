package com.projects.juan.journeys.fragments;


import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.widget.DefaultItemAnimator;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.projects.juan.journeys.R;
import com.projects.juan.journeys.adapters.JourneysAdapter;
import com.projects.juan.journeys.models.Journey;
import com.projects.juan.journeys.modules.HttpRequests;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Collections;

/**
 * A simple {@link Fragment} subclass.
 */
public class MyJourneysFragment extends Fragment {

    private static ArrayList<Journey> journeys = new ArrayList<>();
    private JourneysAdapter adapter;
    private SwipeRefreshLayout refreshLayout;

    public MyJourneysFragment() {
        // Required empty public constructor
    }

    @Override
    public void onStart() {
        if(journeys.isEmpty()) getjourneyses();
        super.onStart();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_my_journeys, container, false);
    }


    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
//        Toast.makeText(getContext(), token, Toast.LENGTH_LONG).show();
        refreshLayout = (SwipeRefreshLayout) view.findViewById(R.id.refresh_journeys);
        refreshLayout.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
            @Override
            public void onRefresh() {
                getjourneyses();
            }
        });
        //Instance and recycler
        final RecyclerView recyclerView = view.findViewById(R.id.recycler_journeys);
        recyclerView.setHasFixedSize(true);
        recyclerView.setItemAnimator(new DefaultItemAnimator());
        LinearLayoutManager layoutManager = new LinearLayoutManager(getContext());
//        layoutManager.scrollToPosition(notes.size() - 1);
//        recyclerView.scrollToPosition(notes.size() - 1);
        recyclerView.setLayoutManager(layoutManager);

//        Instance and config adapter
        adapter = new JourneysAdapter(journeys, R.layout.recycler_view_journey_item, new JourneysAdapter.OnClickListener() {
            @Override
            public void onClick(Journey journey) {

            }
        }, new JourneysAdapter.OnLongClickListener() {
            @Override
            public void onLongClick(Journey journey) {

            }
        });
        recyclerView.setAdapter(adapter);

    }

    private void getjourneyses (){
        HttpRequests.getRequest(getContext(), getArguments().getString("token"), getResources().getString(R.string.GET_JOURNEYS), "Network error, try again", new HttpRequests.CallBack(){
            @Override
            public void sendResponse(String response) {
            try {
                JSONArray journeyses_response = new JSONArray(response);
                journeys.clear();
                for(int i = 0; i < journeyses_response.length(); i++){
                    JSONObject cr = journeyses_response.getJSONObject(i);
                    journeys.add(new Journey(cr.getInt("id"), cr.getString("code"), cr.getString("start"), cr.getString("end"), cr.getInt("capacity"), cr.getInt("price"), cr.getInt("duration"), cr.getString("journey_stop"), cr.getString("tags")));
                }
                Collections.reverse(journeys);
                adapter.notifyDataSetChanged();
                refreshLayout.setRefreshing(false);
            } catch (JSONException e) {
                e.printStackTrace();
            }
            }
        });
    }
}
