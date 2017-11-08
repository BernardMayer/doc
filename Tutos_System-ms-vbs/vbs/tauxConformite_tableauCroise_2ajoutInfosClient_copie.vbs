' Projet Taux de conformite :: ajout des infos Personne au tableau croise
' -----------------------------------------------------------------------


Option Explicit
' On Error Resume Next

' Declarations
' ------------
Const adOpenStatic = 3
Const adLockOptimistic = 3
Const adCmdText = &H0001

private tmp, i, j, k, v, x, y
Dim ligne
Dim nPer
Dim nom, prenom, nomAgent, agent, tel1, courriel1
Dim cr, crNom, region, nomRegion, ap, nomAp, elt, nomElt
cr = 1624
crNom = "CA CHARENTE-PERIGORD"
Dim sql, sqlInfosPers, sqlInfosPersFin
Dim retCode
Dim aParams()

Dim args						: 
Set args = WScript.Arguments.Named
Dim configFilePath	:configFilePath = ".\"
Dim configFileName	:configFileName = "config.csv"
Dim dateIso			:dateIso = CStr(Date) 
                    :dateIso = Right(dateIso, 4) & Mid(dateIso, 4, 2) & Left(dateIso, 2)

Dim WshShell		:Set WshShell = WScript.CreateObject("WScript.Shell")

Dim oFso			:Set oFso = WScript.CreateObject("Scripting.Filesystemobject")
Const ForReading 	= 1
Const ForWriting 	= 2
Const ForAppending	= 8

Dim oCnxConfig 		:Set oCnxConfig = CreateObject("ADODB.connection")
Dim sCnxConfig
sCnxConfig= 		"Provider=Microsoft.Jet.OLEDB.4.0;" & _
          			"Data Source=" & WshShell.CurrentDirectory & ";" & _
          			"Extended Properties=""text"""     'apres text ;HDR=YES;FMT=Delimited     
oCnxConfig.Open sCnxConfig
Dim oRsConfig		:Set oRsConfig  = CreateObject("ADODB.recordset")

Dim oFichierLog, nomFichierLog, nomFichierLogDate
Dim oFichierEntree, nomFichierEntree, nbrLignesLues
Dim oFichierSortie, nomFichierSortie, nomFichierSortieSimple, nomFichierSortieDate
nbrLignesLues       = 0
Dim sep				:sep = vbTab



' -*- Determiner le fichier log
If args.exists("fichierLog") Then
	nomFichierLog = args.item("fichierLog")
Else
	retCode = getConfigParams("fichierLog", aParams)
	nomFichierLog = aParams(0, 1)
End If
' * Ouvrir le fichier log en AJOUT, la date en premiere ligne
If (oFso.FileExists(nomFichierLog)) Then
	Set oFichierLog = oFso.OpenTextFile(nomFichierLog, ForWriting)
Else
	Set oFichierLog = oFso.CreateTextFile(nomFichierLog)
End If
oFichierLog.WriteLine(Now() & " :: Debut du fichier log de " & WScript.ScriptName)



Dim indicParDefaut	:indicParDefaut = "0"

Dim colIndicateurs	:Set colIndicateurs = CreateObject("scripting.dictionary")
Class indicateur
	Public label, fichierTout, rang
	Private Sub Class_Initialize()
		label = ""
		fichierTout = ""
		rang = 0
	End Sub
End Class

Dim oCnxInfos 		:Set oCnxInfos = CreateObject("ADODB.connection")
' s24sint001 : DWH   -*-   s24pint001 : DWH2
Dim sCnxInfos
sCnxInfos= 			"Provider=Microsoft.Jet.OLEDB.4.0;" & _
          			"Data Source=" & WshShell.CurrentDirectory & ";" & _
          			"Extended Properties=""text"""     'apres text ;HDR=YES;FMT=Delimited
sCnxInfos= 			"DSN=DWH2;Uid=interro;Pwd=interro;"
oCnxInfos.Open sCnxInfos
Dim oRsInfos		:Set oRsInfos  = CreateObject("ADODB.recordset")
Dim nbrInfos		:nbrInfos = 0

