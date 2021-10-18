# EDM4611-020-Esquisse-5-Traces-de-particules

![rendu](https://user-images.githubusercontent.com/48024730/137779498-7d0917d7-72df-4d2b-97e9-0518991d156d.png)

Cette esquisse a pour but de créer un système pouvant s’apparenter à une simulation de fluide en exploitant les techniques en lien avec les vecteurs présentes dans Processing.

--

Le système de particules est créé à l’aide d’une collection d’objets de type **PVector**. Chacune de ces particules mobiles contient des vecteurs gardant en mémoire l’information de position, de gravité, de vélocité, d’accélération et de vitesse de rebond. À chaque instant, la vélocité est augmentée par la magnitude de l’accélération et la gravité est augmentée par la magnitude de la vélocité. Cette nouvelle valeur de gravité est ensuite ajoutée à la valeur de position afin de créer un mouvement d’accélération constant.

Le système contient également des particules statiques sur lesquelles les particules mobiles peuvent rebondir. Lorsqu’un objet mobile entre en contact avec un objet statique, la force de la gravité ainsi que celle de la vélocité sont mise à zéro et la vitesse du rebond est calculée comme étant la moitié de la vitesse courante du mobile. L'orientation du mobile est ensuite ajustée en fonction de l’angle miroir causé par la **tangente** de l’objet statique. Cet angle est ensuite ajouté comme force pour influencer la position du mobile. Une fonction a également été mise en place afin d’appliquer une force opposée sur le mobile dans le cas où ce dernier serait en interpénétration avec l’objet statique.

Les objets mobiles laissent également une trace de leur passage lors de leur descente. Cette trace est créée en gardant les 5 dernières positions du mobile dans un **tableau de PVector**. Ces positions sont ensuite appliquées à des cercles dont la taille et l’opacité diminuent au fur et à mesure. L’objet mobile sera retiré de la scène au moment où le dernier enfant de la trainée a quitté l’écran. La **luminosité** des objets mobile et des enfants de sa trainée est choisie en fonction de la vitesse courante du mobile. La **teinte** des objets mobiles et des objets statiques est décidée aléatoirement à l’ouverture de l’esquisse.

Pour ajouter un nouvel objet statique à la scène, faites un **clic gauche** sur le canevas et un objet statique apparaitra graduellement selon une animation **Ease In**. Pour retirer un objet statique de la scène, faites un **clic droit** sur un des objets statiques afin de déclencher une animation de sortie de type **Ease Out**. L’objet sera retiré de la scène une fois l’animation terminée. Il est aussi possible d’ajouter un objet statique qui suit la position de la souris. Pour ce faire, faites un **clic avec le bouton du milieu de la souris**. Cet objet sera retiré lorsque le bouton du milieu sera relâché.

--

Il est également possible de sauvegarder une image vectorielle au format **PDF** de l’esquisse en appuyant sur la touche **ENTER** du clavier. Le PDF sauvegarder ira dans un dossier export situé à la racine du projet. La librairie processing.pdf est utilisée pour effectuer l’exportation.

**Inspirations:**</br>
Collision entre 2 cercles: https://processing.org/examples/circlecollision.html</br>

Image d'inspiration pour le visuel:
![image](https://user-images.githubusercontent.com/48024730/137778719-8718d0bb-8c3d-4670-906a-4e6467ba83d9.png)

