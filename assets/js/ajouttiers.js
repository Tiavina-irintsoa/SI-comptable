
window.addEventListener("load", function () {
    console.log('hello');
    
    // Récupérer le formulaire
    var form = document.getElementById("formulaire");

    // Ajouter un événement de soumission
    form.addEventListener('submit', function(event) {
    // Empêcher la soumission du formulaire par défaut
    event.preventDefault();
    var errorHolder = document.getElementById('errorholder');
    while (errorHolder.firstChild) {
        errorHolder.removeChild(errorHolder.firstChild);
    }
    errorHolder.innerHTML="<h4 class='font-weight-bolder'>Ajouter un compte tiers</h4><p class='mb-0'>Entrez un compte et un libelle</p>";

    // Créer une nouvelle instance de XMLHttpRequest
    var xhr = new XMLHttpRequest();

    // Configurer la requête
    xhr.open('POST', form.action, true);


    // Ajouter une fonction de rappel pour gérer la réponse du serveur
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
            

        // Traiter la réponse du serveur ici
            var resp= xhr.responseText;
            
            console.log(resp);
            if(resp=='success'){
                const errorMessage = document.createElement('p');
                errorMessage.setAttribute('id', 'message');
                errorMessage.textContent = 'Tiers ajoute avec success';
                errorHolder.appendChild(errorMessage);
            }
            else if(resp=='exists not'){
                console.log("EXis");
                dialog();
            }
            else{
                const errorMessage = document.createElement('p');
                errorMessage.setAttribute('id', 'erreur');
                errorMessage.textContent = resp;
                errorHolder.appendChild(errorMessage);
            }
        }
    };

    // Envoyer les données du formulaire

    xhr.send(new FormData(form));
    });
function dialog() {
        var confirmBox = document.createElement('div');
    confirmBox.classList.add('confirm-box');
    var message = document.createElement('p');
    message.textContent = 'Ce compte n\' existe pas, voulez-vous le creer?';
    confirmBox.appendChild(message);
    
    // Create the confirm and cancel buttons
    var confirmButton = document.createElement('button');
    confirmButton.textContent = 'Oui';
    confirmButton.classList.add('confirm-button');
    confirmButton.onclick = function() {
        confirmBox.parentNode.removeChild(confirmBox);
        var input=document.getElementById('linkhidden');
        var inputnum=document.getElementById('numero');
        var link = input.value+'?numero='+inputnum.value;
        window.open(link, '_blank');
    };
    
    var cancelButton = document.createElement('button');
    cancelButton.textContent = 'Non';
    cancelButton.classList.add('cancel-button');
    cancelButton.onclick = function() {
        confirmBox.parentNode.removeChild(confirmBox);
    };
    var buttonWrapper = document.createElement('div');
    buttonWrapper.classList.add('button-wrapper');
    buttonWrapper.appendChild(confirmButton);
    buttonWrapper.appendChild(cancelButton);
    confirmBox.appendChild(buttonWrapper);
    confirmBox.style.opacity='inherit';
    document.body.appendChild(confirmBox);
    
    }
});