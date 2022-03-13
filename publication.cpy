       *>  saisie date de départ
           DISPLAY '|| PUBLIER UNE NOUVELLE ANNONCE ||'
           DISPLAY ' '
           ACCEPT SYS-DATE6 FROM DATE

           DISPLAY 'Vous allez renseigner dans un premier temps la date'
           DISPLAY 'de départ.'
           DISPLAY ' '

           SET fa_annee TO AA

           PERFORM WITH TEST AFTER UNTIL fa_mois >= MM
               DISPLAY "Veuillez saisir le mois souhaité"
               DISPLAY "(entre 1 et 12)"
               ACCEPT fa_mois
           END-PERFORM

           PERFORM WITH TEST AFTER UNTIL fa_jour >= JJ
               DISPLAY "Maintenant, veuillez saisir le jour"
               DISPLAY "(entre 1 et 31)"
               ACCEPT fa_jour
           END-PERFORM

       *>  saisie point de départ et arrivée
       *>  PERFORM WITH TEST AFTER UNTIL fa_lieudepart > 1
               DISPLAY "Veuillez saisir votre point de départ."
               ACCEPT fa_lieudepart
               DISPLAY "Veuillez saisir votre point d'arrivée."
               ACCEPT fa_lieudarrive
       *>  END-PERFORM

       *>  saisie lieu de rendez-vous
           DISPLAY "Veuillez saisir un lieu de rendez-vous"
           ACCEPT fa_lieu_rdv

       *>  saisie nombre de voyageurs
           PERFORM WITH TEST AFTER UNTIL fa_place_max >= 1 AND
           fa_place_max <= 4
               DISPLAY "Veuillez saisir le nombre de voyageurs."
               DISPLAY "(1 à 4)"
               ACCEPT fa_place_max
           END-PERFORM

       *>  saisie prix du voyage
           PERFORM WITH TEST AFTER UNTIL fa_prix >= 5
               DISPLAY "Veuillez saisir le prix du voyage."
               DISPLAY "(5 ou plus)"
               ACCEPT fa_prix
           END-PERFORM

       *>  ecrire dans fannonce
