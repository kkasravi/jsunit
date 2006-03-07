// Copyright 2005 Google Inc.
// All Rights Reserved.
package net.jsunit;

import junit.framework.TestCase;
import net.jsunit.utility.XmlUtility;
import org.jdom.Document;

import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLStreamHandler;

public class RemoteMachineRunnerHitterTest extends TestCase {

    String xml = "<my_document><my_node value=\"1\">my text</my_node></my_document>";

    public void testAllAtOnce() throws Exception {
        RemoteMachineRunnerHitter hitter = new RemoteMachineRunnerHitter();
        Document document = hitter.hitURL(createURL(xml, xml.length()));
        assertDocumentHasXml(xml, document);
    }

    public void testAPieceAtATime() throws Exception {
        RemoteMachineRunnerHitter hitter = new RemoteMachineRunnerHitter();
        Document document = hitter.hitURL(createURL(xml, 3));
        assertDocumentHasXml(xml, document);
    }

    private void assertDocumentHasXml(String expectedXML, Document document) {
        assertEquals(expectedXML, XmlUtility.asString(document.getRootElement()));
    }

    private URL createURL(final String xml, final int byteCount) throws MalformedURLException {
        return new URL("http", "www/example.com", 8080, "foo", new URLStreamHandler() {
            protected URLConnection openConnection(URL u) {
                return new URLConnection(u) {
                    public void connect() {
                    }

                    public InputStream getInputStream() {
                        return new InputStream() {

                            private int index = 0;
                            private int upToIndex = 0;

                            public int available() {
                                int remaining = upToIndex - index;
                                if (remaining == 0 && upToIndex != xml.length()) {
                                    upToIndex = Math.min(index + byteCount, xml.length());
                                    remaining = upToIndex - index;
                                }
                                return remaining;
                            }

                            public int read() {
                                return xml.codePointAt(index++);
                            }
                        };
                    }
                };
            }
        });
    }

}