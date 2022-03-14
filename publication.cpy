           DISPLAY '|| PUBLIER UNE NOUVELLE ANNONCE ||'
           DISPLAY ' '
           ACCEPT SYS-DATE6 FROM DATE

           *> saisie date de départ
           DISPLAY "Vous allez d'abord saisir la date de départ."
           DISPLAY " "

           SET fa_annee TO AA

           PERFORM WITH TEST AFTER UNTIL fa_mois >= MM
               DISPLAY "Veuillez saisir le mois souhaité."
               DISPLAY "(entre 1 et 12)"
               ACCEPT fa_mois
               DISPLAY " "
           END-PERFORM

           PERFORM WITH TEST AFTER UNTIL fa_jour >= JJ
               DISPLAY "Maintenant, veuillez saisir le jour."
               DISPLAY "(entre 1 et 31)"
               ACCEPT fa_jour
               DISPLAY " "
           END-PERFORM

           *> saisie point de départ et d'arrivée
           DISPLAY "Veuillez saisir votre point de départ."
           ACCEPT ftra_pointdepart
           DISPLAY " "

           DISPLAY "Veuillez saisir votre point d'arrivée."
           ACCEPT ftra_pointarrive
           DISPLAY " "

           *> vérification de l'existance du trajet
           OPEN INPUT ftrajet
           READ ftrajet
           INVALID KEY
               PERFORM WITH TEST AFTER UNTIL wreponse = 'O' OR
               wreponse = 'N' OR wreponse = 'o' OR wreponse = 'n'
                   DISPLAY "Ce trajet n'existe pas encore."
                   DISPLAY "Voulez-vous créer un nouveau trajet ? (O/N)"
                   ACCEPT wreponse
                   DISPLAY " "
               END-PERFORM
           NOT INVALID KEY
               DISPLAY "Le trajet existe."
               DISPLAY " "
           END-READ
           CLOSE ftrajet.

           *> ajout d'un nouveau trajet
           OPEN I-O ftrajet
           IF wreponse = 'O' OR wreponse = 'o'  THEN
               WRITE tamp_ftrajet
               INVALID KEY
                   DISPLAY "Impossible d'ajouter."
                   DISPLAY " "
               NOT INVALID KEY
                   DISPLAY "Ajout effectué."
                   DISPLAY " "
               END-WRITE
           ELSE
               DISPLAY "Le trajet ne sera pas ajouté."
               DISPLAY " "
           END-IF
           CLOSE ftrajet.

           *>  saisie lieu de rendez-vous
           DISPLAY "Veuillez saisir un lieu de rendez-vous"
           ACCEPT fa_lieu_rdv
           DISPLAY " "

           *>  saisie nombre de voyageurs
           PERFORM WITH TEST AFTER UNTIL fa_place_max >= 1 AND
           fa_place_max <= 4
               DISPLAY "Veuillez saisir le nombre de voyageurs."
               DISPLAY "(1 à 4)"
               ACCEPT fa_place_max
               DISPLAY " "
           END-PERFORM

           *>  saisie prix du voyage
           PERFORM WITH TEST AFTER UNTIL fa_prix >= 5
               DISPLAY "Veuillez saisir le prix du voyage."
               DISPLAY "(5 ou plus)"
               ACCEPT fa_prix
               DISPLAY " "
           END-PERFORM

       *>  ajout de l'annonce
       *>  note : il faut augmenter fa_code de 1 à chaque exécution
           MOVE 3 TO fa_code
           MOVE ftra_pointdepart TO fa_lieudepart
           MOVE ftra_pointarrive TO fa_lieudarrive
           MOVE "Guest" TO fa_conducteur

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
