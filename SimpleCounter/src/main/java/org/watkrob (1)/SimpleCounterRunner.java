package org.watkrob;

import java.util.Arrays;
import java.util.List;
import org.junit.runner.RunWith;
import org.jbehave.core.steps.InjectableStepsFactory;
import org.jbehave.core.steps.InstanceStepsFactory;
import org.jbehave.core.junit.JUnitStories;
import de.codecentric.jbehave.junit.monitoring.JUnitReportingRunner;
@RunWith(JUnitReportingRunner.class)
public class SimpleCounterRunner extends JUnitStories {

	
	public SimpleCounterRunner() {
		super();
	}

	@Override
	public InjectableStepsFactory stepsFactory() {
		return new InstanceStepsFactory(configuration(), new SimpleCounterSteps());
	}
	
	@Override
	protected List<String> storyPaths() {
		return Arrays.asList("org/watkrob/counter.story");
	}
}
