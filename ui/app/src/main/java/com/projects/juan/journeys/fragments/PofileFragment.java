package com.projects.juan.journeys.fragments;


import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.projects.juan.journeys.R;
import com.projects.juan.journeys.activities.AuthActivity;
import com.projects.juan.journeys.activities.MainActivity;
import com.projects.juan.journeys.models.Transaction;
import com.projects.juan.journeys.modules.HttpRequests;

import org.json.JSONException;
import org.json.JSONObject;


/**
 * A simple {@link Fragment} subclass.
 */
public class PofileFragment extends Fragment {

    public PofileFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_pofile, container, false);
    }

    @Override
    public void onViewCreated(final View view, @Nullable Bundle savedInstanceState) {

        final TextView name_profile = view.findViewById(R.id.name_profile);
        final TextView email_profile = view.findViewById(R.id.email_profile);
        final TextView coins_profile = view.findViewById(R.id.coins_profile);
        final TextView score_profile = view.findViewById(R.id.score_profile);
        final TextView role_profile = view.findViewById(R.id.role_profile);
        final TextView phone_profile = view.findViewById(R.id.phone_profile);
        final TextView studies_profile = view.findViewById(R.id.studies_profile);

        view.findViewById(R.id.pay_example_profile).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                JSONObject transaction_params = new JSONObject();
                try {
                    transaction_params.put("coins", "50");
                    transaction_params.put("transaction_code", "135G12L3K5JBM32146H3K.J1H35L1KJ3H5L123J5H13251K2J35H1L235");
                    transaction_params.put("kind", 0);
                } catch (JSONException e) {
                    e.printStackTrace();
                }
                HttpRequests.postRequest(getContext(), getArguments().getString("token"), getResources().getString(R.string.CREATE_TRANSACTION), transaction_params, "Error processing transaction", new HttpRequests.CallBack(){
                    @Override
                    public void sendResponse(String response) {
                        Toast.makeText(getContext(), "Transaction complete successfully", Toast.LENGTH_SHORT).show();
                        getInfo(name_profile, email_profile, coins_profile, score_profile, role_profile, phone_profile, studies_profile);
                    }
                });
            }
        });

        view.findViewById(R.id.logout_fab).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                AuthActivity.logout();
                Intent authSuccessful = new Intent(getContext(), AuthActivity.class);
                startActivity(authSuccessful);
                getActivity().finish();
            }
        });

        getInfo(name_profile, email_profile, coins_profile, score_profile, role_profile, phone_profile, studies_profile);
    }

    private void getInfo(final TextView name_profile, final TextView email_profile, final TextView coins_profile, final TextView score_profile, final TextView role_profile, final TextView phone_profile, final TextView studies_profile){
        HttpRequests.getRequest(getContext(), getArguments().getString("token"), getResources().getString(R.string.GET_USER), "Network error, try again", new HttpRequests.CallBack(){
            @Override
            public void sendResponse(String response) {
                try {
                    JSONObject user = new JSONObject(response);
                    name_profile.setText("Name: " + user.getString("first_name") + " " + user.getString("last_name"));
                    email_profile.setText("Email: " + user.getString("email"));
                    coins_profile.setText("Coins: " + user.getInt("coins"));
                    score_profile.setText("Score: " + user.getInt("score"));
                    role_profile.setText("Role: " + user.getString("role"));
                    phone_profile.setText("Phone: +57 " + user.getString("phone"));
                    studies_profile.setText("Studies: " + user.getString("studies"));
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });
    }

}
