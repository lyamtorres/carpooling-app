       AFFICHER_OPTIONS_ANNONCES.
           PERFORM WITH TEST AFTER UNTIL w_opt >= 1 AND w_opt <= 5
               DISPLAY "|| GESTION DES ANNONCES ||"
               DISPLAY " "
               DISPLAY "Veuillez saisir le numéro de l'option souhaité."
               DISPLAY "1.Publier une annonce"
               DISPLAY "2.Modifier une annonce"
               DISPLAY "3.Supprimer une annonce"
               DISPLAY "4.Afficher toutes les annonces"
               DISPLAY "5.Sortir"
               ACCEPT w_opt
           END-PERFORM

           EVALUATE w_opt
           WHEN 1
                PERFORM PUBLIER_ANNONCE
           WHEN 2
                PERFORM MODIFIER_ANNONCE
           WHEN 3
                PERFORM SUPPRIMER_ANNONCE
           WHEN 4
               PERFORM AFFICHER_ANNONCES
           WHEN 5
               DISPLAY "À bientôt !"
           END-EVALUATE.

       PUBLIER_ANNONCE.
           DISPLAY '|| PUBLIER UNE NOUVELLE ANNONCE ||'
           DISPLAY ' '
           ACCEPT SYS-DATE6 FROM DATE
           *> saisie date de départ
           DISPLAY "Vous allez d'abord saisir la date de départ."
           DISPLAY "ATTENTION ! Vous pouvez uniquement publier des"
           DISPLAY "annonces pour l'année en cours."
           DISPLAY " "
           SET w_annee TO AA
           PERFORM WITH TEST AFTER UNTIL w_mois >= MM AND w_mois <= 12
               DISPLAY "Veuillez saisir le mois souhaité."
               DISPLAY "(entre " MM " et 12)"
               ACCEPT w_mois
               DISPLAY " "
           END-PERFORM
           IF w_mois = 1 OR w_mois = 3 OR w_mois = 5 OR
              w_mois = 7 OR w_mois = 8 OR w_mois = 10 OR
              w_mois = 12 THEN
               SET w_dernier_jour TO 31
           ELSE IF w_mois = 4 OR w_mois = 6 OR w_mois = 9 OR
                   w_mois = 11
               SET w_dernier_jour TO 30
           ELSE
               SET w_dernier_jour TO 28
           END-IF
           IF w_mois = MM THEN
               SET w_premier_jour TO JJ
           ELSE
               SET w_premier_jour TO 1
           END-IF
           PERFORM WITH TEST AFTER UNTIL w_jour >= w_premier_jour
               AND w_jour <= w_dernier_jour
               DISPLAY "Maintenant, veuillez saisir le jour."
               DISPLAY "(entre " w_premier_jour "et " w_dernier_jour ")"
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
           DISPLAY "Veuillez saisir un lieu de rendez-vous."
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
           MOVE 1 TO w_code
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

           *> TO-DO : trouver le problème avec le mois en cours

       MODIFIER_ANNONCE.
           DISPLAY "|| MODIFIER UNE ANNONCE ||"
           DISPLAY " "

           PERFORM AFFICHER_ANNONCES

           DISPLAY "Veuillez saisir le code de l'annonce à modifier."
           ACCEPT w_code
           DISPLAY " "

           OPEN I-O fannonce
           MOVE w_code TO fa_code

           READ fannonce
           INVALID KEY
               DISPLAY "Cet identifiant n'existe pas."
               DISPLAY " "
           NOT INVALID KEY

           *> instructions pour modifier le tampon
           DISPLAY "Voulez-vous changer la date de départ ? (O/N)"
           ACCEPT w_rep
           DISPLAY " "
           IF w_rep = 'o' OR w_rep = 'O' THEN
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
           END-IF

           DISPLAY "Voulez-vous changer le point de départ ? (O/N)"
           ACCEPT w_rep
           DISPLAY " "
           IF w_rep = 'o' OR w_rep = 'O' THEN
               DISPLAY "Veuillez saisir votre point de départ."
               ACCEPT w_lieu_depart
               DISPLAY " "
           END-IF

           DISPLAY "Voulez-vous changer le point d'arrivée ? (O/N)"
           ACCEPT w_rep
           DISPLAY " "
           IF w_rep = 'o' OR w_rep = 'O' THEN
               DISPLAY "Veuillez saisir votre point d'arrivée."
               ACCEPT w_lieu_darrive
               DISPLAY " "
           END-IF

           DISPLAY "Voulez-vous changer le lieu de rendez-vous ? (O/N)"
           ACCEPT w_rep
           DISPLAY " "
           IF w_rep = 'o' OR w_rep = 'O' THEN
               DISPLAY "Veuillez saisir un lieu de rendez-vous."
               ACCEPT w_lieu_rdv
               DISPLAY " "
           END-IF

           DISPLAY "Voulez-vous changer le nombre de voyageurs ? (O/N)"
           ACCEPT w_rep
           DISPLAY " "
           IF w_rep = 'o' OR w_rep = 'O' THEN
               PERFORM WITH TEST AFTER UNTIL w_place_max >= 1 AND
               w_place_max <= 4
                   DISPLAY "Veuillez saisir le nombre de voyageurs."
                   DISPLAY "(1 à 4)"
                   ACCEPT w_place_max
                   DISPLAY " "
               END-PERFORM
           END-IF

           DISPLAY "Voulez-vous changer le prix du voyage ? (O/N)"
           ACCEPT w_rep
           DISPLAY " "
           IF w_rep = 'o' OR w_rep = 'O' THEN
               PERFORM WITH TEST AFTER UNTIL w_prix >= 5
                   DISPLAY "Veuillez saisir le prix du voyage."
                   DISPLAY "(5 ou plus)"
                   ACCEPT w_prix
                   DISPLAY " "
               END-PERFORM
           END-IF
               MOVE w_annonce TO tamp_fannonce
               REWRITE tamp_fannonce
               DISPLAY "Votre annonce a été modifiée."
               DISPLAY " "
           END-READ

           CLOSE fannonce.

           *> TO-DO : sauvegarder les infos qui ne sont pas modifiés

       SUPPRIMER_ANNONCE.
           DISPLAY "|| SUPPRIMER UNE ANNNONCE ||"
           DISPLAY " "

           PERFORM AFFICHER_ANNONCES

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

       AFFICHER_ANNONCES.
           DISPLAY "Voici la liste d'annonces en cours :"
           DISPLAY " "
           OPEN INPUT fannonce
           MOVE 2 TO Wfin

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
