       AFFICHER_OPTIONS_ANNONCES.
           PERFORM WITH TEST AFTER UNTIL w_opt >= 1 AND w_opt <= 5
               DISPLAY "|| GESTION DES ANNONCES ||"
               DISPLAY " "
               DISPLAY "Veuillez saisir l'option souhaite."
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
               PERFORM AFFICHER_ANNONCES_BIS
           WHEN 5
               DISPLAY "A bientot !"
           END-EVALUATE.

           *> TO-DO : faire une recherche sur zone pour chaque user

       PUBLIER_ANNONCE.
           DISPLAY '|| PUBLIER UNE NOUVELLE ANNONCE ||'
           DISPLAY ' '
           ACCEPT SYS-DATE6 FROM DATE
           *> saisie date de depart
           DISPLAY "Vous allez d'abord saisir la date de depart."
           DISPLAY "ATTENTION ! Vous pouvez uniquement publier des"
           DISPLAY "annonces pour l'annee en cours."
           DISPLAY " "
           SET w_annee TO AA
           PERFORM WITH TEST AFTER UNTIL w_mois >= MM AND w_mois <= 12
               DISPLAY "Veuillez saisir le mois souhaite."
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
           DISPLAY "Veuillez saisir votre point de depart."
           ACCEPT w_lieu_depart
           DISPLAY " "
           DISPLAY "Veuillez saisir votre point d'arrivee."
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
               DISPLAY "(1 a 4)"
               ACCEPT w_place_max
               DISPLAY " "
           END-PERFORM
           *>  saisie prix du voyage
           PERFORM WITH TEST AFTER UNTIL w_prix_annonce >= 5
               DISPLAY "Veuillez saisir le prix du voyage."
               DISPLAY "(5 ou plus)"
               ACCEPT w_prix_annonce
               DISPLAY " "
           END-PERFORM
           *>  ajout de l'annonce
           *>  note : il faut augmenter fa_code de 1 a chaque execution
           MOVE 4 TO w_code
           MOVE wu_telephone TO w_conducteur
           MOVE w_annonce TO tamp_fannonce
           OPEN I-O fannonce
               WRITE tamp_fannonce
               INVALID KEY
                   DISPLAY "Impossible d'ajouter."
                   DISPLAY " "
               NOT INVALID KEY
                   DISPLAY "Ajout effectue."
                   DISPLAY " "
               END-WRITE
           CLOSE fannonce.

           *> TO-DO : trouver le probleme avec le mois en cours

       MODIFIER_ANNONCE.
           DISPLAY "|| MODIFIER UNE ANNONCE ||"
           DISPLAY " "

           PERFORM AFFICHER_ANNONCES_BIS

           DISPLAY "Veuillez saisir le code de l'annonce a modifier."
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
           DISPLAY "Voulez-vous changer la date de depart ? (O/N)"
           ACCEPT w_reponse
           DISPLAY " "
           IF w_reponse = 'o' OR w_reponse = 'O' THEN
               DISPLAY "Vous allez d'abord saisir la date de depart."
               DISPLAY " "
               SET w_annee TO AA
               PERFORM WITH TEST AFTER UNTIL w_mois >= MM
                   DISPLAY "Veuillez saisir le mois souhaite."
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

           DISPLAY "Voulez-vous changer le point de depart ? (O/N)"
           ACCEPT w_reponse
           DISPLAY " "
           IF w_reponse = 'o' OR w_reponse = 'O' THEN
               DISPLAY "Veuillez saisir votre point de depart."
               ACCEPT w_lieu_depart
               DISPLAY " "
           END-IF

           DISPLAY "Voulez-vous changer le point d'arrivee ? (O/N)"
           ACCEPT w_reponse
           DISPLAY " "
           IF w_reponse = 'o' OR w_reponse = 'O' THEN
               DISPLAY "Veuillez saisir votre point d'arrivee."
               ACCEPT w_lieu_darrive
               DISPLAY " "
           END-IF

           DISPLAY "Voulez-vous changer le lieu de rendez-vous ? (O/N)"
           ACCEPT w_reponse
           DISPLAY " "
           IF w_reponse = 'o' OR w_reponse = 'O' THEN
               DISPLAY "Veuillez saisir un lieu de rendez-vous."
               ACCEPT w_lieu_rdv
               DISPLAY " "
           END-IF

           DISPLAY "Voulez-vous changer le nombre de voyageurs ? (O/N)"
           ACCEPT w_reponse
           DISPLAY " "
           IF w_reponse = 'o' OR w_reponse = 'O' THEN
               PERFORM WITH TEST AFTER UNTIL w_place_max >= 1 AND
               w_place_max <= 4
                   DISPLAY "Veuillez saisir le nombre de voyageurs."
                   DISPLAY "(1 é 4)"
                   ACCEPT w_place_max
                   DISPLAY " "
               END-PERFORM
           END-IF

           DISPLAY "Voulez-vous changer le prix du voyage ? (O/N)"
           ACCEPT w_reponse
           DISPLAY " "
           IF w_reponse = 'o' OR w_reponse = 'O' THEN
               PERFORM WITH TEST AFTER UNTIL w_prix_annonce >= 5
                   DISPLAY "Veuillez saisir le prix du voyage."
                   DISPLAY "(5 ou plus)"
                   ACCEPT w_prix_annonce
                   DISPLAY " "
               END-PERFORM
           END-IF
               MOVE w_annonce TO tamp_fannonce
               REWRITE tamp_fannonce
               DISPLAY "Votre annonce a ete modifie."
               DISPLAY " "
           END-READ

           CLOSE fannonce.

           *> TO-DO : sauvegarder les infos qui ne sont pas modifiés

       SUPPRIMER_ANNONCE.
           DISPLAY "|| SUPPRIMER UNE ANNNONCE ||"
           DISPLAY " "

           PERFORM AFFICHER_ANNONCES_BIS

           DISPLAY "Veuillez saisir le code de l'annonce a supprimer."
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
               DISPLAY "Votre annonce a ete supprimee."
               DISPLAY " "
           END-READ

           CLOSE fannonce.

           *> TO-DO : afficher uniquement les annonces d'un seul user

       AFFICHER_ANNONCES.
           DISPLAY "Voici la liste d'annonces en cours :"
           DISPLAY " "
           OPEN INPUT fannonce
           MOVE 2 TO w_fin

           PERFORM WITH TEST AFTER UNTIL w_fin = 0
           READ fannonce NEXT
           AT END MOVE 0 TO w_fin
           NOT AT END
               DISPLAY "Code : " fa_code
               DISPLAY "Prix : " fa_prix
               DISPLAY "Places : " fa_place_max
               DISPLAY "Depart : " fa_lieu_depart
               DISPLAY "Arrivee : " fa_lieu_darrive
               DISPLAY "Rendez-vous : " fa_lieu_rdv
               DISPLAY "Conducteur : " fa_conducteur
               DISPLAY "Date de depart : " fa_date_depart
           END-READ
           END-PERFORM

           CLOSE fannonce.

       AFFICHER_ANNONCES_BIS.
           OPEN INPUT fannonce
           MOVE 1 TO w_fin
           MOVE wu_telephone TO fa_conducteur
           START fannonce, KEY IS = fa_conducteur
           INVALID KEY
               DISPLAY "Pas d'annonces en cours."
           NOT INVALID KEY
               PERFORM WITH TEST AFTER UNTIL w_fin = 0
               READ fannonce NEXT
               AT END MOVE 0 TO w_fin
               NOT AT END
                   DISPLAY "Code : " fa_code
                   DISPLAY "Prix : " fa_prix
                   DISPLAY "Places : " fa_place_max
                   DISPLAY "Depart : " fa_lieu_depart
                   DISPLAY "Arrivee : " fa_lieu_darrive
                   DISPLAY "Rendez-vous : " fa_lieu_rdv
                   DISPLAY "Conducteur : " fa_conducteur
                   DISPLAY "Date de depart : " fa_date_depart
               END-READ
               END-PERFORM
           END-START

           CLOSE fannonce.
