{application, scraper,
 [{description, "Erlang scraper"},
  {vsn, "0.1"},
  {modules, [
	    main, 
	    http_utilities,
	    db_manager	
        ]},	
  {registered, []},
  {applications, [kernel, stdlib, sasl, inets, couchbeam]},
  {env, []},

  %% Application Start point
  {mod, {main, []}}]}.