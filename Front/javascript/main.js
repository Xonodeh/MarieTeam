document.addEventListener('DOMContentLoaded', function () {
    // Chargement des secteurs
    fetch('../Back/scripts/getTraversees.php?action=getSecteurs')
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
        fetch(`../Back/scripts/getTraversees.php?action=getLiaisonsBySecteur&secteurId=${secteurId}`)
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
    fetch('../Back/scripts/getTraversees.php?action=getLiaisons')
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

        fetch(`../Back/scripts/getTraversees.php?action=getTraversees&liaison=${liaison}&date=${date}`)
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
        fetch(`../Back/scripts/getTarif.php?idTraversee=${idTraversee}`)
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

            fetch('../Back/scripts/reservation.php', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(donnees)
            })
            .then(r => r.json())
            .then(rep => {
                if(rep.success){
                    showConfirmationModal(donnees)
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

    function showConfirmationModal(donnees) {
        let recap = `
            <div class="confirmation-content">
                <h3>Réservation Confirmée</h3>
                <p><strong>Nom :</strong> ${donnees.nomClient}</p>
                <p><strong>Adresse :</strong> ${donnees.adresseClient}, ${donnees.cpClient} ${donnees.villeClient}</p>
                <h4>Détails :</h4>
                <ul>
        `;
    
        // Récupérer les tarifs pour afficher le nom du type et le prix
        fetch(`../Back/scripts/getTarif.php?idTraversee=${donnees.idTraversee}`)
            .then(response => response.json())
            .then(tarifs => {
                let total = 0;
                for (const idType in donnees.types) {
                    const tarif = tarifs.find(tarif => tarif.IDType == idType); // Trouver le tarif correspondant
                    const typeName = tarif ? tarif.LibelleType || tarif.TypePassager || tarif.TypeVehicule : `Type ${idType}`;
                    const price = tarif ? parseFloat(tarif.Prix) : 0;
                    const quantity = donnees.types[idType];
    
                    recap += `<li>${quantity} billet(s) pour le type ${typeName} (${price}€)</li>`;
                    total += quantity * price; // Calcul du total
                }
    
                recap += `
                    </ul>
                    <p><strong>Total payé :</strong> ${total.toFixed(2)} €</p>
                    <div style="text-align:right;">
                        <button onclick="location.reload();">Fermer</button>
                    </div>
                </div>
                `;
    
                // Affichage de la popup de confirmation
                document.getElementById('confirmation-modal').innerHTML = recap;
                document.getElementById('confirmation-overlay').style.display = 'flex';
            })
            .catch(error => {
                alert('Erreur lors du chargement des tarifs');
            });
            function closeConfirmationModal(){
                document.getElementById('confirmation-overlay').style.display = 'none';
                document.getElementById('confirmation-modal').innerHTML = '';
            }
        }});