'Dim colNumPers			:Set colNumPers = CreateObject("scripting.dictionary")
'Dim aCles, jCles, jk, bingo


' Initialisation
' --------------

' Le fichier de configuration (configFilePath & configFileName)
' est-il fourni en parametre de la ligne de commande ?
' WScript.Arguments
' @TODO voir les declarations en attendant




' -*- Recuperer les infos Personne
sqlInfosPers =                "SELECT " & vbCrLf
sqlInfosPers = sqlInfosPers & "  COMETE.DIM_EDS_NIV2.COD_EDS_NIV2 AS idRegion, " & vbCrLf
sqlInfosPers = sqlInfosPers & "  COMETE.DIM_EDS_NIV2.LIBL_EDS_NIV2 AS nomRegion, " & vbCrLf
sqlInfosPers = sqlInfosPers & "  COMETE.DIM_EDS_NIV1.COD_EDS_NIV1 AS idAp, " & vbCrLf ' AP
sqlInfosPers = sqlInfosPers & "  COMETE.DIM_EDS_NIV1.LIBL_EDS_NIV1 AS nomAp, " & vbCrLf ' AP
sqlInfosPers = sqlInfosPers & "  COMETE.CIBL_IDENT_PERS_NOYAU.ID_EDS AS idPdv, " & vbCrLf ' PdV
sqlInfosPers = sqlInfosPers & "  COMETE.DIM_GUICHT.LIBL_GUICHT AS nomPdv, " & vbCrLf ' PdV
sqlInfosPers = sqlInfosPers & "  COMETE.CIBL_IDENT_PERS_NOYAU.MATRICUL_AGNT as idAgent, " & vbCrLf
sqlInfosPers = sqlInfosPers & "  TAB_AGNT.NOM_AGENT AS nomAgent, " & vbCrLf
sqlInfosPers = sqlInfosPers & "  COMETE.CIBL_IDENT_PERS_DONNEE.NOM AS nomClient, " & vbCrLf
sqlInfosPers = sqlInfosPers & "  COMETE.CIBL_IDENT_PERS_DONNEE.PRNM AS prenomClient, " & vbCrLf
sqlInfosPers = sqlInfosPers & "  COMETE.CIBL_IDENT_PERS_DONNEE.NUM_TEL_PRINCIPAL AS tel1Client, " & vbCrLf
sqlInfosPers = sqlInfosPers & "  COMETE.CIBL_IDENT_PERS_DONNEE.EMAIL_PRINCIPAL AS courriel1Client " & vbCrLf
sqlInfosPers = sqlInfosPers & "FROM " & vbCrLf
sqlInfosPers = sqlInfosPers & "  COMETE.DIM_EDS_NIV2, " & vbCrLf
sqlInfosPers = sqlInfosPers & "  COMETE.CIBL_IDENT_PERS_NOYAU, " & vbCrLf
sqlInfosPers = sqlInfosPers & "  COMETE.TAB_AGNT, " & vbCrLf
sqlInfosPers = sqlInfosPers & "  COMETE.CIBL_IDENT_PERS_DONNEE, " & vbCrLf
sqlInfosPers = sqlInfosPers & "  COMETE.DIM_GUICHT, " & vbCrLf
sqlInfosPers = sqlInfosPers & "  COMETE.DIM_EDS_NIV1 " & vbCrLf
sqlInfosPers = sqlInfosPers & "WHERE " & vbCrLf
sqlInfosPers = sqlInfosPers & "  ( COMETE.DIM_GUICHT.COD_EDS_NIV1=COMETE.DIM_EDS_NIV1.COD_EDS_NIV1  ) " & vbCrLf
sqlInfosPers = sqlInfosPers & "  AND  ( COMETE.DIM_EDS_NIV1.COD_EDS_NIV2=COMETE.DIM_EDS_NIV2.COD_EDS_NIV2  ) " & vbCrLf
sqlInfosPers = sqlInfosPers & "  AND  ( COMETE.CIBL_IDENT_PERS_NOYAU.ID_DWH_PERS=COMETE.CIBL_IDENT_PERS_DONNEE.ID_DWH_PERS  ) " & vbCrLf
sqlInfosPers = sqlInfosPers & "  AND  ( COMETE.DIM_GUICHT.COD_GUICHT(+)=COMETE.CIBL_IDENT_PERS_NOYAU.ID_EDS  ) " & vbCrLf
sqlInfosPers = sqlInfosPers & "  AND  ( COMETE.TAB_AGNT.MATRICUL_AGNT(+)=COMETE.CIBL_IDENT_PERS_NOYAU.MATRICUL_AGNT  ) " & vbCrLf
sqlInfosPers = sqlInfosPers & "  AND  ( " & vbCrLf
sqlInfosPers = sqlInfosPers & "  COMETE.CIBL_IDENT_PERS_NOYAU.NUM_PERS  =  '"
sqlInfosPersFin = "' " & vbCrLf
sqlInfosPersFin = sqlInfosPersFin & "  ) " & vbCrLf

