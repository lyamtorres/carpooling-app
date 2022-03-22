           DISPLAY "|| SUPPRIMER UNE ANNNONCE ||"
           DISPLAY " "

           *> affichage d'annonces en cours
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
               DISPLAY "Départ : " fa_lieudepart
               DISPLAY "Arrivée : " fa_lieudarrive
               DISPLAY "Rendez-vous : " fa_lieu_rdv
               DISPLAY "Conducteur : " fa_conducteur
               DISPLAY "Date de départ : " fa_date_depart
               DISPLAY " "
           END-READ
           END-PERFORM

           CLOSE fannonce.

           DISPLAY "Veuillez saisir le code de l'annonce à supprimer."
           ACCEPT wcode
           DISPLAY " "

           *> supprimer l'annnonce selectionne
           OPEN I-O fannonce
           MOVE wcode TO fa_code

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
