{application,oauth,
             [{description,"Erlang OAuth implementation"},
              {vsn,"0.2"},
              {applications,[kernel,stdlib,crypto,inets]},
              {modules,[oauth,oauth_client,oauth_hmac_sha1,oauth_http,
                        oauth_plaintext,oauth_rsa_sha1,oauth_unix,
                        oauth_uri]}]}.