' -*- Quel est le fichier a traiter ?
' lire, recup numPers, recup infos personne par sql, sauver
retCode = getConfigParams("FichierACompleter", aParams)
nomFichierEntree = aParams(0, 1)
If (nomFichierEntree = "") Then
	oFichierLog.WriteLine(Now() & " :: Pb pour determiner /FichierACompleter/ (" & nomFichierEntree & ")")
	WScript.Quit
Else
	Set oFichierEntree = oFso.OpenTextFile(nomFichierEntree, ForReading)
	If (Err.Number <> 0) Then
		oFichierLog.WriteLine(Now() & " :: Pb pour ouvrir /FichierACompleter/ (" & nomFichierEntree & ")")
		WScript.Quit
	End if
End If
oFichierLog.WriteLine(Now() & " :: Ouverture du fichier en ENTREE (" & nomFichierEntree & ")")

' -*- Quel est le fichier de sortie ?
retCode = getConfigParams("FichierSortiePlusInfosPers", aParams)
nomFichierSortie = aParams(0, 1)
If (nomFichierSortie = "") Then
	oFichierLog.WriteLine(Now() & " :: Pb pour determiner /FichierSortiePlusInfosPers/ (" & nomFichierSortie & ")")
	WScript.Quit
Else
	If (oFso.FileExists(nomFichierSortie)) Then
		Set oFichierSortie = oFso.OpenTextFile(nomFichierSortie, ForWriting)
	Else
		Set oFichierSortie = oFso.CreateTextFile(nomFichierSortie)
	End If
	If (Err.Number <> 0) Then
		oFichierLog.WriteLine(Now() & " :: Pb pour ouvrir /FichierACompleter/ (" & nomFichierSortie & ")")
		WScript.Quit
	End If
End If
oFichierLog.WriteLine(Now() & " :: Ouverture du fichier en SORTIE (" & nomFichierSortie & ")")

' -*- Lire le fichier en entree, ligne a ligne
' La 1ere ligne contient les entetes, donc on passe ...
ligne = oFichierEntree.ReadLine
oFichierSortie.WriteLine ligne & sep _
& "prenom" & sep & "nom" & sep & "tel1" & sep & "courriel" & sep _
& "Nom Agent" & sep & "Agent" & sep _
& "PdV" & sep & "Point de vente" & sep _
& "AP" & sep & "Ag principale" & sep _
& "Reg" & sep & "Region" & sep _
& "CR" & sep & "Caisse"
Do While Not oFichierEntree.AtEndOfStream
	'WScript.Echo oFichierEntree.ReadLine
	ligne = oFichierEntree.ReadLine
	nbrLignesLues = nbrLignesLues + 1
	' -*- Recuperer les infos de la personne
	nPer = Mid(ligne, 2, 8)
	'WScript.Echo nper
	' Construire la requete
	If (CLng(nPer) > 0) Then
