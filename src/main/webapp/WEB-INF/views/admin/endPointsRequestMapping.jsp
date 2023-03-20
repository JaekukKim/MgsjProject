<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Endpoint list</title>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th>path</th>
				<th>methods</th>
				<th>consumes</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${endPoint}" var="endPoint">
				<tr>
					<td>${endPoint}</td>
					<td>${endPoint.key.patternsCondition}</td>
					<td>${endPoint.value}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>
