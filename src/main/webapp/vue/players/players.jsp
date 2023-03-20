<section>
	<h1>PAGE DES JOUEURS</h1>
	
	<c:if test="${not empty playerToUpdate}">
		<script type="text/javascript">
		    $(window).on('load', function() {
		        $('#idUpdate').val("${playerToUpdate.id}");
		        $('#emailUpdate').val("${playerToUpdate.email}");
		        $('#nicknameUpdate').val("${playerToUpdate.nickname}");
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

	<h4>Pour rappel, voici la liste des joueurs</h4>
	<c:if test="${listeJoueurs.size() > 0}">
		<table class="table">
			<colgroup>
				<col span="1" style="width: 5%;">
				<col span="1" style="width: 42.5%;">
				<col span="1" style="width: 42.5%;">
				<col span="1" style="width: 5%;">
				<col span="1" style="width: 5%;">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">ID</th>
					<th scope="col">Email du joueur</th>
					<th scope="col">Pseudo du joueur</th>
					<th scope="col">Mod</th>
					<th scope="col">Sup</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${listeJoueurs}" var="joueur"
					varStatus="status">
					<tr>
						<td><c:out value="${joueur.id}"/></td>
						<td><c:out value="${joueur.email}"/></td>
						<td><c:out value="${joueur.nickname}"/></td>
						<td><a href="?id=${joueur.id}&act=update" type="button" class="editBtn"><i class="fa-solid fa-user-pen"></i></a></td>
						<td><a href="?id=${joueur.id}&act=delete" class="deleteBtn"><i class="fa-solid fa-user-xmark"></i></a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
	<c:if test="${listeJoueurs.size() == 0}">
		<h2>Pas de joueurs dans la base</h2>
	</c:if>
	
	<hr>

	<div class="addForm">
		<h4>Ajouter un joueur</h4>

		<form id="newItem" method="post" action="players">
			<div class="form-group">
				<label for="email">Email</label> 
				<input type="email" class="form-control" id="email" name="email" placeholder="Entrez un email">
			</div>
			<div class="form-group">
				<label for="nickname">Pseudo</label>
				<input type="text" class="form-control" id="nickname" name="nickname" placeholder="Entrez un pseudo">
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
					<form id="updateItem" method="post" action="players">
						<div class="form-group">
							<label for="idUpdate">ID</label> <input type="text"
								class="form-control" id="idUpdate" name="idUpdate" readonly>
						</div>
						<div class="form-group">
							<label for="emailUpdate">Email</label>
							<input type="text" class="form-control" id="emailUpdate" name="emailUpdate">
						</div>
						<div class="form-group">
							<label for="nicknameUpdate">Pseudo</label>
							<input type="text" class="form-control" id="nicknameUpdate" name="nicknameUpdate">
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