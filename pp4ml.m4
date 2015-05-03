m4_divert(-1)ml4_dnl

m4_changequote({,})

m4_define({RUN_MODULE_TESTS},{;;if not (EasyTest.run (List.rev (!Tests.test_list))) then ( print_newline (); exit 1 );;})
m4_define({MAYBE_APPEND_RUN_MODULE_TESTS},
	{m4_divert(1)RUN_MODULE_TESTS()m4_changequote({,})m4_define({$0},)m4_changequote(,)m4_divert(0)})
m4_define({MAYBE_SETUP_MODULE_TESTS},
	{m4_changequote({,})m4_define({$0},)m4_changequote(,)MAYBE_APPEND_RUN_MODULE_TESTS()
	 = ();; module Tests = struct let test_list : EasyTest.Descriptor.t list ref = ref [] end;; let () })	
m4_define({TEST},
	{ () MAYBE_SETUP_MODULE_TESTS = EasyTest.create Tests.test_list STRINGIFY($1);
	  let open EasyTest in (EasyTest.define Tests.test_list) := fun ( ) -> let ident x
	  m4_changequote({,})m4_define({begin},{TEST_BEGIN})m4_changequote(,)})	  
m4_define({TEST_BEGIN},{m4_changequote({,})m4_undefine({begin})m4_changequote(,) x in ident begin})

m4_define(Expect,{Expect1($1)})
m4_define(Expect_raises,{Expect2($1,$2)})
m4_define(STRINGIFY,{m4_changequote({,})"{$1}"m4_changequote(,)})
m4_define(Expect1,{EasyTest.expect ~file:STRINGIFY(m4___file__) ~line:m4___line__ ~lexeme:STRINGIFY($1) (fun () -> let open EasyTest.Types in ($1))})
m4_define(Expect2,{Expect1(try ($1) with $2 -> true)})

m4_changequote(,)
m4_changecom((*,*))
m4_divert(0)
