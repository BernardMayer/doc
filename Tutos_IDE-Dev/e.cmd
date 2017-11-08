@rem Java n'esp plus dans le PATH (15/12/2015)
set ePath=C:\LOGICIELS\EclipseKepler\eclipseDAF
set eHome=D:\MyTools\Eclipse
@rem set JavaBin=C:\Program Files (x86)\Java\jre6\bin
@rem set JavaBin=C:\Program Files\Java\jre6\bin
set JavaBin=C:\Program Files\Java\jdk1.6.0_21\bin
@rem set JavaBin=C:\LOGICIELS\JAVA\jdk1.8.0_25\bin
@rem set JavaBin=C:\LOGICIELS\JAVA\jdk1.7.0_67\bin
set oldPath=%PATH%
set PATH=%PATH%;%JavaBin%
cd %eHome%
%ePath%\eclipse.exe
set PATH=%oldPath%

