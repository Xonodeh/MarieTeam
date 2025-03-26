document.addEventListener('DOMContentLoaded', function () {
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


    document.getElementById('reservationForm').addEventListener('submit', function (event) {
        event.preventDefault();

        const liaison = document.getElementById('liaison').value;
        const date = document.getElementById('date').value;

        fetch(`/projets/MARIETEAM/Back/scripts/getTraversees.php?action=getTraversees&liaison=${liaison}&date=${date}`)
            .then(response => response.text())
            .then(html => {
                document.getElementById('result').innerHTML = html;

            
                document.querySelectorAll('.reserve-button').forEach(button => {
                    button.addEventListener('click', function () {
                        const idTraversee = this.dataset.id;
                        document.getElementById('reservationSection').style.display = 'block';
                        document.getElementById('confirmReservation').dataset.idTraversee = idTraversee;
                    });
                });
            });
    });

    document.getElementById('confirmReservation').addEventListener('click', function () {
        const nomClient = document.getElementById('nomClient').value;
        const adresseClient = document.getElementById('adresseClient').value;
        const cpClient = document.getElementById('cpClient').value;
        const villeClient = document.getElementById('villeClient').value;
        const idTraversee = this.dataset.idTraversee;
    
        fetch('/projets/MARIETEAM/Back/scripts/reservation.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                nomClient,
                adresseClient,
                cpClient,
                villeClient,
                idTraversee,
            }),
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Réservation effectuée avec succès !');
                    document.getElementById('reservationSection').style.display = 'none';
                } else if (data.redirect) {
                    alert(data.error);
                    window.location.href = data.redirect;
                } else {
                    alert(`Erreur : ${data.error}`);
                }
            })
            .catch(error => console.error('Erreur lors de la réservation :', error));
    });

    // modif en dessous 

    fetch('/projets/MARIETEAM/Back/scripts/getTraversees.php?action=getSecteurs')
    .then(response => {
        console.log('Réponse reçue :', response.status); // Vérifie le statut HTTP
        return response.json();
    })
    .then(data => {
        console.log('Données reçues :', data); // Affiche les données JSON reçues

        const secteursList = document.getElementById('secteurs');
        if (!secteursList) {
            console.error("Élément <ul> avec ID 'secteurs' introuvable !");
            return;
        }

        data.forEach(secteur => {
            const listItem = document.createElement('li'); // Crée un élément de liste
            const button = document.createElement('button'); // Crée un bouton
            button.textContent = secteur.LibSecteur; // Texte du bouton
            console.log('Libelle du secteur:', secteur.LibSecteur);
            button.className = 'sector-button'; // Applique la classe CSS
            button.dataset.id = secteur.IDSecteur; // Ajoute l'ID du secteur comme attribut

            // Ajouter un événement au clic sur le bouton
            button.addEventListener('click', function () {
                console.log(`Secteur sélectionné : ${secteur.LibSecteur}`);
                afficherLiaisons(secteur.IDSecteur); // Appelle une fonction pour afficher les liaisons liées
            });

            listItem.appendChild(button); // Ajoute le bouton à l'élément de liste
            secteursList.appendChild(listItem); // Ajoute l'élément de liste à la barre latérale
        });
    })
    .catch(error => console.error('Erreur lors de la récupération des secteurs :', error));

    // Fonction pour afficher les liaisons liées à un secteur
    function afficherLiaisons(secteurId) {
        console.log(`Récupération des liaisons pour le secteur ID : ${secteurId}`);
        fetch(`/projets/MARIETEAM/Back/scripts/getTraversees.php?action=getLiaisonsBySecteur&secteurId=${secteurId}`)
            .then(response => response.json())
            .then(data => {
                console.log('Données reçues pour les liaisons :', data);
    
                const liaisonSelect = document.getElementById('liaison');
                if (!liaisonSelect) {
                    console.error("Élément <select> avec ID 'liaisons' introuvable !");
                    return;
                }
    
                liaisonSelect.innerHTML = ''; // Vider les options existantes
                data.forEach(liaison => {
                    const option = document.createElement('option');
                    option.value = liaison.IDLiaison;
                    option.textContent = `${liaison.port_depart} - ${liaison.port_arrivee}`;
                    liaisonSelect.appendChild(option);
                });
            })
            .catch(error => console.error('Erreur lors de la récupération des liaisons:', error));
    }

});

function loadTarifs(idTraversee) {
    fetch(`projets/MARIETEAM/Back/scripts/getTarifs.php?idTraversee=${idTraversee}`)
        .then(response => response.json())
        .then(data => {
            const reservationSection = document.getElementById('reservationSection');
            reservationSection.innerHTML = `
                <h3>Réserver cette traversée</h3>
                <table class="tarifs-table">
                    <thead>
                        <tr>
                            <th>Catégorie</th>
                            <th>Tarif (€)</th>
                            <th>Quantité</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${data.map(row => `
                            <tr>
                                <td>${row.TypePassager || row.TypeVehicule}</td>
                                <td>${row.Prix}</td>
                                <td>${row.NbPassager || row.NbVehicule || 0}</td>
                            </tr>`).join('')}
                    </tbody>
                </table>

                <form id="reservationDetailsForm">
                    <label for="nomClient">Nom du client :</label>
                    <input type="text" id="nomClient" name="nomClient" required>

                    <label for="adresseClient">Adresse :</label>
                    <input type="text" id="adresseClient" name="adresseClient" required>

                    <label for="cpClient">Code postal :</label>
                    <input type="text" id="cpClient" name="cpClient" required>

                    <label for="villeClient">Ville :</label>
                    <input type="text" id="villeClient" name="villeClient" required>

                    <button type="button" id="confirmReservation">Confirmer la réservation</button>
                </form>
            `;
            reservationSection.style.display = 'block';
        })
        .catch(error => {
            console.error('Erreur:', error);
            alert('Erreur lors du chargement des tarifs');
        });
}

// Appelle loadTarifs lorsque le bouton "Réserver" est cliqué
document.addEventListener('click', function(event) {
    if (event.target.classList.contains('reserve-button')) {
        const idTraversee = event.target.getAttribute('data-id');
        loadTarifs(idTraversee);
    }
});
