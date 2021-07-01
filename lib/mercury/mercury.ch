#xcommand log <cText> => Aadd( TApp():aLog, <cText> )  //	Tracear el sistema


#xcommand DEFINE APP <oApp> [ TITLE <cTitle> ] [ ON INIT <uInit> ] ;
	[ CREDENTIALS <cPsw> [ COOKIE <cId_Cookie>] [ <time:LAPSUS, TIME> <nTime> ] ] ;
=> ;
	<oApp> := APP( [<cTitle>], [\{|| <uInit>\}] , [ <cPsw> ], [<cId_Cookie>], [<nTime>]   )
	
#xcommand DEFINE ROUTE <cRoute> URL <cUrl> <type:CONTROLLER,VIEW> <cController> [ METHOD <cMethod> ] OF <oApp> ;
=> ;
	<oApp>:oRoute:Map( [<cMethod>], <cRoute>, <cUrl>, <cController> )

#xcommand INIT APP <oApp> => <oApp>:Init()

#xcommand AUTENTICATE CONTROLLER <oController> [ VIA <cType> ] [<err:ERROR ROUTE, DEFAULT> <cRoute>] ;
	[ <exc: EXCEPTION> <cMethod,...> ] [ <json:ERROR JSON> [<hError>]] ;
=> ;
	<oController>:Middleware( [<cType>], [<cRoute>], [\{<cMethod>\}], [<hError>], [<.json.>] )
	
	//__lAutenticate := <oController>:Middleware( [<cType>], [<cRoute>], [\{<cMethod>\}], [<hError>], [<.json.>] )

//	Request 	-------------------------------------------------------------------	

#xcommand DEFINE <cVar> POST <cParameter> [TYPE <cType>] [DEFAULT <cDefault>] OF <oController> ;
=> ;
	<cVar> := <oController>:oRequest:Post( <cParameter>, [<cDefault>], [<cType>] )
	
#xcommand DEFINE <cVar> GET  <cParameter> [TYPE <cType>] [DEFAULT <cDefault>] OF <oController> ;
=> ;
	<cVar> := <oController>:oRequest:Get( <cParameter>, [<cDefault>], [<cType>] )	

//	Validator	-------------------------------------------------------------------	

#xcommand DEFINE VALIDATOR <oValidator> WITH <hData> ;
	[<err:ERROR ROUTE, DEFAULT> <cRoute>] [<json:ERROR JSON> ] ;
=> ;
	<oValidator> := TValidator():New( <hData>, [<cRoute>], [<.json.>]  )
	
#xcommand PARAMETER <cParameter> [NAME <cName>] ROLES <cRoles> [FORMATTER <cFormat>] OF <oValidator> ;
=> ;
	<oValidator>:Set( <cParameter>, <cRoles>, [<cName>], [<cFormat>] )
#xcommand RUN VALIDATOR <oValidator> => <oValidator>:Run()



	
//	Token JWT 	-------------------------------------------------------------------
	
#xcommand DEFINE JWT OF <oController> [ WITH <hToken> ] [ TIME <nTime> ] => ;
	<oController>:oMiddleware:SetAutenticationJWT( [<hToken>], [<nTime>] )
	
#xcommand CLOSE JWT OF <oController> => <oController>:oMiddleware:CloseJWT()
#xcommand GET JWT <hData> OF <oController> => <hData> := <oController>:oMiddleware:GetDataJWT()
#xcommand GET TOKEN <hData> OF <oController> => <hData> := <oController>:oMiddleware:GetDataToken()

#xcommand CREATE JWT <cToken> OF <oController> [ WITH <hTokenData> ] [ TIME <nTime> ] => ;
	<cToken> := <oController>:oMiddleware:SetAutenticationJWT( [<hTokenData>], [<nTime>] )
#xcommand CREATE TOKEN <cToken> OF <oController> [ WITH <hTokenData> ] [ TIME <nTime> ] => ;
	<cToken> := <oController>:oMiddleware:SetAutenticationToken( [<hTokenData>], [<nTime>] )	