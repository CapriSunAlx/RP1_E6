-- Création de la base de données s'il n'existe pas 
CREATE DATABASE IF NOT EXISTS forum_ba;
-- Séléctionner la base de données
USE forum_ba;

/**********************************
Structure de la table `utilisateurs`
***********************************/

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE `utilisateurs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role` enum('utilisateur','admin') DEFAULT 'utilisateur',
  `date_inscription` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `prenom` varchar(255) NOT NULL,
  `photo_profil` varchar(255) DEFAULT NULL,
  CONSTRAINT pk_utilisateurs_id PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
);

/********************************
Structure de la table `categorie`
*********************************/

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE `categorie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
CONSTRAINT pk_categorie_id PRIMARY KEY (`id`)
);

/****************************
Structure de la table `posts`
*****************************/

DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) NOT NULL,
  `contenu` text NOT NULL,
  `utilisateur_id` int NOT NULL,
  `date_post` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `statut` enum('en attente','validé','supprimé') DEFAULT 'en attente',
  `idCategorie` int NOT NULL,
CONSTRAINT pk_posts_id PRIMARY KEY (`id`),
CONSTRAINT fk_utilisateur_posts FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`),
CONSTRAINT fk_idCategorie FOREIGN KEY (`idCategorie`) REFERENCES `categorie` (`id`)
);

/*********************************
Structure de la table `commentaires`
***********************************/

DROP TABLE IF EXISTS `commentaires`;
CREATE TABLE `commentaires` (
  `id` int NOT NULL AUTO_INCREMENT,
  `contenu` text NOT NULL,
  `idUtilisateur` int NOT NULL,
  `idPost` int NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT pk_commentaires_id PRIMARY KEY (`id`),
CONSTRAINT fk_idUtilisateur FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateurs` (`id`),
CONSTRAINT fk_idPost FOREIGN KEY (`idPost`) REFERENCES `posts` (`id`)
);


/*****************************
Structure de la table `favoris`
******************************/

DROP TABLE IF EXISTS `favoris`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoris` (
  `utilisateur_id` int NOT NULL,
  `post_id` int NOT NULL,
  CONSTRAINT pk_favoris PRIMARY KEY (`utilisateur_id`, `post_id`),
  CONSTRAINT fk_post FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT fk_utilisateur_favoris FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`)
);
