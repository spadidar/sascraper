APPLICATION := honky
LIBDIR		= `erl -eval 'io:format("~s~n", [code:lib_dir()])' -s init stop -noshell`
APP		= scraper
VERSION		= 0.1
CC  		= erlc
ERL     	= erl
EBIN		= ebin
CFLAGS  	= -I include -pa $(EBIN)
COMPILE		= $(CC) $(CFLAGS) -o $(EBIN)
EBIN_DIRS = $(wildcard deps/*/ebin)
DEPS = deps
TEST_SOURCES := $(wildcard test/*.erl)
TEST_BEAMS := $(patsubst %.erl,%.beam, $(TEST_SOURCES))

all: ebin compile

build: remove_deps get_deps build_deps ebin compile

all_boot: all make_boot

start: all start_all

compile:
	@$(ERL) -pa $(EBIN_DIRS) -noinput +B -eval 'case make:all() of up_to_date -> halt(0); error -> halt(1) end.'

test: $(APPLICATION) $(TEST_BEAMS) util/run_test.beam
	@echo Running tests
	@erl -pa util/ -pa ebin/ -pa test/ -noinput -s run_test run

test_shell: $(APPLICATION) $(TEST_BEAMS)
	@echo Starting a shell with test paths included
	@erl -pa ebin/ -pa test/

test/%.beam: test/%.erl
	@echo Compiling $<
	@erlc +debug_info -o test/ $<

edoc:		
	@echo Generating $(APP) documentation from srcs
	@erl -noinput -eval 'edoc:application($(APP), "./", [{doc, "doc/"}, {files, "src/"}])' -s erlang halt	

make_boot:
	(cd ebin; erl -pa ebin -noshell -run make_boot write_scripts scraper)

start_all:
	(cd ebin; erl -pa ebin -noshell -sname scraper -boot scraper)

ebin:
	@mkdir ebin

clean:
	rm -rf ebin/*.beam ebin/erl_crash.dump erl_crash.dump ebin/*.boot ebin/*.rel ebin/*.script doc/*.html doc/*.css doc/erlang.png doc/edoc-info

get_deps: remove_deps
	@mkdir $(DEPS)
	git clone git://github.com/basho/rebar.git $(DEPS)/rebar
	git clone https://github.com/benoitc/couchbeam.git $(DEPS)/couchbeam
	git clone https://github.com/cmullaparthi/ibrowse.git $(DEPS)/ibrowse
	git clone https://github.com/mochi/mochiweb.git $(DEPS)/mochiweb
	git clone https://github.com/tim/erlang-oauth $(DEPS)/oauth
	# git clone https://github.com/benoitc/ejson.git $(DEPS)/ejson
	git clone git://github.com/TonyGen/bson-erlang.git $(DEPS)/bson	
	git clone git://github.com/TonyGen/mongodb-erlang.git $(DEPS)/mongodb
	hg clone https://bitbucket.org/etc/lhttpc $(DEPS)/lhttpc

remove_deps:
	rm -rf $(DEPS)

build_deps:
	echo "Building Rebar"
	cd $(DEPS)/rebar; make

	echo "Copying rebar to dependencies"
	cp $(DEPS)/rebar/rebar $(DEPS)/couchbeam
	cp $(DEPS)/rebar/rebar $(DEPS)/ibrowse
	# cp $(DEPS)/rebar/rebar $(DEPS)/ejson
	cp $(DEPS)/rebar/rebar $(DEPS)/oauth
	cp $(DEPS)/rebar/rebar $(DEPS)/mochiweb
	cp $(DEPS)/rebar/rebar $(DEPS)/bson
	cp $(DEPS)/rebar/rebar $(DEPS)/mongodb

	echo "Building CouchBeam"
	cd $(DEPS)/couchbeam/; make

	echo "Building lhttpc"
	cd $(DEPS)/lhttpc; make

	echo "Building mochiweb"
	cd $(DEPS)/mochiweb; make

	echo "Building mochiweb"
	cd $(DEPS)/ibrowse; make

	echo "Building oauth"
	cd $(DEPS)/oauth; make

	# echo "Building ejson"
	# cd $(DEPS)/ejson/; make

	echo "Building bson"
	cd $(DEPS)/bson/; ./rebar get-deps
	cd $(DEPS)/bson/; ./rebar compile

	echo "Building mongodb"
	cd $(DEPS)/mongodb/; ./rebar get-deps
	cd $(DEPS)/mongodb/; ./rebar compile

