<%@ page import="net.jsunit.JsUnitServer" %>
<%@ page import="net.jsunit.ServerRegistry" %>
<%JsUnitServer server = ServerRegistry.getServer();%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JsUnit Server - UploadRunner</title>
    <script type="text/javascript" src="app/jsUnitCore.js"></script>
    <script type="text/javascript" src="app/server/jsUnitVersionCheck.js"></script>
    <script type="text/javascript">

        function removeReferencedJsFile(anId) {
            var theRow = document.getElementById(anId);
            theRow.parentNode.removeChild(theRow);
        }

        function addReferencedJsFile() {
            var id = new Date().getTime();

            var rowNode = document.createElement("tr");
            rowNode.setAttribute("id", id);
            var leftCellNode = document.createElement("td");
            var boldElement = document.createElement("b");
            var textNode = document.createTextNode(".js file:");
            boldElement.appendChild(textNode);
            leftCellNode.appendChild(boldElement);

            rowNode.appendChild(leftCellNode);

            var middleCellNode = document.createElement("td");
            middleCellNode.setAttribute("width", "1");
            var fileUploadField = document.createElement("input");
            fileUploadField.setAttribute("type", "file");
            fileUploadField.setAttribute("size", "50");
            fileUploadField.setAttribute("name", "referencedJsFiles");
            middleCellNode.appendChild(fileUploadField);

            rowNode.appendChild(middleCellNode);

            var rightCellNode = document.createElement("td");
            rightCellNode.setAttribute("align", "left");
            var removeLink = document.createElement("a");
            removeLink.setAttribute("href", "javascript:removeReferencedJsFile(\"" + id + "\")");
            removeLink.appendChild(document.createTextNode("[remove]"));
            rightCellNode.appendChild(removeLink);

            rowNode.appendChild(rightCellNode);

            var addReferencedJsFileRowNode = document.getElementById("addReferencedJsFileRow");
            var rowParentNode = addReferencedJsFileRowNode.parentNode;
            rowParentNode.insertBefore(rowNode, addReferencedJsFileRowNode);
        }

    </script>
    <link rel="stylesheet" type="text/css" href="./css/jsUnitStyle.css">
</head>

<body bgcolor="#e4ecec">
<form action="/jsunit/runner" method="post" target="resultsFrame" enctype="multipart/form-data">
<jsp:include page="header.jsp"/>
<table cellpadding="0" cellspacing="0" width="100%" bgcolor="#FFFFFF">
<jsp:include page="tabRow.jsp">
    <jsp:param name="selectedPage" value="uploadRunner"/>
</jsp:include>
<tr>
<td colspan="13" style="border-style: solid;border-bottom-width:1px;border-top-width:0px;border-left-width:1px;border-right-width:1px;border-color:#000000;">
<table>
<tr>
    <td nowrap width="5%" valign="top">
        <b>Test Page:</b>
    </td>
    <td width="30%" valign="top">
        <input type="file" name="testPageFile" size="50">
    </td>
    <td width="30%" valign="top">
        <input type="submit" value="Run">
    </td>
    <td width="1%" rowspan="50">&nbsp;</td>
    <td width="33%" rowspan="50" valign="top">
        <div class="rb1roundbox">
            <div class="rb1top"><div></div></div>

            <div class="rb1content">
                <table width="100%">
                    <tr>
                        <td align="center">
                            <div class="rb3roundbox">
                                <div class="rb3top"><div></div></div>

                                <div class="rb3content">
                                    <img src="/jsunit/images/question_mark.gif" alt="What is the UploadRunner?" title="What is the FragmentRunner?" border="0">
                                    <b>What is the UploadRunner service?</b>
                                </div>

                                <div class="rb3bot"><div></div></div></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            You can ask this JsUnit Server to run JsUnit on your Test Pages using the <i>upload
                            runner</i> service. Select your Test Page and associated .js files (if any), choose which
                            browsers you want to run your Test Page on and which skin you want your results displayed
                            in, and press "Run".
                            <br>
                            The upload runner service is useful for manually running your Test Pages, but it's a pain
                            to have to browse to your Test Page and its .js files. The next step is to automate your
                            runs using JsUnit automated web services and the JsUnit client. <a href="#">Learn more.</a>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="rb1bot"><div></div></div></div>
    </td>
    <td width="1%" rowspan="50">&nbsp;</td>
</tr>
<%

    String countString = request.getParameter("referencedJsFileFieldCount");
    if (countString != null) {
        int count = Integer.parseInt(countString);
        for (int i = 0; i < count; i++) {

%>
<tr id="defaultReferencedJsFileField<%=i%>">
    <td width="5%">.js file</td>
    <td width="20%" align="left"><input type="file" name="referencedJsFiles"></td>
    <td width="40%">
        <a href="javascript:removeReferencedJsFile('defaultReferencedJsFileField<%=i%>')">[remove]</a>
    </td>
</tr>
<%
        }
    }

%>
<tr id="addReferencedJsFileRow">
    <td>&nbsp;</td>
    <td colspan="2">
        <a href="javascript:addReferencedJsFile()" id="addReferencedJsFile">
            add referenced .js file
        </a>
    </td>
</tr>

<tr>
    <td width="5%" valign="top">
        <b>Browsers:</b>
    </td>
    <td width="25%" valign="top">
        <jsp:include page="browsers.jsp">
            <jsp:param name="multipleBrowsersAllowed" value="true"/>
        </jsp:include>
    </td>
    <td width="35%" valign="top" rowspan="2">
        <%if (server.getConfiguration().useCaptcha()) {%>
        <jsp:include page="captcha.jsp"/>
        <%}%>
    </td>
</tr>
<tr>
    <td width="5%" valign="top">
        <b>Skin:</b>
    </td>
    <td width="25%" valign="top">
        <jsp:include page="skin.jsp"/>
    </td>
</tr>
<tr>
    <td colspan="3">&nbsp;</td>
</tr>
</table>
</td>
</tr>
</table>
</form>

<b>Test results:</b>
<iframe name="resultsFrame" width="100%" height="250" src="/jsunit/app/emptyPage.html"></iframe>

</body>
</html>