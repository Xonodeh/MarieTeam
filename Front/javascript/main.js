document.addEventListener('DOMContentLoaded', function () {
    fetch('../../Back/scripts/getTraversees.php?action=getLiaisons')
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

        fetch(`../../Back/scripts/getTraversees.php?action=getTraversées&liaison=${liaison}&date=${date}`)
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
    
        fetch('reservation.php', {
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
});