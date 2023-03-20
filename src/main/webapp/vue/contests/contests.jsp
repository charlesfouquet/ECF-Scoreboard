<section>
	<h1>PAGE DES MATCHES</h1>

	<c:if test="${not empty message}">
		<c:choose>
			<c:when test="${fn:contains(message, 'Erreur')}">
				<div class="messageToUser errorMessage">
					<c:out value="${message}" />
				</div>
			</c:when>
			<c:otherwise>
				<div class="messageToUser">
					<c:out value="${message}" />
				</div>
			</c:otherwise>
		</c:choose>
	</c:if>

	<h4>Pour rappel, voici la liste des matches</h4>
	<c:if test="${listeMatches.size() > 0}">
		<table class="table">
			<colgroup>
				<col span="1" style="width: 5%;">
				<col span="1" style="width: 25%;">
				<col span="1" style="width: 10%;">
				<col span="1" style="width: 25%;">
				<col span="1" style="width: 20%;">
				<col span="1" style="width: 5%;">
				<col span="1" style="width: 5%;">
				<col span="1" style="width: 5%;">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">ID</th>
					<th scope="col">Jeu</th>
					<th scope="col">Ins./Cap.*</th>
					<th scope="col">Date</th>
					<th scope="col">Gagnant</th>
					<th scope="col">Liste</th>
					<th scope="col">Mod</th>
					<th scope="col">Sup</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${listeMatches}" var="match" varStatus="status">
					<tr>
						<td><c:out value="${match.id}" /></td>
						<td><c:out value="${match.game.title}" /></td>
						<td><c:out value="${match.playersCount}" />/<c:out
								value="${match.game.max_players}" /> <i
							class="fa-solid fa-user"></i></td>
						<td><c:out value="${match.start_date}" /></td>
						<td><c:if test="${not empty match.winner.nickname}">
								<c:out value="${match.winner.nickname}" />
							</c:if> <c:if test="${empty match.winner.nickname}">
								<em style="color: #DDDDDD; font-size: 80%;">(Match à venir)</em>
							</c:if></td>
						<td><a href="?id=${match.id}&act=playersList" type="button"
							class="playersBtn"><i class="fa-solid fa-users"></i></a></td>
						<td><a href="?id=${match.id}&act=update" type="button"
							class="editBtn"><i class="fa-solid fa-pen-to-square"></i></a></td>
						<td><a href="?id=${match.id}&act=delete" class="deleteBtn"><i
								class="fa-solid fa-trash-can"></i></a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<p class="text-small text-muted">
			<em>(*Ins./Cap. = Inscrits/Capacité)</em>
		</p>
	</c:if>
	<c:if test="${listeMatches.size() == 0}">
		<h2>Pas de jeu dans la base</h2>
	</c:if>

	<hr>

	<div class="addForm">
		<h4>Ajouter un match</h4>

		<form id="newItem" method="post" action="contests">
			<div class="form-group">
				<label for="gameID">Jeu</label>
				<select class="form-select" aria-label="Default select example"
					name="gameID">
					<c:if test="${listeJeux.size() == 0}">
						<option selected value=0>Pas de jeu</option>
					</c:if>
					<c:if test="${listeJeux.size() > 0}">
						<option selected value=0>Choisir un jeu</option>
						<c:forEach items="${listeJeux}" var="jeu" varStatus="status">
							<option value="${jeu.id}"><c:out value="${jeu.title}" /></option>
						</c:forEach>
					</c:if>
				</select>
			</div>
			<div class="form-group">
				<label for="start_date">Date du match</label> <input type="date"
					class="form-control" id="start_date" name="start_date">
			</div>
			<button type="submit" class="btn btn-primary">Ajouter</button>
		</form>
	</div>

	<hr>

	<div class="modal fade" id="updateModal" tabindex="-1"
		aria-labelledby="updateModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="updateModalLabel">Mise à jour</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="updateItem" method="post" action="contests">
						<div class="form-group">
							<label for="idUpdate">ID</label> <input type="text"
								class="form-control" id="idUpdate" name="idUpdate" readonly>
						</div>
						<div class="form-group">
							<label for="gameIDUpdate">Jeu</label>
							<select class="form-select" aria-label="Default select example"
								name="gameIDUpdate" id="gameIDUpdate">
								<c:if test="${listeJeux.size() == 0}">
									<option selected value=0>Pas de jeu</option>
								</c:if>
								<c:if test="${listeJeux.size() > 0}">
									<option selected value=0>Choisir un jeu</option>
									<c:forEach items="${listeJeux}" var="jeu" varStatus="status">
										<option value="${jeu.id}"><c:out value="${jeu.title}" /></option>
									</c:forEach>
								</c:if>
							</select>
						</div>
						<div class="form-group">
							<label for="start_dateUpdate">Date du match</label> <input type="date"
					class="form-control" id="start_dateUpdate" name="start_dateUpdate">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Annuler</button>
					<button type="submit" class="btn btn-primary" form="updateItem">Mettre
						à jour</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="playersModal" tabindex="-1"
		aria-labelledby="playersModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="playersModalLabel">Liste des joueurs</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<c:if test="${playersList.size() > 0}">
						<table class="table">
							<colgroup>
								<col span="1" style="width: 5%;">
								<col span="1" style="width: 45%;">
								<col span="1" style="width: 45%;">
								<c:if test="${empty contestPlayersInfo.winner}">
									<col span="1" style="width: 5%;">
								</c:if>
							</colgroup>
							<thead>
								<tr>
									<th scope="col">ID</th>
									<th scope="col">Email du joueur</th>
									<th scope="col">Pseudo du joueur</th>
									<c:if test="${empty contestPlayersInfo.winner}">
										<th scope="col">Sup</th>
									</c:if>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${playersList}" var="joueur"
									varStatus="status">
									<tr>
										<td><c:out value="${joueur.id}"/></td>
										<td><c:out value="${joueur.email}"/></td>
										<td><c:out value="${joueur.nickname}"/></td>
										<c:if test="${empty contestPlayersInfo.winner}">
											<td><a href="?id=${joueur.id}&act=deleteFromContest&contest=${contestID}" class="deleteBtn"><i class="fa-solid fa-user-xmark"></i></a></td>
										</c:if>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
					<c:if test="${playersList.size() == 0}">
						<h2>Pas encore de joueurs dans ce match</h2>
					</c:if>
					<c:if test="${playersList.size() < contestPlayersInfo.game.min_players}">
						<h4 style="color:red;">Le nombre minimum requis de joueurs n'est pas atteint !</h4>
					</c:if>
					<c:if test="${playersList.size() == contestPlayersInfo.game.max_players}">
						<c:if test="${empty contestPlayersInfo.winner}">
							<h4 style="color:green;">Ce match est à capacité !</h4>
						</c:if>
					</c:if>
					<c:if test="${playersList.size() < contestPlayersInfo.game.max_players}">
						<c:if test="${empty contestPlayersInfo.winner}">
							<form id="addPlayer" method="post" action="contests">
								<div class="form-group">
									<input type="text" class="form-control" id="idContest" name="idContest" style="display:none;">
									<label for="playerAdded">Inscrire un joueur</label>
									<select class="form-select" aria-label="Default select example"
										name="playerAdded" id="playerAdded">
										<c:if test="${listeAutresJoueurs.size() == 0}">
											<option selected value=0>Pas de joueurs</option>
										</c:if>
										<c:if test="${listeAutresJoueurs.size() > 0}">
											<option selected value=0>Choisir un joueur</option>
											<c:forEach items="${listeAutresJoueurs}" var="joueur" varStatus="status">
												<option value="${joueur.id}"><c:out value="${joueur.nickname}" /></option>
											</c:forEach>
										</c:if>
									</select>
									<button type="submit" class="btn btn-primary">Ajouter</button>
								</div>
							</form>
						</c:if>
					</c:if>
					<c:if test="${playersList.size() >= contestPlayersInfo.game.min_players}">
						<c:if test="${empty contestPlayersInfo.winner}">
							<h4 style="color:green;">La partie peut avoir lieu avec ces <c:out value="${playersList.size()}" /> joueurs !</h4>
							<form id="winnerPlayer" method="post" action="contests">
								<div class="form-group">
									<input type="text" class="form-control" id="idContestWin" name="idContestWin" style="display:none;">
									<label for="isWinner">Qui a remporté la partie ?</label>
									<select class="form-select" aria-label="Default select example"
										name="isWinner" id="isWinner">
										<option selected value=0>Le gagnant est...</option>
										<c:forEach items="${playersList}" var="joueur" varStatus="status">
											<option value="${joueur.id}"><c:out value="${joueur.nickname}" /></option>
										</c:forEach>
									</select>
									<button type="submit" class="btn btn-primary">Enregistrer le vainqueur</button>
								</div>
							</form>
						</c:if>
						<c:if test="${not empty contestPlayersInfo.winner}">
							<h4 style="color:orange;"><c:out value="${contestPlayersInfo.winner.nickname}" /> a remporté la partie !</h4>
						</c:if>
					</c:if>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Fermer</button>
				</div>
			</div>
		</div>
	</div>
</section>

<c:if test="${not empty matchToUpdate}">
	<script type="text/javascript">
		$(window).on('load', function() {
			$('#idUpdate').val("${matchToUpdate.id}");
			$('#gameIDUpdate').val("${matchToUpdate.game.id}").change();
			$('#start_dateUpdate').val("${matchToUpdate.start_date}");
			$('#updateModal').modal('show');
		});
	</script>
</c:if>

<c:if test="${not empty contestPlayersInfo}">
	<script type="text/javascript">
		$(window).on('load', function() {
			$('#idContest').val("${contestID}");
			$('#idContestWin').val("${contestID}");
			$('#playersModal').modal('show');
		});
	</script>
</c:if>

<c:if test="${not empty playersList}">
	<script type="text/javascript">
		$(window).on('load', function() {
			$('#idContest').val("${contestID}");
			$('#idContestWin').val("${contestID}");
			$('#playersModal').modal('show');
		});
	</script>
</c:if>