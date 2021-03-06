package es.ugr.swad.swadroid.modules.messages;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseExpandableListAdapter;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.ImageView;
import android.widget.TextView;

import com.nostra13.universalimageloader.core.DisplayImageOptions;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;

import es.ugr.swad.swadroid.R;
import es.ugr.swad.swadroid.model.User;
import es.ugr.swad.swadroid.modules.rollcall.students.StudentItemModel;

/**
 * Custom ExpandableListAdapter for display users at Messages
 *
 * @author Jos� Antonio Guerrero Avil�s <cany20@gmail.com>
 */

public class ExpandableStudentsListAdapter extends BaseExpandableListAdapter{

	private ArrayList<String> groupItem;
	private ArrayList<List<User>> childItem;
	private LayoutInflater minflater;
	private Activity activity;
	
	//private int widthScale, heightScale, bMapScaledWidth, bMapScaledHeight;

	
	
	public ExpandableStudentsListAdapter(ArrayList<String> grList,
			ArrayList<List<User>> childItem2) {
		groupItem = grList;
        this.childItem = childItem2;
	}

	public ExpandableStudentsListAdapter(Activity act, ArrayList<String> grList,
			ArrayList<List<User>> childItem2) {
		groupItem = grList;
		activity = act;
		minflater = LayoutInflater.from(activity);
        this.childItem = childItem2;
	}

	public void setInflater(LayoutInflater mInflater, Activity act) {
		this.minflater = mInflater;
		activity = act;
	}

	public void setActivity(Activity act) {
		activity = act;
		minflater = LayoutInflater.from(activity);
	}
	
	
	@Override
	public int getGroupCount() {
		return groupItem.size();
	}

	@Override
	public int getChildrenCount(int groupPosition) {
		return childItem.get(groupPosition).size();
	}

	@Override
	public Object getGroup(int groupPosition) {
		return groupItem.get(groupPosition);
	}

	@Override
	public Object getChild(int groupPosition, int childPosition) {
		return childItem.get(groupPosition).get(childPosition);
	}

	@Override
	public long getGroupId(int groupPosition) {
		return groupPosition;
	}

	@Override
	public long getChildId(int groupPosition, int childPosition) {
		return 0;
	}

	@Override
	public boolean hasStableIds() {
		return false;
	}

	@Override
	public View getGroupView(int groupPosition, boolean isExpanded,
			View convertView, ViewGroup parent) {
			
		TextView groupTitle;
		
		if (convertView == null) {
			convertView = minflater.inflate(R.layout.messages_group_item, parent, false);
		}
		
		groupTitle = (TextView) convertView.findViewById(R.id.messages_group_item_title);		
		groupTitle.setText(groupItem.get(groupPosition));
		
		return convertView;
	}

	@Override
	public View getChildView(int groupPosition, int childPosition,
			boolean isLastChild, View convertView, ViewGroup parent) {

        //Bitmap bMap = null;

        final User u = (User) childItem.get(groupPosition).get(childPosition);
        
        final String fullName = u.getUserSurname1() 
        						+' '
        						+u.getUserSurname2()
        						+ ", "
        						+ u.getUserFirstname();
        
        final String photoFileName = u.getUserPhoto();
        Log.i("fileNAME:"," "+photoFileName);
        
        if (convertView == null) {
        	convertView = minflater.inflate(R.layout.messages_child_item, parent, false);
        }
        
        ImageView image = (ImageView) convertView.findViewById(R.id.imageView1);
        TextView text = (TextView) convertView.findViewById(R.id.TextView1);
        final CheckBox checkbox = (CheckBox) convertView.findViewById(R.id.check);
        checkbox.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                checkbox.setSelected(buttonView.isChecked());
                u.setSelected(isChecked);
            }
        });
        // Calculate the dimensions of the screen to resize the photos
        //Display display = ((WindowManager) activity.getSystemService(Context.WINDOW_SERVICE)).getDefaultDisplay();
        
        
        //If the user photo exists and is public, download and show it. On error show a default pfoto
        /*if (Utils.connectionAvailable(activity)
                && (photoFileName != null) && !photoFileName.equals("")
                && !photoFileName.equals(Constants.NULL_VALUE)) {*/

        	DisplayImageOptions options = new DisplayImageOptions.Builder()
        								.showImageForEmptyUri(R.raw.usr_bl)
        								.showImageOnFail(R.raw.usr_bl)
        								.cacheInMemory(true).build();
        	
			ImageLoaderConfiguration config = new ImageLoaderConfiguration.Builder(activity.getApplicationContext())
			            					.defaultDisplayImageOptions(options).build();
			ImageLoader.getInstance().init(config);
			ImageLoader.getInstance().displayImage(photoFileName, image);
			
			
			/*widthScale = 1200;
            heightScale = 2000;
            bMapScaledWidth = (image.getWidth() * display.getWidth()) / widthScale;
            bMapScaledHeight = (image.getHeight() * display.getHeight()) / heightScale;
            
            LinearLayout.LayoutParams params = new LayoutParams(bMapScaledWidth, bMapScaledHeight);
            image.setLayoutParams(params);*/
            
        /*} 
        else {
            Log.d("ExpLVStudentList", "No connection or no photo " + photoFileName);
            bMap = BitmapFactory.decodeStream(image.getResources().openRawResource(R.raw.usr_bl));

			// Calculate the dimensions of the image to display as a function of the resolution of the screen
            widthScale = 1200;
            heightScale = 2000;
            bMapScaledWidth = (bMap.getWidth() * display.getWidth()) / widthScale;
            bMapScaledHeight = (bMap.getHeight() * display.getHeight()) / heightScale;

            Bitmap bMapScaled = Bitmap.createScaledBitmap(bMap, bMapScaledWidth, bMapScaledHeight, true);
            image.setImageBitmap(bMapScaled);            
           
        }*/

        text.setText(fullName);
        text.setTag(u.getUserNickname());
        checkbox.setChecked((new StudentItemModel(u)).isSelected());


        return convertView;
    }

	@Override
	public boolean isChildSelectable(int groupPosition, int childPosition) {
		return true;
	}

	@Override
	public void onGroupCollapsed(int groupPosition) {
		super.onGroupCollapsed(groupPosition);
	}

	@Override
	public void onGroupExpanded(int groupPosition) {
		super.onGroupExpanded(groupPosition);
	}
}
