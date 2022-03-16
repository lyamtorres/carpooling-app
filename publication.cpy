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
           ACCEPT fa_lieudepart
           DISPLAY " "

           DISPLAY "Veuillez saisir votre point d'arrivée."
           ACCEPT fa_lieudarrive
           DISPLAY " "

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
           MOVE 4 TO fa_code
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
