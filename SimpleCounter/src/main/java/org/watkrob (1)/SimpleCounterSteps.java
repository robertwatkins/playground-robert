package org.watkrob;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

import org.watkrob.SimpleCounter;

import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

public class SimpleCounterSteps {
    
	public SimpleCounter myCounter;
    
    @Given("I have just initialized the counter")
    public void initializeCounter1() {
    	myCounter = new SimpleCounter();
    }

    @Given("I have a counter with a value of $num")
    public void setCounter(int num) {
    	myCounter.set(num);
    }

    @When("I use the 'add1' function")
    public void useAdd1() {
    	myCounter.add1();
    }

    @When("I use the 'subtract1' function")
    public void useSubtract1() {
    	myCounter.subtract1();
    }

    @Then("the value is $num")
    public void checkCounter(int num) {
    	assertThat(myCounter.get(), equalTo(num));
    }

}
