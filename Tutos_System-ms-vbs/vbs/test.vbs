' Test
' ! emplacement Schema.ini "infos generales" en dur 

' - Declarations
Const adOpenStatic 			= 3
Const adLockOptimistic		= 3
Const adCmdText 			= &H0001
Const ForReading 			= 1
Const ForWriting 			= 2
Const ForAppending	    	= 8

Dim oWsShell
Set oWsShell				= CreateObject("WScript.Shell")
Dim colAdh
Set colAdh 					= CreateObject("scripting.dictionary")
Dim oCnxInfosGenerales
Set oCnxInfosGenerales 		= CreateObject("ADODB.connection")
Dim sCnxInfosGenerales
Dim oRsListeAdh
Set oRsListeAdh  			= CreateObject("ADODB.recordset")

Dim sRepSchemaInfosGenerales
' ! parametre a definir
'sRepSchemaInfosGenerales 	= oWsShell.CurrentDirectory & "\..\Datas&Tools;"
sRepSchemaInfosGenerales 	= "K:\DIR_DCE\SER_PCC\CAT Infocentre\98 - Doc Perso\BernardMayeR\Datas&Tools"

Dim sSqlTmp
Class Adherent
	Public id, lib, numCr, abrev, SIHisto, vague
	Private Sub Class_Initialize()
		id 		= ""
		lib 	= ""
		numCr 	= ""
		abrev 	= ""
		SIHisto	= ""
		vague 	= ""
	End Sub
End Class

' - Connexion a la "base de donnees"
' la methode .Open() va lire le fichier Schema.ini present dans le repertoire designe,
' (ici WshShell.CurrentDirectory) afin d'obtenir la liste des fichiers.
' Cette liste de fichiers va tenir lieu de liste de tables
sCnxInfosGenerales= 	"Provider=Microsoft.Jet.OLEDB.4.0;" & _
                        "Data Source=" & sRepSchemaInfosGenerales & ";" & _
						"Extended Properties=""text"";"     'apres text HDR=YES;FMT=Delimited
oCnxInfosGenerales.Open sCnxInfosGenerales


WScript.Echo getListeAdherents(colAdh)
dim inner
retCode = html_afficheListeAdherents(colAdh, inner)
WScript.Echo inner


function html_afficheListeAdherents(byRef colAdhs, byRef out)
	out = "<table>" & vbCrLf
	For i = 0 To UBound(colAdhs.Keys)
		out = out & "<tr>" & vbCrLf
		out = out & "<td><input type=""radio"" name=""radioAdh"" id=""adh_" & colAdhs.Item(i).id & """ /></td>" & vbCrLf
		out = out & "<td>" & colAdhs.Item(i).id & "</td>" & vbCrLf
		out = out & "<td>" & colAdhs.Item(i).lib & "</td>" & vbCrLf
		out = out & "<td>" & colAdhs.Item(i).abrev & "</td>" & vbCrLf
		out = out & "<td>" & colAdhs.Item(i).numCr & "</td>" & vbCrLf
		out = out & "<td>" & colAdhs.Item(i).vague & "</td>" & vbCrLf
		out = out & "<td>" & colAdhs.Item(i).SIHisto & "</td>" & vbCrLf
		out = out & "</tr>" & vbCrLf
	next
	out = out & "</table>" & vbCrLf
end function

function getListeAdherents(byref colAdh)
	dim i
	i = 0
	sSqlTmp = "SELECT AdhId, AdhLib, AdhNumCr, AdhAbrev, AdhSIHisto, AdhVague FROM tblAdherents.csv ORDER BY adhVague, adhId"
	oRsListeAdh.Open sSqlTmp, oCnxInfosGenerales, adOpenStatic, adLockOptimistic, adCmdText
	do while not oRsListeAdh.EOF
		set oAdh 		= new Adherent
		oAdh.id 		= oRsListeAdh("AdhId")
		oAdh.lib 		= oRsListeAdh("AdhLib")
		oAdh.numCr 		= oRsListeAdh("AdhNumCr")
		oAdh.abrev 		= oRsListeAdh("AdhAbrev")
		oAdh.SIHisto	= oRsListeAdh("AdhSIHisto")
		oAdh.vague 		= oRsListeAdh("AdhVague")
		colAdh.Add i, oAdh ' 0 to nbr-1 'oRsListeAdh.AbsolutePosition - 1
		i = i + 1
		oRsListeAdh.moveNext
	loop
	getListeAdherents = UBound(colAdh.Keys) + 1
	oRsListeAdh.Close
end function
