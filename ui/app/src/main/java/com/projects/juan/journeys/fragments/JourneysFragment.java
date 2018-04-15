package com.projects.juan.journeys.fragments;


import android.app.AlertDialog;
import android.content.DialogInterface;
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
public class JourneysFragment extends Fragment {

    private static ArrayList<Journey> journeys = new ArrayList<>();
    private JourneysAdapter adapter;
    private SwipeRefreshLayout refreshLayout;

    public JourneysFragment() {
        // Required empty public constructor
    }

    @Override
    public void onStart() {
        if(journeys.isEmpty()) getjourneyses(new JSONObject());
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
                getjourneyses(new JSONObject());
            }
        });

        final EditText edit_search = (EditText) view.findViewById(R.id.edit_search_journeys);

        edit_search.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {}

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {}

            @Override
            public void afterTextChanged(Editable editable) {
                JSONObject search_object = new JSONObject();
                try {
                    search_object.put("title", edit_search.getText());
                } catch (JSONException e) {
                    e.printStackTrace();
                }
                getjourneyses(search_object);
            }
        });

        final RecyclerView recyclerView = view.findViewById(R.id.recycler_search_journeys);
        recyclerView.setHasFixedSize(true);
        recyclerView.setItemAnimator(new DefaultItemAnimator());
        LinearLayoutManager layoutManager = new LinearLayoutManager(getContext());
        recyclerView.setLayoutManager(layoutManager);

//        Instance and config adapter
        adapter = new JourneysAdapter(journeys, R.layout.recycler_view_journey_item, new JourneysAdapter.OnClickListener() {
            @Override
            public void onClick(Journey journey) {
//                HttpRequests.getRequest(getContext(), getArguments().getString("token"), getResources().getString(R.string.GET_JOURNEYS) + journey.getId(), "Journey details not found", new HttpRequests.CallBack() {
//                    @Override
//                    public void sendResponse(String response) {
//                        try {
//                            JSONArray users = new JSONObject(response).getJSONArray("users");
//                            String teachersArray = "";
//                            String studentsArray = "";
//                            for (int i = 0; i < users.length(); i++){
//                                JSONObject user = new JSONObject(users.get(i).toString());
//                                if(user.getString("role").equals("teacher")) teachersArray += user.getString("first_name") + " " + user.getString("last_name") + ",";
//                                if(user.getString("role").equals("student")) studentsArray += user.getString("first_name") + " " + user.getString("last_name") + ",";
//                            }
//                            teachers.setText("Teachers: " + teachersArray);
//                            students.setText("Students: " + studentsArray);
//                        } catch (JSONException e) {
//                            e.printStackTrace();
//                        }
//                    }
//                });
            }
        }, new JourneysAdapter.OnLongClickListener() {
            @Override
            public void onLongClick(final Journey journey) {
//                AlertDialog.Builder builder = new AlertDialog.Builder(getContext());
//                builder.setTitle("Join to " + journey.getTitle());
//                builder.setMessage("Price: " + journey.getPrice());
//
//                builder.setPositiveButton("Continue", new DialogInterface.OnClickListener() {
//                    @Override
//                    public void onClick(DialogInterface dialogInterface, int i) {
//                        JSONObject join_params = new JSONObject();
//                        try {
//                            join_params.put("title", journey.getTitle());
//                        } catch (JSONException e) {
//                            e.printStackTrace();
//                        }
//                        HttpRequests.postRequest(getContext(), getArguments().getString("token"),
//                                getResources().getString(R.string.GET_JOURNEYS) + journey.getId() + "/join", join_params, "Network error", new HttpRequests.CallBack() {
//                                    @Override
//                                    public void sendResponse(String response) {
//                                        try {
//                                            JSONObject jr = new JSONObject(response);
//                                            if(response.contains("err")){
//                                                Log.d("err", response);
//                                                Toast.makeText(getContext(), jr.getString("err"), Toast.LENGTH_LONG).show();
//                                            }else{
//                                                Toast.makeText(getContext(), "Joined to " + journey.getTitle() + " successfully", Toast.LENGTH_LONG).show();
//                                            }
//                                        } catch (JSONException e) {
//                                            e.printStackTrace();
//                                        }
//                                    }
//                                });
//                    }
//                });
//                builder.setNegativeButton("Cancel", null);
//
//                AlertDialog dialog = builder.create();
//                dialog.show();
            }
        });
        recyclerView.setAdapter(adapter);
    }

    private void getjourneyses(JSONObject search){
        HttpRequests.postRequest(getContext(), getArguments().getString("token"), getResources().getString(R.string.GET_SEARCH_JOURNEYS), search, "journeyses not found", new HttpRequests.CallBack() {
            @Override
            public void sendResponse(String response) {
                try {
                    JSONArray journeyses_response = new JSONArray(response);
                    journeys.clear();
                    for(int i = 0; i < journeyses_response.length(); i++){
                        JSONObject cr = journeyses_response.getJSONObject(i);
                        journeys.add(new Journey(cr.getInt("id"), cr.getString("start"), cr.getString("end"), cr.getInt("capacity"), cr.getInt("price"), cr.getInt("duration"), cr.getString("journey_stop"), cr.getString("tags")));
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
