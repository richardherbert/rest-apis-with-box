﻿/**
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
*/
component
{


	// Application properties
	this.name = hash( getCurrentTemplatePath() );
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan(0,0,0,10);
	this.setClientCookies = false;

	// COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP
	COLDBOX_APP_ROOT_PATH = getDirectoryFromPath( getCurrentTemplatePath() );
	// The web server mapping to this application. Used for remote purposes or static purposes
	COLDBOX_APP_MAPPING   = "";
	// COLDBOX PROPERTIES
	COLDBOX_CONFIG_FILE 	 = "";
	// COLDBOX APPLICATION KEY OVERRIDE
	COLDBOX_APP_KEY 		 = "";
	// JAVA INTEGRATION: JUST DROP JARS IN THE LIB FOLDER
	// You can add more paths or change the reload flag as well.
	this.javaSettings = { loadPaths = [ "lib" ], reloadOnChange = true };

	this.datasources["cfartgallery"] = {
		driver: "other",
		class: 'org.sqlite.JDBC',
		connectionString: 'jdbc:sqlite:/#expandPath( "/database/cfartgallery.db" )#',
		url: 'jdbc:sqlite:/#expandPath( "/database/cfartgallery.db" )#',
		// optional settings
		blob:true, // default: false
		clob:true // default: false
	};
	this.datasource = "cfartgallery";


	// application start
	public boolean function onApplicationStart()
	{
		application.cbBootstrap = new coldbox.system.Bootstrap
		(
			COLDBOX_CONFIG_FILE,
			COLDBOX_APP_ROOT_PATH,
			COLDBOX_APP_KEY,
			COLDBOX_APP_MAPPING
		);
		application.cbBootstrap.loadColdbox();
		return true;
	}


	function onError
	(
		required any exception,
		required string eventname
	)
	{
		include "/layouts/exception.cfm";
	}


	// request start
	public boolean function onRequestStart
	( string targetPage )
	{
		// Process ColdBox Request
		application.cbBootstrap.onRequestStart( arguments.targetPage );
		return true;
	}


	public void function onSessionStart()
	{
		application.cbBootStrap.onSessionStart();
	}


	public void function onSessionEnd
	(
		struct sessionScope,
		struct appScope
	)
	{
		arguments.appScope.cbBootStrap.onSessionEnd( argumentCollection=arguments );
	}


	public boolean function onMissingTemplate
	( template )
	{
		return application.cbBootstrap.onMissingTemplate( argumentCollection=arguments );
	}


}