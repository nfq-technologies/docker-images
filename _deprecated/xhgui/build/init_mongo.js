use xhprof
db.results.createIndex( { 'meta.SERVER.REQUEST_TIME' : -1 } )
db.results.createIndex( { 'profile.main().wt' : -1 } )
db.results.createIndex( { 'profile.main().mu' : -1 } )
db.results.createIndex( { 'profile.main().cpu' : -1 } )
db.results.createIndex( { 'meta.url' : 1 } )
db.results.createIndex( { 'meta.simple_url' : 1 } )
db.results.createIndex( { 'meta.SERVER.SERVER_NAME' : 1 } )
