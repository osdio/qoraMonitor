@ECHO OFF
IF EXIST java (
	start "Qora" java -Xmx512m -Djava.library.path=libs/native -jar Qora.jar
) ELSE (
	IF EXIST "%PROGRAMFILES%\Java\jre7" (
		start "Qora" "%PROGRAMFILES%\Java\jre7\bin\java.exe" -Xmx256m -Djava.library.path=libs/native -jar Qora.jar
	) ELSE (
		IF EXIST "%PROGRAMFILES(X86)%\Java\jre7" (
			start "Qora" "%PROGRAMFILES(X86)%\Java\jre7\bin\java.exe" -Xmx256m -Djava.library.path=libs/native -jar Qora.jar
		) ELSE (
			ECHO Java software not found on your system. Please go to http://java.com/en/ to download a copy of Java.
			PAUSE
		)
	)
)