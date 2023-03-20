<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Game Contests Scoreboard | Site officiel</title>
<link href="./resources/css/style.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<script src="https://kit.fontawesome.com/1241068c5b.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous" defer></script>
<script src="./resources/js/jquery-3.6.2.min.js"></script>
<script src="./resources/js/app_live.js"></script>
</head>
<body>
	<nav class="navbar navbar-dark navbar-expand-lg bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="/MyScoreboard"><img src="./resources/img/logo.png" height="50px"></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a id="nav1" class="nav-link" aria-current="page" href="/MyScoreboard">Accueil</a>
        </li>
        <li class="nav-item">
          <a id="nav2" class="nav-link" href="games">Jeux</a>
        </li>
        <li class="nav-item">
          <a id="nav3" class="nav-link" href="players">Joueurs</a>
        </li>
        <li class="nav-item">
          <a id="nav4" class="nav-link" href="contests">Matches</a>
        </li>
      </ul>
    </div>
  </div>
</nav>