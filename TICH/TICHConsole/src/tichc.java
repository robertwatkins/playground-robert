
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;


public class tichc {
 
	public static void main(String[] args) throws Exception {
		
		ArrayList<String[]> allEvents = new ArrayList<String[]>();
		ArrayList<String[]> daysEvents = new ArrayList<String[]>();
		Calendar date = Calendar.getInstance();
		
		allEvents = getEvents();
		
		//write out all events
		//writeEvents(allEvents);
		
		//write out events for today
		System.out.println("Writing events for "+ (date.get(Calendar.MONTH)+1) + "/" +date.get(Calendar.DAY_OF_MONTH));
		daysEvents = getEventsByDay(date, allEvents);
		writeEvents(daysEvents);
		
		//write out events for next day
		date.add(Calendar.DATE, 1);
		System.out.println("Writing events for "+ (date.get(Calendar.MONTH)+1) + "/" +date.get(Calendar.DAY_OF_MONTH));
		daysEvents = getEventsByDay(date, allEvents);
		writeEvents(daysEvents);
		
		//write out events for previous week
		date.add(Calendar.DATE, -7);
		System.out.println("Writing events for "+ (date.get(Calendar.MONTH)+1) + "/" +date.get(Calendar.DAY_OF_MONTH));
		daysEvents = getEventsByDay(date, allEvents);
		writeEvents(daysEvents);
		
		
		System.out.println("Done");
	}	
	
	private static ArrayList<String[]> getEventsByDay(Calendar date, ArrayList<String[]> allEvents) {
		ArrayList<String[]> daysEvents = new ArrayList<String[]>();
		String[] event = new String[5];
		String[] monthName = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
		
		for (int i = 0;i < allEvents.size();i++){
			event = allEvents.get(i);
			if ((event[0].equals(monthName[date.get(Calendar.MONTH)])) && (Integer.parseInt(event[1]) == date.get(Calendar.DAY_OF_MONTH))){
				daysEvents.add(event);
			} 
		}
		
		return daysEvents;

		
	}

	private static void writeEvents(List<String[]> allEvents) {
		String[] event = new String[5];
		
		
		for (int i = 0;i < allEvents.size();i++){
			event = allEvents.get(i);
			System.out.println("******");
			System.out.println(event[0] + " " + event[1] + ", " + event[2]);
			System.out.println(event[3].toUpperCase());
			System.out.println(event[4]);
		}
		
		System.out.println(allEvents.size() + " Events");
		
	}

	public static ArrayList<String[]> getEvents() throws Exception {
		
		ArrayList<String[]> allEvents = new ArrayList<String[]>();
					
		try
		{
 
			//csv file containing data
			String strFile = "data.csv";
 
			//create BufferedReader to read csv file
			BufferedReader br = new BufferedReader( new FileReader(strFile));
			String strLine = "";
			StringTokenizer st = null;
			int lineNumber = 0, tokenNumber = 0;
			String tempToken = ""; //Used in case element in CSV file is surrounded by double-quotes
			String tempToken2 = ""; //Used to read tokens to build element
			String[] tempEvent = new String[5];

			//read comma separated file line by line
			while( (strLine = br.readLine()) != null)
			{
				lineNumber++;
 
				//break comma separated line using ","
				st = new StringTokenizer(strLine, ",");
				tempEvent = new String[5];
				while(st.hasMoreTokens())
				{
					//build CSV element if surrounded by " "
					tempToken = st.nextToken();
					if (tempToken.startsWith("\"")) {
						tempToken2 = "";
						while (!tempToken2.endsWith("\"")){
							tempToken2 = st.nextToken();
							tempToken = tempToken + "," + tempToken2;
						}
						tempToken = tempToken.substring(1,tempToken.length()-1);
					}
					
					tempEvent[tokenNumber]= tempToken;
					tokenNumber++;
				}
 
				//reset token number
				tokenNumber = 0;
				allEvents.add(tempEvent);
			}
 
 
		}
		catch(Exception e)
		{
			System.out.println("Exception while reading csv file: " + e);
			
			//throw(e);
		}
		return allEvents;
	}
	
}