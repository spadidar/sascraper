{application, scraper,
 [{description, "Erlang scraper"},
  {vsn, "0.1"},
  {modules, [
	    main, 
	    http_utilities	
        ]},	
  {registered, []},
  {applications, [kernel, stdlib]},
  {env, []},

  %% Application Start point
  {mod, {main, []}}]}.