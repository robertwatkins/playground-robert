package org.watkrob;

import org.watkrob.SimpleCounter;

public class SimpleCounter {

	private int counter=0;
	
	public int get()
	{
		return counter;
	}
	
	public void set(int myValue)
	{
		counter = myValue;
	}
	
	public void add1()
	{
		if (counter < Integer.MAX_VALUE) {
			counter = counter +1;
		}
		else {
			System.out.println("Attempt to set counter above maximum integer value. Keeping counter at maximum integer value.");
		}
	}
	
	public void subtract1()
	{
		counter = counter -1;
		if (counter < 0) {
			counter = 0;
		}
		else {
			System.out.println("Attempt to set counter below zero fails. Keeping counter at zero.");
		}
	}
	
	public void resetcounter()
	{
		counter = 0;
	}
	public static void main(String[] args) {
		SimpleCounter testCounter = new SimpleCounter();
		testCounter.add1();
		testCounter.subtract1();
		testCounter.subtract1();
	}
	
}
