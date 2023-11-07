component extends="coldbox.system.EventHandler" {

	/**
	 * Default Action
	 */
	function index( event, rc, prc ) {
		prc.welcomeMessage = "Welcome to ColdBox!";
		event.setView( "main/index" );
	}

	/**
	 * Produce some restfulf data
	 */
	function data( event, rc, prc ) {
		return [
			{ "id" : createUUID(), name : "Luis" },
			{ "id" : createUUID(), name : "JOe" },
			{ "id" : createUUID(), name : "Bob" },
			{ "id" : createUUID(), name : "Darth" }
		];
	}

	/**
	 * Relocation example
	 */
	function doSomething( event, rc, prc ) {
		relocate( "main.index" );
	}

	/************************************** IMPLICIT ACTIONS *********************************************/

	function onAppInit( event, rc, prc ) {
	}

	function onRequestStart( event, rc, prc ) {
		param prc.globalData = {};
		/// TEMP: MOVE GET TO SERVICE AND token to LOCAL STORAGE
		cfhttp( method="POST", charset="utf-8", url=getSystemSetting( "API_ROOT" ) & "/login", result="result" ) {
			cfhttpparam( name="username", type="url", value=getSystemSetting( "API_USER" ));
			cfhttpparam( name="password", type="url", value=getSystemSetting( "API_PW" ));
		}
		prc.globalData[ "jwt" ] = deserializeJSON( result.filecontent ).data.tokens.access_token;
		prc.globalData[ "apiRoot" ] = getSystemSetting( "API_ROOT" );
		prc.globalData[ "imgsBaseURL" ] = getSystemSetting( "IMGS_BASE_URL" );
		
	}

	function onRequestEnd( event, rc, prc ) {
	}

	function onSessionStart( event, rc, prc ) {
	}

	function onSessionEnd( event, rc, prc ) {
		var sessionScope     = event.getValue( "sessionReference" );
		var applicationScope = event.getValue( "applicationReference" );
	}

	function onException( event, rc, prc ) {
		event.setHTTPHeader( statusCode = 500 );
		// Grab Exception From private request collection, placed by ColdBox Exception Handling
		var exception = prc.exception;
		// Place exception handler below:
	}

}
