<section>
	<h1>PAGE DES JEUX</h1>
	
	<c:if test="${not empty gameToUpdate}">
		<script type="text/javascript">
		    $(window).on('load', function() {
		        $('#idUpdate').val("${gameToUpdate.id}");
		        $('#titleUpdate').val("${gameToUpdate.title}");
		        $('#min_playersUpdate').val("${gameToUpdate.min_players}");
		        $('#max_playersUpdate').val("${gameToUpdate.max_players}");
		        $('#updateModal').modal('show');
		    });
		</script>
	</c:if>

	<c:if test="${not empty message}">
		<c:choose>
			<c:when test="${fn:contains(message, 'Erreur')}">
				<div class="messageToUser errorMessage">
					<c:out value="${message}"/>
				</div>
			</c:when>
			<c:otherwise>
				<div class="messageToUser">
					<c:out value="${message}"/>
				</div>
			</c:otherwise>
		</c:choose>
	</c:if>

	<h4>Pour rappel, voici la liste des jeux</h4>
	<c:if test="${listeJeux.size() > 0}">
		<table class="table">
			<colgroup>
				<col span="1" style="width: 5%;">
				<col span="1" style="width: 55%;">
				<col span="1" style="width: 15%;">
				<col span="1" style="width: 15%;">
				<col span="1" style="width: 5%;">
				<col span="1" style="width: 5%;">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">ID</th>
					<th scope="col">Nom du jeu</th>
					<th scope="col">Joueurs</th>
					<th scope="col">Mod</th>
					<th scope="col">Sup</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${listeJeux}" var="jeu"
					varStatus="status">
					<tr>
						<td><c:out value="${jeu.id}"/></td>
						<td><c:out value="${jeu.title}"/></td>
						<td><c:out value="${jeu.min_players}"/>-<c:out value="${jeu.max_players}"/> <i class="fa-solid fa-user"></i></td>
						<td><a href="?id=${jeu.id}&act=update" type="button" class="editBtn"><i class="fa-solid fa-pen-to-square"></i></a></td>
						<td><a href="?id=${jeu.id}&act=delete" class="deleteBtn"><i class="fa-solid fa-trash-can"></i></a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
	<c:if test="${listeJeux.size() == 0}">
		<h2>Pas de jeu dans la base</h2>
	</c:if>
	
	<hr>

	<div class="addForm">
		<h4>Ajouter un jeu</h4>

		<form id="newItem" method="post" action="games">
			<div class="form-group">
				<label for="title">Titre</label> 
				<input type="text" class="form-control" id="title" name="title" placeholder="Entrez un titre">
			</div>
			<div class="form-group">
				<label for="min_players">Nb. Joueurs (min.)</label>
				<input type="number" class="form-control" id="min_players" name="min_players" placeholder="Entrez un nombre de joueurs minimum" value=0>
			</div>
			<div class="form-group">
				<label for="max_players">Nb. Joueurs (max.)</label>
				<input type="number" class="form-control" id="max_players" name="max_players" placeholder="Entrez un nombre de joueurs maximum" value=0>
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
					<form id="updateItem" method="post" action="games">
						<div class="form-group">
							<label for="idUpdate">ID</label> <input type="text"
								class="form-control" id="idUpdate" name="idUpdate" readonly>
						</div>
						<div class="form-group">
							<label for="titleUpdate">Titre</label>
							<input type="text" class="form-control" id="titleUpdate" name="titleUpdate">
						</div>
						<div class="form-group">
							<label for="min_playersUpdate">Nb. Joueurs (min.)</label>
							<input type="number" class="form-control" id="min_playersUpdate" name="min_playersUpdate">
						</div>
						<div class="form-group">
							<label for="max_playersUpdate">Nb. Joueurs (max.)</label>
							<input type="number" class="form-control" id="max_playersUpdate" name="max_playersUpdate">
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
</section>