'WScript.Echo sqlInfosPers & nPer & sqlInfosPersFin
		oRsInfos.Open	sqlInfosPers & nPer & sqlInfosPersFin, oCnxInfos, adOpenStatic, adLockOptimistic, adCmdText
		If (oRsInfos.RecordCount = 1) then
'WScript.Echo "infos pers pour " & nPer & ":" & oRsInfos.RecordCount
			nom = oRsInfos("nomClient")
			prenom = oRsInfos("prenomClient")
			'cr = 824
			'crNom = "CA CHARENTE-PERIGORD"
			region = oRsInfos("idRegion")
			nomRegion = oRsInfos("nomRegion")
			ap = oRsInfos("idAp")
			nomAp = oRsInfos("nomAp")
			elt = oRsInfos("idPdv")
			nomElt = oRsInfos("nomPdv")
			nomAgent = Trim(oRsInfos("nomAgent"))
			agent = oRsInfos("idAgent")
			tel1 = oRsInfos("tel1Client")
			courriel1 = oRsInfos("courriel1Client")
			oFichierSortie.WriteLine ligne & sep _
			& """" & Trim(prenom) & """" & sep & """" & Trim(nom) & """" & sep & """" & tel1 & """" & sep & """" & courriel1 & """" & sep _
			& """" & nomAgent & """" & sep & """" & agent & """" & sep _
			& """" & elt & """" & sep & """" & nomElt & """" & sep _
			& """" & ap & """" & sep & """" & nomAp & """" & sep _
			& """" & region & """" & sep & """" & nomRegion & """" & sep _
			& """" & cr & """" & sep & """" & crNom & """"
			nbrInfos = nbrInfos + 1
		Else
			oFichierLog.WriteLine(Now() & " :: Pb recup infos avec NPer=" & nPer)
		End if
		oRsInfos.Close
	Else
		oFichierLog.WriteLine(Now() & " :: Pb avec le NPer=" & nPer)
	End if
Loop
oFichierLog.WriteLine("Nbr de lignes lues/traitées = " & nbrLignesLues & "/" & nbrInfos)

'oFichierLog.WriteLine("SQLsss : " & sqlInfosPers & nPer & sqlInfosPersFin)

' Copier fichier en fichier avec horodatage
' insertion de la date
i = instrrev(nomFichierSortie, ".") - 1
nomFichierSortieDate = Left(nomFichierSortie, i) & "_" & dateIso & Right(nomFichierSortie, len(nomFichierSortie) - i)
oFso.CopyFile nomFichierSortie, nomFichierSortieDate
oFichierLog.WriteLine("Copie du fichier de sortie vers fichier horodate " & nomFichierSortieDate)


' Fin
' ---
oFichierSortie.Close
oFichierEntree.Close
oFichierLog.WriteLine(Now() & " :: Fin du fichier log de " & WScript.ScriptName)
oFichierLog.WriteLine("")
oFichierLog.Close
' Horodatage du fichier log
' car DERNIERE ETAPE
i = instrrev(nomFichierLog, ".") - 1
nomFichierLogDate = Left(nomFichierLog, i) & "_" & dateIso & Right(nomFichierLog, len(nomFichierLog) - i)
oFso.CopyFile nomFichierLog, nomFichierLogDate

WScript.Quit
' ********************************************************************************************************************************





' -*- Determiner la liste des fichiers a analyser + leur ordre
retCode = getConfigParams("%FichierEntree%", aParams)
' Recuperer l'ordre dans une collection, pour stocker les objets "indicateur"
For i = 0 To UBound(aParams, 1) - 1
	'WScript.Echo aParams(i,0):WScript.Echo aParams(i,1)
	Set tmp = New indicateur
	tmp.label = aParams(i, 0)
	tmp.fichierTout = aParams(i, 1)
	tmp.rang = i
	' Ajout du nouvel indicateur a la collection
	colIndicateurs.Add i, tmp
	' Compte rendu
	oFichierLog.WriteLine("Indicateur " & i & " : " & tmp.label & " (" & tmp.fichierTout & ")")
