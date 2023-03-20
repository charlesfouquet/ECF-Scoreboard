<script type="text/javascript">
	$(window).on('load', function() {
		$('#idUpdate').val("${gameToUpdate.id}");
		$('#titleUpdate').val("${gameToUpdate.title}");
		$('#min_playersUpdate').val("${gameToUpdate.min_players}");
		$('#max_playersUpdate').val("${gameToUpdate.max_players}");
		$('#updateModal').modal('show');
	});
</script>

<section>
	<h1>Bienvenue sur Board Game Contests Scoreboard</h1>

	<h4 style="margin-bottom: 50px;">
		Votre site officiel d'organisation de <span
			style="color: cadetblue; font-weight: 800;"><c:out
				value="${nbConducteurs}" />tournois de jeux de société</span> !
	</h4>
	
	<h4 style="color: cadetblue; font-weight: 800;">Liste des matches</h4>
	<c:if test="${listeMatches.size() > 0}">
		<table class="table">
			<colgroup>
				<col span="1" style="width: 25%;">
				<col span="1" style="width: 25%;">
				<col span="1" style="width: 25%;">
				<col span="1" style="width: 25%;">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">Nom du jeu</th>
					<th scope="col">Inscrits/Capacité</th>
					<th scope="col">Date du match</th>
					<th scope="col">Gagnant</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${listeMatches}" var="match"
					varStatus="status">
					<tr>
						<td><c:out value="${match.game.title}"/></td>
						<td><c:out value="${match.playersCount}"/>/<c:out value="${match.game.max_players}"/> <i class="fa-solid fa-user"></i></td>
						<td><c:out value="${match.start_date}"/></td>
						<td>
							<c:if test="${not empty match.winner.nickname}">
								<c:out value="${match.winner.nickname}"/>
							</c:if>
							<c:if test="${empty match.winner.nickname}">
								<em style="color:#DDDDDD;font-size:80%;">(Match à venir)</em>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
	<c:if test="${listeMatches.size() == 0}">
		<h2>Pas de matches dans la base</h2>
	</c:if>
	
	<hr>
	
	<h4 style="color: cadetblue; font-weight: 800;">Liste des joueurs membres</h4>
	<c:if test="${listeJoueurs.size() > 0}">
		<table class="table">
			<colgroup>
				<col span="1" style="width: 50%;">
				<col span="1" style="width: 50%;">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">Email du joueur</th>
					<th scope="col">Pseudo du joueur</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${listeJoueurs}" var="joueur"
					varStatus="status">
					<tr>
						<td><c:out value="${joueur.email}"/></td>
						<td><c:out value="${joueur.nickname}"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
	<c:if test="${listeJoueurs.size() == 0}">
		<h2>Pas de joueurs dans la base</h2>
	</c:if>
	
	<hr>
	
	<h4 style="color: cadetblue; font-weight: 800;">Liste des jeux proposés</h4>
	<c:if test="${listeJeux.size() > 0}">
		<table class="table">
			<colgroup>
				<col span="1" style="width: 50%;">
				<col span="1" style="width: 50%;">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">Nom du jeu</th>
					<th scope="col">Joueurs</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${listeJeux}" var="jeu"
					varStatus="status">
					<tr>
						<td><c:out value="${jeu.title}"/></td>
						<td><c:out value="${jeu.min_players}"/>-<c:out value="${jeu.max_players}"/> <i class="fa-solid fa-user"></i></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
	<c:if test="${listeJeux.size() == 0}">
		<h2>Pas de jeu dans la base</h2>
	</c:if>
</section>