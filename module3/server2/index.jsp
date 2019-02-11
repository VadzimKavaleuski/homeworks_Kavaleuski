<%@page contentType="text/html" pageEncoding="UTF-8" %><%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
	<table><tr>
		<td><a href="/">home</a></td>
		<td><a href="/app">loadbalancer</a></td>
		<td><a href="/s2app">direct to server2</a></td>
		<td><a href="/s3app">direct to server3</a></td>
		<td><a href="/status">jk_mod status</a></td>
	</tr></table>
	<br><h2>Server 2</h2>
<br>GMT:<%=(new SimpleDateFormat("dd.MM.yyyy HH:mm:ss")).format(System.currentTimeMillis()).toString()%>