Next
oFichierLog.WriteLine("Prise en compte de " & i & " indicateur(s)")
'For i = 0 To UBound(colIndicateurs.Keys)
'	WScript.Echo "i:" & i & ", label:" & colIndicateurs.Item(i).label
'next

' -*- Determiner le fichier contenant la liste des personnes
'ReDim aParams(0, 0)
retCode = getConfigParams("%FichierNumPers%", aParams)
nomFichierNumPers = aParams(0, 1)
i = instrrev(nomFichierNumPers, ".") - 1
' insertion de la date
nomFichierNumPers = Left(nomFichierNumPers, i) & "_" & dateIso & Right(nomFichierNumPers, len(nomFichierNumPers) - i)
' * Ouvrir le fichier NumPers en AJOUT, avec entete en premiere ligne
If (oFso.FileExists(nomFichierNumPers)) Then
	Set oFichierNumPers = oFso.OpenTextFile(nomFichierNumPers, ForWriting)
Else
	Set oFichierNumPers = oFso.CreateTextFile(nomFichierNumPers)
End If
oFichierNumPers.WriteLine("NumPers")
oFichierLog.WriteLine("Creation du fichier des numeros de personne (" & nomFichierNumPers & ")")

' -*- Determiner le fichier en sortie (tableau croise)
retCode = getConfigParams("%FichierSortie%", aParams)
nomFichierSortie = aParams(0, 1)
nomFichierSortieSimple = nomFichierSortie
i = instrrev(nomFichierSortie, ".") - 1
' insertion de la date
nomFichierSortie = Left(nomFichierSortie, i) & "_" & dateIso & Right(nomFichierSortie, len(nomFichierSortie) - i)
' * Ouvrir le fichier NumPers en AJOUT, avec entete en premiere ligne
If (oFso.FileExists(nomFichierSortie)) Then
	Set oFichierSortie = oFso.OpenTextFile(nomFichierSortie, ForWriting)
Else
	Set oFichierSortie = oFso.CreateTextFile(nomFichierSortie)
End If
' * Fabrication de la premiere ligne (les entetes)
oFichierSortie.Write("NumPers")
For i = 0 To UBound(colIndicateurs.Keys)
	oFichierSortie.Write(sep & colIndicateurs.Item(i).label)
Next
oFichierSortie.Write(vbNewLine)
oFichierLog.WriteLine("Creation du fichier de sortie (" & nomFichierSortie & ")")

' -*- ? ? ? Determiner la liste des points de vente ? ? ?
'retCode = getConfigParams("%FichierPdV%", aParams)

' -*- Construire la requete SQL faisant UNION des fichiers a analyser
'			pour determiner la liste des numeros de personnes.
'			Placer cette liste dans une collection, le numero de personne est la clef,
'			et a cette clef, on placera un tableau (ou une collection) avec les valeurs
'			Placer cette collection dans un fichier de numero de personnes

' -*- Creation du SQL pour faire UNION des numeros de personne et sauver dans fichier
unionNumPersSql = ""
For i = 0 To UBound(colIndicateurs.Keys)
	'WScript.Echo "i:" & i & ", label:" & colIndicateurs.Item(i).label
	unionNumPersSql = unionNumPersSql & "SELECT NumPers FROM " & colIndicateurs.Item(i).fichierTout & " ORDER BY NumPers" & vbNewLine & "UNION" & vbNewLine
Next
unionNumPersSql = Left(unionNumPersSql, Len(unionNumPersSql) - 8) ' 8 == len(" UNION " & vbNewLine)
'unionNumPersSql = "SELECT * FROM " & colIndicateurs.Item(1).fichierTout
'WScript.Echo "unionNumPersSql:" & unionNumPersSql
oRsDatas.Open	unionNumPersSql, oCnxDatas, adOpenStatic, adLockOptimistic, adCmdText
'WScript.Echo "Nbr records = " & oRsDatas.RecordCount
oFichierLog.WriteLine("Nbr TOTAL de NumPers : " & oRsDatas.RecordCount & " dans les fichiers.")
' -*- Abonder le fichier des numeros de personne / de sortie et la collection / dictionnaire NumPers
oRsDatas.MoveFirst
Do
	'WScript.Echo "rec0=" & oRsDatas.Fields(0)' & ", rec1=" & oRsDatas.Fields(1)
	' Attention aux lignes vides ...
	If IsNumeric(oRsDatas.Fields(0)) Then
		oFichierNumPers.WriteLine oRsDatas.Fields(0)
		' * Fabrication d'un dictionnaire, pour constituer le tableau croise
		colNumPers.Add CStr(oRsDatas.Fields(0)), ""
	End If
	oRsDatas.MoveNext
