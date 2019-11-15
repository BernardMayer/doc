@rem pandoc...
set converter=C:\Users\et02773\AppData\Local\Pandoc\pandoc.exe

set baseDir=
@rem fabriquera un repertoire /media dedans
set dirMedia=C:\AncienDisqueD\myTools\MD\img
set dirIn=C:\AncienDisqueD\myTools\MD
set fileIn=DTWHv2_DevOutilMOS_0.00-Doc0.docx
set dirOut=C:\AncienDisqueD\myTools\MD
set fileOut=DTWHv2_DevOutilMOS_0.00-Doc0.md

@rem --standalone
@rem --read (read format) --write (output format) (== --from --to)
@rem --data-dir=DIRECTORY
@rem --verbose --quiet --log=FILE.json
%converter% --verbose --extract-media=%dirMedia% --from docx --write markdown -o %dirOut%\%fileOut% %dirIn%\%fileIn%
