<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Giao diện Responsive</title>

<!-- Bootstrap 5 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">




<style>
body, html {
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
	overflow-x: hidden;
}
</style>
</head>
<body class="d-flex flex-column min-vh-100">
	<!-- Header -->
	<header class="row w-100">
		<div class="col-12">
			<jsp:include page="include/fixed.jsp"></jsp:include>
		</div>
	</header>

	<!-- Nội dung chính -->
	<main class="flex-grow-1">
		<div class="col-12">
			<jsp:include page="${page}"></jsp:include>
		</div>
	</main>
	<footer class=" w-100">
		<div class="">
			<jsp:include page="include/footer.jsp"></jsp:include>
		</div>
	</footer>

</body>

</html>