Loop Until oRsDatas.EOF
oFichierLog.WriteLine("Fichier ensemble/union des NumPers (" & nomFichierSortie & ") fait.")

'WScript.Echo "00001111" & colNumPers.Item("00001111")
'WScript.Echo colNumPers.Count

' -*- Fabrication du tableau croise/fichier de sortie
aCles = colIndicateurs.Keys
jCles = colNumPers.Keys
' * Pour chaque indicateur ...
For i = 0 To UBound(aCles)
	' ... Recuperer les NumPers pour CET indicateur
	oRsDatas.Close
	unIndicSql = "SELECT NumPers, Nbr FROM " & colIndicateurs.Item(i).fichierTout & " WHERE NumPers IS NOT NULL ORDER BY NumPers"
'WScript.Echo 	"unIndicSql=" & unIndicSql
	oRsDatas.Open	unIndicSql, oCnxDatas, adOpenStatic, adLockOptimistic, adCmdText
	oFichierLog.WriteLine("Extraction de " & oRsDatas.RecordCount & " ligne(s) pour " & colIndicateurs.Item(i).label & " (" & colIndicateurs.Item(i).fichierTout & ")")
	If (oRsDatas.RecordCount > 0) then

		oRsDatas.MoveFirst
'WScript.Echo "nbr rec=" & oRsDatas.RecordCount	
'WScript.Echo "nbr de fields=" & oRsDatas.Fields.Count	
'Dim oF
'For Each oF In oRsDatas.Fields
'	WScript.Echo "nom de field=" & oF.Name
'Next
		
		For j = 0 To UBound(jCles)
			bingo = false
			jk = jCles(j)
			oRsDatas.MoveFirst
			Do
				k = CStr(oRsDatas.Fields.Item(0))
'WScript.Echo "k=" & k & " info=" & oRsDatas.Fields.Item(1)
				If jk = k then
					' BINGO
					'oFichierLog.WriteLine("j=" & j & ", jCles(j=)" & jCles(j) & ", k=" & k & " BINGO")
					colNumPers.Item(jk) = colNumPers.Item(jk) & sep & oRsDatas.Fields.Item(1)
					bingo = true
					Exit Do
				End If
				oRsDatas.MoveNext
			Loop Until oRsDatas.EOF
			If Not bingo then
				' Jamais trouve ...
				'oFichierLog.WriteLine("j=" & j & ", jCles(j)=" & jCles(j) & ", k=" & k)
				colNumPers.Item(jk) = colNumPers.Item(jk) & sep & indicParDefaut
			End if
		Next

	Else
		For j = 0 To UBound(jCles)
			jk = jCles(j)
			colNumPers.Item(jk) = colNumPers.Item(jk) & sep & indicParDefaut
		Next
	End if
Next
oFichierLog.WriteLine("Matrice NumPers/indicateurs realisee")

'			If colNumPers.Exists(k) Then
'				colNumPers.Item(k) = colNumPers.Item(k) & sep & oRsDatas.Fields.Item(1)
'				Exit do
'			Else
'				colNumPers.Item(k) = colNumPers.Item(k) & sep & indicParDefaut
'			End If


' DEBUG - Controle de la collection NumPers
aCles = colNumPers.Keys
For i = 0 To UBound(aCles) - 1
	oFichierSortie.WriteLine """" & aCles(i) & """" & colNumPers.Item(aCles(i))
	'WScript.Echo "aCles(i)=" & i & ", " & colNumPers.Item(aCles(i))
