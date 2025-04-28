document.addEventListener('DOMContentLoaded', function () {
    // Chargement des secteurs
    fetch('/projets/MARIETEAM/Back/scripts/getTraversees.php?action=getSecteurs')
        .then(response => response.json())
        .then(data => {
            const secteursList = document.getElementById('secteurs');
            data.forEach(secteur => {
                const listItem = document.createElement('li');
                const button = document.createElement('button');
                button.textContent = secteur.LibSecteur;
                button.className = 'sector-button';
                button.dataset.id = secteur.IDSecteur;
                button.addEventListener('click', function () {
                    afficherLiaisons(secteur.IDSecteur);
                });
                listItem.appendChild(button);
                secteursList.appendChild(listItem);
            });
        });

    // Affichage dynamique des liaisons selon secteur
    function afficherLiaisons(secteurId) {
        fetch(`/projets/MARIETEAM/Back/scripts/getTraversees.php?action=getLiaisonsBySecteur&secteurId=${secteurId}`)
            .then(response => response.json())
            .then(data => {
                const liaisonSelect = document.getElementById('liaison');
                liaisonSelect.innerHTML = '';
                data.forEach(liaison => {
                    const option = document.createElement('option');
                    option.value = liaison.IDLiaison;
                    option.textContent = `${liaison.port_depart} - ${liaison.port_arrivee}`;
                    liaisonSelect.appendChild(option);
                });
            });
    }

    // Chargement initial des liaisons
    fetch('/projets/MARIETEAM/Back/scripts/getTraversees.php?action=getLiaisons')
        .then(response => response.json())
        .then(data => {
            const liaisonSelect = document.getElementById('liaison');
            data.forEach(liaison => {
                const option = document.createElement('option');
                option.value = liaison.IDLiaison;
                option.textContent = `${liaison.port_depart} - ${liaison.port_arrivee}`;
                liaisonSelect.appendChild(option);
            });
        });

    // Afficher les traversées
    document.getElementById('reservationForm').addEventListener('submit', function (event) {
        event.preventDefault();
        const liaison = document.getElementById('liaison').value;
        const date = document.getElementById('date').value;

        fetch(`/projets/MARIETEAM/Back/scripts/getTraversees.php?action=getTraversees&liaison=${liaison}&date=${date}`)
            .then(response => response.text())
            .then(html => {
                document.getElementById('result').innerHTML = html;
                // Ajouter l'écouteur sur chaque bouton "Réserver"
                document.querySelectorAll('.reserve-btn').forEach(button => {
                    button.addEventListener('click', function () {
                        const idTraversee = this.dataset.id;
                        openReservationModal(idTraversee);
                    });
                });
            });
    });

    // Ouvre le modal de réservation
    function openReservationModal(idTraversee) {
        fetch(`/projets/MARIETEAM/Back/scripts/getTarif.php?idTraversee=${idTraversee}`)
            .then(response => response.json())
            .then(tarifs => {
                if (!Array.isArray(tarifs) || tarifs.length === 0) {
                    alert('Aucun tarif disponible pour cette traversée.');
                    return;
                }
                let html = `
                    <button class="close-x" type="button" title="Fermer">&times;</button>
                    <h3>Réserver - Traversée ${idTraversee}</h3>
                    <form id="form-resa" data-id="${idTraversee}">
                `;
                tarifs.forEach(tarif => {
                    html += `
                        <div class="type-ligne">
                            <label>${tarif.LibelleType || tarif.TypePassager || tarif.TypeVehicule} <small>(${tarif.Prix}€)</small></label>
                            <input type="number" min="0" max="99" name="type_${tarif.IDType}" value="0">
                        </div>
                    `;
                });
                html += `
                    <div class="total-box">Total : <span id="total-prix">0.00</span> €</div>
                    <hr>
                    <label>Nom :</label>
                    <input type="text" name="nomClient" required autocomplete="name">
                    <label>Adresse :</label>
                    <input type="text" name="adresseClient" required>
                    <label>Code postal :</label>
                    <input type="text" name="cpClient" required>
                    <label>Ville :</label>
                    <input type="text" name="villeClient" required>
                    <div style="text-align:right">
                      <button type="submit">Confirmer</button>
                    </div>
                    </form>
                `;
                document.getElementById('resa-modal').innerHTML = html;
                document.getElementById('resa-overlay').style.display = 'flex';

                // Calcul du total dynamique
                document.querySelectorAll('#form-resa input[type="number"]').forEach(input => {
                    input.addEventListener('input', function() {
                        let total = 0;
                        tarifs.forEach(tarif => {
                            let val = parseInt(document.querySelector(`#form-resa input[name="type_${tarif.IDType}"]`).value) || 0;
                            total += val * parseFloat(tarif.Prix);
                        });
                        document.getElementById('total-prix').textContent = total.toFixed(2);
                    });
                });

                // Fermer modal par X
                document.querySelector('#resa-modal .close-x').onclick = closeResaModal;
            })
            .catch(error => {
                alert('Erreur lors du chargement des tarifs');
            });
    }

    // Gestion de l'envoi du formulaire de réservation dans le modal
    document.addEventListener('submit', function(e){
        if(e.target && e.target.id === 'form-resa'){
            e.preventDefault();
            const form = e.target;
            const idTraversee = form.dataset.id;
            let donnees = {
                idTraversee: idTraversee,
                nomClient: form.nomClient.value,
                adresseClient: form.adresseClient.value,
                cpClient: form.cpClient.value,
                villeClient: form.villeClient.value,
                types: {}
            };
            form.querySelectorAll('input[type="number"]').forEach(input => {
                let val = parseInt(input.value) || 0;
                if(val > 0) {
                    let idType = input.name.split('_')[1];
                    donnees.types[idType] = val;
                }
            });

            fetch('/projets/MARIETEAM/Back/scripts/reservation.php', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(donnees)
            })
            .then(r => r.json())
            .then(rep => {
                if(rep.success){
                    alert("Réservation réussie !");
                    closeResaModal();
                } else {
                    alert(rep.error || "Erreur");
                }
            });
        }
    });

    // Fermer le modal si clic hors
    document.getElementById('resa-overlay').addEventListener('click', function(e){
        if(e.target === this) closeResaModal();
    });
    function closeResaModal(){
        document.getElementById('resa-overlay').style.display = 'none';
        document.getElementById('resa-modal').innerHTML = '';
    }
});
