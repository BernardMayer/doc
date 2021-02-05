* Pour modifier la version du plugin :
* Executer la command maven suivante (via Eclipse ou en ligne de commande) sur le projet Java_DTWH_MOS_Editor_Build
mvn tycho-versions:set-version -DnewVersion=<Nouvelle version> -Dartifacts=fr.ca.cat.mos.parent,Eclipse_DTWH_MOS_Editor_Build

* En attendant que la PIC puisse releaser le plugin, pour creer une release, il faut :
1) Modifier la version sur une version de release (cf. ci-dessus)
2) Créer une version de reference RTC portant le nom "Version X.Y.Z"
3) Construire le plugin : Sur le projet Eclipse_DTWH_MOS_Build, executer la commande maven
mvn clean install -P matiere.eclipse