Next
oFichierLog.WriteLine("Matrice enregistrees sous " & nomFichierSortie)

' Copie du fichier de sortie horodate en fichier simple (sans horodatage)
'nomFichierSortie
oFso.CopyFile nomFichierSortie, nomFichierSortieSimple
oFichierLog.WriteLine("Copie vers fichier de travail " & nomFichierSortieSimple)


' Fin
' ---
oFichierSortie.Close
oFichierNumPers.Close
oFichierLog.WriteLine(Now() & " :: Fin du fichier log de " & WScript.ScriptName)
oFichierLog.Close
WScript.Quit






sql = "SELECT * FROM fic2.txt"
sql = "SELECT numPers FROM fic2.txt UNION SELECT NumPers FROM fic1.csv"
sql = "SELECT numPers, nbr1 as nbr FROM fic2.txt UNION SELECT NumPers, nbr FROM (select numpers, nbr1 as nbr from fic3_2cols.txt)"
'sql = "SELECT numPers, nbr FROM fic2.txt UNION SELECT NumPers, nbr FROM (select numpers, nbr1 as nbr from fic3_2cols.txt)"
'sql="select numpers, nbr1 as nbr  from fic3_2cols.txt"
Wscript.Echo sql
objRecordset.Open sql, objConnection, adOpenStatic, adLockOptimistic, adCmdText

Do Until objRecordset.EOF
    'Wscript.Echo "NumPers: " & objRecordset.Fields.Item(0)
    'Wscript.Echo "1: " & objRecordset.Fields.Item(1)
   	
    objRecordset.MoveNext
Loop

' * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
' *********************
' *     Fonctions     *
' *********************

Function includeFile(fSpec)
	Dim file, fileData
	If Not oFSO.FileExists(fSpec) Then
		includeFile = false
	End If
	Set file = oFso.OpenTextFile(fSpec, ForReading)
	fileData = file.ReadAll
	file.Close
	ExecuteGlobal fielData
	Set file = Nothing
	includeFile = true
End Function

Function getConfigParams(byval param, byref retInfos)
	getConfigParams = False
	Dim sqlGetConfigParams, iGetConfigParams
	ReDim retInfos(0, 0)
	iGetConfigParams = 0
	sqlGetConfigParams = "SELECT clef, valeur FROM config.csv WHERE param LIKE '" & param & "' AND ok > 0"
	'sql = "SELECT clef, valeur FROM config.csv WHERE ok > 0"
	'sql = "SELECT clef, valeur FROM [config.csv]"
'WScript.Echo sqlGetConfigParams
	oRsConfig.Open	sqlGetConfigParams, oCnxConfig, adOpenStatic, adLockOptimistic, adCmdText
	'oRsConfig.Open	sql, oCnxConfig, adOpenKeyset
	'oRsConfig = oCnxConfig.Execute(sql)
	'iGetConfigParams = oRsConfig.RecordCount
'WScript.Echo oRsConfig.RecordCount
	If (oRsConfig.RecordCount > 0) Then
		ReDim retInfos(oRsConfig.RecordCount, 1)
		oRsConfig.MoveFirst
		Do
			retInfos(iGetConfigParams,0) = oRsConfig.Fields(0)
			retInfos(iGetConfigParams,1) = oRsConfig.Fields(1)
'WScript.Echo "iGetConfigParams=" & iGetConfigParams & ", 0=" & retInfos(iGetConfigParams,0) & ", 1=" & retInfos(iGetConfigParams,1)
			iGetConfigParams = iGetConfigParams + 1
			oRsConfig.MoveNext
		Loop Until oRsConfig.EOF
		getConfigParams = oRsConfig.RecordCount
	End if
	oRsConfig.Close
End function

Function ScriptPath()
	Dim sSfn	:sSfn = WScript.ScriptFullName
	scriptPath = Left(sSfn, InStrRev(sSfn, "\") - 1)
End Function
