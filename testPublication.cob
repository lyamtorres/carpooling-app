   ******************************************************************
      * Authors:
      * Date:
      * Purpose: Programme pour tester les fonctionnalités de publication
      *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. testPublication.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT futilisateur ASSIGN TO "utilisateur.dat"
           ORGANIZATION INDEXED
           ACCESS MODE is DYNAMIC
           RECORD KEY IS fu_telephone
           ALTERNATE RECORD KEY IS fu_type WITH DUPLICATES
           ALTERNATE RECORD KEY IS fu_immatriculation
           FILE STATUS IS cr_futilisateur.

           SELECT freservation ASSIGN TO "reservation.dat"
           ORGANIZATION INDEXED
           ACCESS MODE is DYNAMIC
           RECORD KEY IS fres_code
           ALTERNATE RECORD KEY IS fres_voyageur WITH DUPLICATES
           ALTERNATE RECORD KEY IS fres_conducteur WITH DUPLICATES
           FILE STATUS IS cr_freservation.


           SELECT fstatistiques ASSIGN TO "statistiques.dat"
           ORGANIZATION INDEXED
           ACCESS MODE is DYNAMIC
           RECORD KEY IS fs_code
           ALTERNATE RECORD KEY IS fs_villeD WITH DUPLICATES
           ALTERNATE RECORD KEY IS fs_villeA WITH DUPLICATES
           ALTERNATE RECORD KEY IS fs_conducteur WITH DUPLICATES
           FILE STATUS IS cr_fstatistiques.

           SELECT fannonce ASSIGN TO "annonce.dat"
           ORGANIZATION INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS fa_code
           ALTERNATE RECORD KEY IS fa_lieudepart WITH DUPLICATES
           ALTERNATE RECORD KEY IS fa_lieudarrive  WITH DUPLICATES
           FILE STATUS IS cr_fannonce.

       DATA DIVISION.

       FILE SECTION.

       FD futilisateur.
       01 tamp_futilisateur.
           02 fu_telephone PIC 9(10).
           02 fu_nom PIC A(20).
           02 fu_prenom PIC A(30).
           02 fu_mdp PIC X(10).
           02 fu_type PIC 9(1).
           02 fu_solde PIC 9(4).
           02 fu_immatriculation PIC X(9).
           02 fu_nbplace PIC 9(5).

       FD freservation.
       01 tamp_freservation.
           02 fres_code PIC 9(6).
           02 fres_voyageur PIC 9(10).
           02 fres_conducteur PIC 9(10).
           02 fres_status PIC 9(1).
           02 fres_date_reservation.
               03 fres_annee  PIC  9(4).
               03 fres_mois PIC  9(2).
               03 fres_jour PIC  9(2).
           02 fres_statut_reservation PIC 9(2).

       FD fannonce.
       01 tamp_fannonce.
           02 fa_code PIC 9(6).
           02 fa_prix PIC 9(8).
           02 fa_place_max PIC 9(1).
           02 fa_lieudepart PIC X(30).
           02 fa_lieudarrive PIC X(30).
           02 fa_lieu_rdv PIC X(30).
           02 fa_conducteur PIC A(10).
           02 fa_date_depart.
              03 fa_annee  PIC  9(2).
              03 fa_mois PIC  9(2).
              03 fa_jour  PIC  9(2).

       FD fstatistiques.

       01 tamp_fstatistiques.
           02 fs_code PIC 9(6).
           02 fs_villeD PIC X(30).
           02 fs_villeA PIC X(30).
           02 fs_conducteur PIC A(10).
           02 fs_prix PIC 9(8).

       WORKING-STORAGE SECTION.
       01 SYS-DATE6.
           03 AA   PIC 99.
           03 MM  PIC 99.
           03 JJ    PIC 99.
       77 cr_futilisateur PIC 9(2).
       77 cr_freservation PIC 9(2).
       77 cr_fannonce PIC 9(2).
       77 cr_fstatistiques PIC 9(2).

       *>* variables pour l'annonce
       77 wcode PIC 9(6).

       *>** variables temporaires pour les villes de dï¿½part et d arrivï¿½
       77 wnomvilleD PIC X(30).
       77 wnomvilleA PIC X(30).
       77 datedepart PIC X(30).
       77 Wfin PIC 9(1).

       PROCEDURE DIVISION.

           OPEN I-O futilisateur
           IF cr_futilisateur=35 THEN
              OPEN OUTPUT futilisateur
           END-IF
           CLOSE futilisateur

           OPEN I-O freservation
           IF cr_freservation=35 THEN
              OPEN OUTPUT freservation
           END-IF
           CLOSE freservation

           OPEN I-O fannonce
           IF cr_fannonce=35 THEN
              OPEN OUTPUT fannonce
           END-IF
           CLOSE fannonce.

           OPEN I-O fstatistiques
           IF cr_fstatistiques=35 THEN
              OPEN OUTPUT fstatistiques
           END-IF
           CLOSE fstatistiques.

           COPY 'supprimerAnnonce.cpy'.

           STOP RUN.

           END PROGRAM testPublication.
