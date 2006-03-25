package net.jsunit;

import net.jsunit.configuration.ConfigurationSource;
import net.jsunit.model.Browser;

public class SpecificBrowserDistributedTestTest extends EndToEndTestCase {

    protected ConfigurationSource farmSource() {
        return new StubConfigurationSource() {
            public String remoteMachineURLs() {
                return "http://localhost:" + port;
            }

            public String port() {
                return String.valueOf(port);
            }

        };
    }

    protected StubConfigurationSource serverSource() {
        return new StubConfigurationSource() {

            public String browserFileNames() {
                return "invalid1.exe," + Browser.DEFAULT_SYSTEM_BROWSER + ",invalid2.exe";
            }

            public String url() {
                return "http://localhost:" + port + "/jsunit/testRunner.html?"
                        + "testPage=http://localhost:" + port + "/jsunit/tests/jsUnitUtilityTests.html&autoRun=true&submitresults=true";
            }

            public String port() {
                return String.valueOf(port);
            }
        };
    }

    public void testSuccessfulRun() {
        DistributedTest test = new DistributedTest(serverSource(), farmSource());
        test.limitToBrowser(new Browser(Browser.DEFAULT_SYSTEM_BROWSER, 1));
        assertSuccessful(test);
        assertEquals(1, test.getTestRunResults().size());
        assertNull(test.getTemporaryStandardServer());
    }

}