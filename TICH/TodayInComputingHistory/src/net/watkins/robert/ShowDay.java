package net.watkins.robert;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.GridView;
import android.widget.TextView;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.StringTokenizer;

public class ShowDay extends Activity {
    private static final int MENU_ABOUT = 10;
	private static final int MENU_QUIT = 20;

	/** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        read();
        setContentView(R.layout.main);
    }


	public boolean onCreateOptionsMenu(Menu menu) {
		menu.add(0,MENU_ABOUT,0, "About");
		menu.add(0,MENU_QUIT,0,"Quit");
		return true;
	}

	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case MENU_ABOUT:
		  showAbout();
		  return true;
		case MENU_QUIT:
		  quit();
		  return true;
		}
		return false;
	}

	public boolean showAbout(){
		setContentView(R.layout.about);
	 return true;
	}
	
	public void quit() {
		this.finish();
	}
	 
	public void read() {
 
		try
		{
 
			//csv file containing data
			String strFile = "data.csv";
 
			//create BufferedReader to read csv file
			BufferedReader br = new BufferedReader( new FileReader(strFile));
			String strLine = "";
			StringTokenizer st = null;
			int lineNumber = 0, tokenNumber = 0;
 
			//read comma separated file line by line
			while( (strLine = br.readLine()) != null)
			{
				lineNumber++;
 
				//break comma separated line using ","
				st = new StringTokenizer(strLine, ",");
 
				while(st.hasMoreTokens())
				{
					//display csv values
					tokenNumber++;
					System.out.println("Line # " + lineNumber + 
							", Token # " + tokenNumber 
							+ ", Token : "+ st.nextToken());
				}
 
				//reset token number
				tokenNumber = 0;
 
			}
 
 
		}
		catch(Exception e)
		{
			System.out.println("Exception while reading csv file: " + e);			
		}
	}

}