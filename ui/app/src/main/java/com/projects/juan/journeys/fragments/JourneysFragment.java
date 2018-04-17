package com.projects.juan.journeys.fragments;


import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.widget.DefaultItemAnimator;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.gson.Gson;
import com.projects.juan.journeys.R;
import com.projects.juan.journeys.activities.JourneyDetailsActivity;
import com.projects.juan.journeys.activities.MapsActivity;
import com.projects.juan.journeys.activities.SignupActivity;
import com.projects.juan.journeys.adapters.JourneysAdapter;
import com.projects.juan.journeys.models.Journey;
import com.projects.juan.journeys.modules.HttpRequests;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * A simple {@link Fragment} subclass.
 */
public class JourneysFragment extends Fragment {

    private static ArrayList<Journey> journeys = new ArrayList<>();
    private JourneysAdapter adapter;
    private SwipeRefreshLayout refreshLayout;
    private ProgressDialog progressDialog;

    public JourneysFragment() {
        // Required empty public constructor
    }

    @Override
    public void onStart() {
        if(journeys.isEmpty()) getjourneys(new JSONObject());
        super.onStart();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_journeys, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {

        refreshLayout = (SwipeRefreshLayout) view.findViewById(R.id.refresh_search_journeys);
        refreshLayout.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
            @Override
            public void onRefresh() {
                getjourneys(new JSONObject());
            }
        });

        progressDialog = new ProgressDialog(getContext(), R.style.dialog_light);
        progressDialog.setIndeterminate(true);
        progressDialog.setMessage("Loading...");

        final RecyclerView recyclerView = view.findViewById(R.id.recycler_search_journeys);
        recyclerView.setHasFixedSize(true);
        recyclerView.setItemAnimator(new DefaultItemAnimator());
        LinearLayoutManager layoutManager = new LinearLayoutManager(getContext());
        recyclerView.setLayoutManager(layoutManager);

//        Instance and config adapter
        adapter = new JourneysAdapter(journeys, R.layout.recycler_view_journey_item, new JourneysAdapter.OnClickListener() {
            @Override
            public void onClick(Journey journey) {
                Intent intent = new Intent(getActivity(), JourneyDetailsActivity.class);
                Gson gson = new Gson();
                intent.putExtra("token", getArguments().getString("token"));
                intent.putExtra("id", journey.getId());
                startActivity(intent);
            }
        });
        recyclerView.setAdapter(adapter);
    }

    private void getjourneys(JSONObject search){
        progressDialog.show();
        HttpRequests.postRequest(getContext(), getArguments().getString("token"), getResources().getString(R.string.GET_SEARCH_JOURNEYS), search, "journeyses not found", new HttpRequests.CallBack() {
            @Override
            public void sendResponse(String response) {
                try {
                    JSONArray journeyses_response = new JSONArray(response);
                    journeys.clear();
                    for(int i = 0; i < journeyses_response.length(); i++){
                        JSONObject cr = journeyses_response.getJSONObject(i);
                        journeys.add(new Journey(cr.getInt("id"), cr.getString("code"), cr.getString("start"), cr.getString("end"),
                                cr.getInt("capacity"), cr.getInt("price"), cr.getInt("duration"), cr.getString("journey_stop"),
                                cr.getString("tags"), cr.getJSONArray("users")));
                    }
                    Collections.reverse(journeys);
                    adapter.notifyDataSetChanged();
                    refreshLayout.setRefreshing(false);
                    progressDialog.cancel();
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void sendFailure(String response) {

            }
        });
    }
}
