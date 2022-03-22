       PUBLIER_ANNONCE.
           DISPLAY '|| PUBLIER UNE NOUVELLE ANNONCE ||'
           DISPLAY ' '
           ACCEPT SYS-DATE6 FROM DATE
           *> saisie date de départ
           DISPLAY "Vous allez d'abord saisir la date de départ."
           DISPLAY " "
           SET w_annee TO AA
           PERFORM WITH TEST AFTER UNTIL w_mois >= MM
               DISPLAY "Veuillez saisir le mois souhaité."
               DISPLAY "(entre 1 et 12)"
               ACCEPT w_mois
               DISPLAY " "
           END-PERFORM
           PERFORM WITH TEST AFTER UNTIL w_jour >= JJ
               DISPLAY "Maintenant, veuillez saisir le jour."
               DISPLAY "(entre 1 et 31)"
               ACCEPT w_jour
               DISPLAY " "
           END-PERFORM
           *> saisie point de départ et d'arrivée
           DISPLAY "Veuillez saisir votre point de départ."
           ACCEPT w_lieu_depart
           DISPLAY " "
           DISPLAY "Veuillez saisir votre point d'arrivée."
           ACCEPT w_lieu_darrive
           DISPLAY " "
           *>  saisie lieu de rendez-vous
           DISPLAY "Veuillez saisir un lieu de rendez-vous"
           ACCEPT w_lieu_rdv
           DISPLAY " "
           *>  saisie nombre de voyageurs
           PERFORM WITH TEST AFTER UNTIL w_place_max >= 1 AND
           w_place_max <= 4
               DISPLAY "Veuillez saisir le nombre de voyageurs."
               DISPLAY "(1 à 4)"
               ACCEPT w_place_max
               DISPLAY " "
           END-PERFORM
           *>  saisie prix du voyage
           PERFORM WITH TEST AFTER UNTIL w_prix >= 5
               DISPLAY "Veuillez saisir le prix du voyage."
               DISPLAY "(5 ou plus)"
               ACCEPT w_prix
               DISPLAY " "
           END-PERFORM
           *>  ajout de l'annonce
           *>  note : il faut augmenter fa_code de 1 à chaque exécution
           MOVE 7 TO w_code
           MOVE "Guest" TO w_conducteur
            MOVE w_annonce TO tamp_fannonce
           OPEN I-O fannonce
               WRITE tamp_fannonce
               INVALID KEY
                   DISPLAY "Impossible d'ajouter."
                   DISPLAY " "
               NOT INVALID KEY
                   DISPLAY "Ajout effectué."
                   DISPLAY " "
               END-WRITE
           CLOSE fannonce.

       SUPPRIMER_ANNONCE.
           DISPLAY "|| SUPPRIMER UNE ANNNONCE ||"
           DISPLAY " "

           *> affichage d'annonces en cours
           PERFORM AFFICHER_ANNONCE

           DISPLAY "Veuillez saisir le code de l'annonce à supprimer."
           ACCEPT w_code
           DISPLAY " "

           *> supprimer l'annnonce selectionne
           OPEN I-O fannonce
           MOVE w_code TO fa_code

           READ fannonce
           INVALID KEY
               DISPLAY "Cet identifiant n'existe pas."
               DISPLAY " "
           NOT INVALID KEY
               DELETE fannonce RECORD
               DISPLAY "Votre annonce a été supprimée."
               DISPLAY " "
           END-READ

           CLOSE fannonce.

           *> TO-DO : afficher uniquement les annonces d'un seul user

       AFFICHER_ANNONCE.
           DISPLAY "Voici la liste d'annonces en cours :"
           DISPLAY " "
           OPEN INPUT fannonce
           MOVE 1 TO Wfin

           PERFORM WITH TEST AFTER UNTIL Wfin = 0
           READ fannonce NEXT
           AT END MOVE 0 TO Wfin
           NOT AT END
               DISPLAY "Code : " fa_code
               DISPLAY "Prix : " fa_prix
               DISPLAY "Places : " fa_place_max
               DISPLAY "Départ : " fa_lieu_depart
               DISPLAY "Arrivée : " fa_lieu_darrive
               DISPLAY "Rendez-vous : " fa_lieu_rdv
               DISPLAY "Conducteur : " fa_conducteur
               DISPLAY "Date de départ : " fa_date_depart
               DISPLAY " "
           END-READ
           END-PERFORM

           CLOSE fannonce.
