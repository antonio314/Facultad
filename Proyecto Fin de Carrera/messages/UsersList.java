/**
 * Module to filter the users list to one course
 *
 * @author Jose Antonio Guerrero Aviles <cany20@gmail.com>
 */

package es.ugr.swad.swadroid.modules.messages;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ExpandableListView;
import es.ugr.swad.swadroid.Constants;
import es.ugr.swad.swadroid.R;
import es.ugr.swad.swadroid.gui.MenuActivity;
import es.ugr.swad.swadroid.model.User;

public class UsersList extends MenuActivity {

	public static final String TAG = Constants.APP_TAG + " Users List";
    private String rcvs = "";
    private String rcvs_Aux = "";
	
    /**
	 * List of groups for ExpandableListView
	 */
	ArrayList<String> groupItem;
	/**
	 * List of childs for ExpandableListView
	 */
	ArrayList<List<User>> childItem;
	/**
	 * Adapter container for users
	 */
	ExpandableStudentsListAdapter adapter;
	/**
	 * ListView container for notifications
	 */
	ExpandableListView list;
	/**
	 * Id for the teachers group
	 */
	int TEACHERS_GROUP_ID = 0;
	/**
	 * Id for the students group
	 */
	int STUDENTS_GROUP_ID = 1;
	/**
	 * Cursor orderby parameter
	 */
	private final String orderby = "userSurname1 ASC,userSurname2 ASC,userFirstname ASC";
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.users_listview);
		setTitle(R.string.selectRcvModuleLabel);
		getSupportActionBar().setIcon(R.drawable.users);	
		
		list = (ExpandableListView) findViewById(R.id.users_explistview);
		
		groupItem = new ArrayList<String>();
		childItem = new ArrayList<List<User>>();
		
		//Download the users list
		downloadUsersList();
		
		//Set ExpandableListView data
		setGroupData();
		setChildGroupData();
		
		Button acceptList = (Button) findViewById(R.id.acceptList);
		acceptList.setOnClickListener(new View.OnClickListener() {
			
			public void onClick(View v) {
				
				//Accept receivers list marked at users list
				if (!childItem.isEmpty()){
					for (int i = 0; i < childItem.size(); i ++){		
						int tam = childItem.get(i).size();
						for(int j = 0; j < tam; j++){
							User usu = childItem.get(i).get(j);
							if (usu.isSelected()){
								String us = usu.getUserNickname().toString();
								rcvs_Aux = rcvs_Aux + "@" + us + ",";
							}	
						}
					}
	        		//If receivers, remove the last comma
					if(!rcvs_Aux.isEmpty()) rcvs = rcvs_Aux.substring(0, rcvs_Aux.length()-1);
				}
				Intent resultData = new Intent();
				resultData.putExtra("ListaRcvs", rcvs);
				setResult(Activity.RESULT_OK, resultData);
                finish();
				
			}
		});
		
	}


	@Override
    protected void onStart() {
		super.onStart();
		setChildGroupData();
    }

	protected void onError() {
		
	}
	
	 private void downloadUsersList() {	 
		 	Intent donwloadUsersList = new Intent (getBaseContext(), DownloadUsers.class);
			startActivity(donwloadUsersList);
			setChildGroupData();
	}
	
	private void setChildGroupData() {
		
		List<User> child = null;

		//Clear data
		childItem.clear();

		
		//Add data for teachers 
		child = dbHelper.getAllRows(Constants.DB_TABLE_USERS,"userRole='"
				+ Constants.TEACHER_TYPE_CODE+"'", orderby);	
		Collections.sort(child);
		childItem.add(child);
		
		//Add data for students	
		//child.clear();
		child = dbHelper.getAllRows(Constants.DB_TABLE_USERS,"userRole<>'"
				+ Constants.TEACHER_TYPE_CODE+"'", orderby);
		
		Collections.sort(child);
		childItem.add(child);
		
		Log.d(TAG, "groups size=" + childItem.size());
		Log.d(TAG, "teachers children size=" + childItem.get(TEACHERS_GROUP_ID).size());
		Log.d(TAG, "students children size=" + childItem.get(STUDENTS_GROUP_ID).size());
		
		adapter = new ExpandableStudentsListAdapter(this, groupItem, childItem);

		if(dbHelper.getAllRowsCount(Constants.DB_TABLE_USERS) > 0) {
			Log.d(TAG, "[setChildGroupData] Users table is not empty");
			list.setAdapter(adapter);
			//list.setOnChildClickListener(clickListener);

		} else {
			Log.d(TAG, "[setChildGroupData] Users table is empty");
			list.setOnChildClickListener(null);

		}
	}

	private void setGroupData() {		
		groupItem.add(getString(R.string.Filters_Teachers));
		groupItem.add(getString(R.string.Filters_Students));		
	}
	

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
	    getMenuInflater().inflate(R.menu.users_list_activity_actions, menu);
	    return super.onCreateOptionsMenu(menu);
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
	    switch (item.getItemId()) {
	        case R.id.action_refresh_users:      	
	        	Intent reefreshUserList = new Intent (getBaseContext(), DownloadUsers.class);
				startActivityForResult(reefreshUserList, 0);            
	            return true;
  
	        default:
	            return super.onOptionsItemSelected(item);
	    }
	    
	}
	
}