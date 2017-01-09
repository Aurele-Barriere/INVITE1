# Invite1

##### Aurèle Barrière et Jérémy Thibault

# Contenu
Cet archive contient la liste des fichiers sources du projet d'Invite1 réalisé
dans le cadre des cours de l'ENS Rennes.

Le sujet s'intéressait à différentes méthodes statistiques permettant d'augmenter
la résolution d'images. Nous avons implémenté deux d'entres elles: la méthode de
régression SVM, avec ou sans les données de gradient des images, et la méthode des
k plus proches voisins. Nous avons également utilisé une méthode de cross-validation
pour déterminer des valeurs optimales de certains paramètres.

# Utilisation
La fonction principale à utiliser est
```
super_resolution(images_learning_basse_resolution, images_learning_haute_resolution, image_test, param)
```

Les paramètres `images_learning_basse_resolution` et `images_learning_haute_resolution`
sont les images sur lesquelles l'apprentissage va s'effectuer. `image_test` est une
seule image sur laquelle on va appliquer l'apprentissage. Enfin, `param` est une
structure optionnelle contenant les paramètres `R` le rayon du voisinage considéré
ainsi que `method` valant 0 pour la régression SVM, 2 pour la régression SVM avec
données de gradients et enfin -1 pour la méthode KNN.

Une fonction `main` est fournie. Celle-ci est adaptée pour GNU Octave, et rien n'a été testé sous Matlab.

# Résultats
Pour obtenir ces résultats, nous nous sommes contentés d'observer les images de départ
et d'arrivée "à l'oeil".

## Méthode SVM
Les résultats à l'aide de la méthode SVM sont concluants: sur nos images tests, les résultats
sont proches de ce que l'on souhaite obtenir. On remarque en particulier que l'ajout
des données de gradient améliorent le résultat.

## Méthode KNN
Notre implémentation des KNN n'est pas concluante. Nous obtenons un damier périodique.

# Conclusion
Ce projet nous a permis d'appliquer des méthodes d'apprentissage vues en cours
dans un exemple pratique.
Notre travail peut être amélioré : il serait souhaitable, par exemple, de mesurer
la différence entre les images obtenues et les images hautes résolutions de test.
De plus, nous n'avons pas comparé la méthode SVM à d'autres méthodes plus rapides
et qui ont l'avantage de ne pas nécessiter un jeu d'apprentissage telles que
l'interpolation polynomiale.
