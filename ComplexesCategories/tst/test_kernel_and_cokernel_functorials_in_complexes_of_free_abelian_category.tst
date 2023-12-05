gap> MAKE_READ_WRITE_GLOBAL( "REREADING" );
gap> REREADING := true;;
gap> SetInfoLevel( InfoWarning, 0 );
gap> k := HomalgFieldOfRationals( );;
gap> objects := [ [ "A", [ -5, -1 ] ], [ "B", [ -4, 4 ] ], [ "U", [ -6, 2 ] ], [ "V", [ -5, 4 ] ] ];;
gap> morphisms := [  [ "alpha", [ 1, 2 ], 0, [ -3, -2 ], "\\alpha" ], [ "f", [ 1, 3 ], 0, [ -3, -1 ], "f" ], [ "nu", [ 3, 4 ], 0, [ -4, 1 ], "\\nu" ], [ "g", [ 2, 4 ], 0, [ -4, 1 ], "g" ] ];;
gap> relations := [  [ "Differential( alpha )", 1 ], [ "Differential( f )", 2 ], [ "Differential( nu )", 3 ], [ "Differential( g )", 3 ], [ "PreCompose( alpha, g )-PreCompose( f, nu )", 1 ] ];;
gap> q := FinQuiver( "q(A_m5,A_m4,A_m3,A_m2,A_m1,B_m4,B_m3,B_m2,B_m1,B_0,B_1,B_2,B_3,B_4,U_m6,U_m5,U_m4,U_m3,U_m2,U_m1,U_0,U_1,U_2,V_m5,V_m4,V_m3,V_m2,V_m1,V_0,V_1,V_2,V_3,V_4)[dA_m5:A_m5->A_m4,dA_m4:A_m4->A_m3,dA_m3:A_m3->A_m2,dA_m2:A_m2->A_m1,dB_m4:B_m4->B_m3,dB_m3:B_m3->B_m2,dB_m2:B_m2->B_m1,dB_m1:B_m1->B_0,dB_0:B_0->B_1,dB_1:B_1->B_2,dB_2:B_2->B_3,dB_3:B_3->B_4,dU_m6:U_m6->U_m5,dU_m5:U_m5->U_m4,dU_m4:U_m4->U_m3,dU_m3:U_m3->U_m2,dU_m2:U_m2->U_m1,dU_m1:U_m1->U_0,dU_0:U_0->U_1,dU_1:U_1->U_2,dV_m5:V_m5->V_m4,dV_m4:V_m4->V_m3,dV_m3:V_m3->V_m2,dV_m2:V_m2->V_m1,dV_m1:V_m1->V_0,dV_0:V_0->V_1,dV_1:V_1->V_2,dV_2:V_2->V_3,dV_3:V_3->V_4,alpha_m3:A_m3->B_m3,alpha_m2:A_m2->B_m2,f_m3:A_m3->U_m3,f_m2:A_m2->U_m2,f_m1:A_m1->U_m1,nu_m4:U_m4->V_m4,nu_m3:U_m3->V_m3,nu_m2:U_m2->V_m2,nu_m1:U_m1->V_m1,nu_0:U_0->V_0,nu_1:U_1->V_1,g_m4:B_m4->V_m4,g_m3:B_m3->V_m3,g_m2:B_m2->V_m2,g_m1:B_m1->V_m1,g_0:B_0->V_0,g_1:B_1->V_1]" );;
gap> F := PathCategory( q );;
gap> kF := k[F];;
gap> rels := [ PreCompose( kF.dA_m5, kF.dA_m4 ),
> PreCompose( kF.dA_m4, kF.dA_m3 ),
> PreCompose( kF.dA_m3, kF.dA_m2 ),
> PreCompose( kF.dB_m4, kF.dB_m3 ),
> PreCompose( kF.dB_m3, kF.dB_m2 ),
> PreCompose( kF.dB_m2, kF.dB_m1 ),
> PreCompose( kF.dB_m1, kF.dB_0 ),
> PreCompose( kF.dB_0, kF.dB_1 ),
> PreCompose( kF.dB_1, kF.dB_2 ),
> PreCompose( kF.dB_2, kF.dB_3 ),
> PreCompose( kF.dU_m6, kF.dU_m5 ),
> PreCompose( kF.dU_m5, kF.dU_m4 ),
> PreCompose( kF.dU_m4, kF.dU_m3 ),
> PreCompose( kF.dU_m3, kF.dU_m2 ),
> PreCompose( kF.dU_m2, kF.dU_m1 ),
> PreCompose( kF.dU_m1, kF.dU_0 ),
> PreCompose( kF.dU_0, kF.dU_1 ),
> PreCompose( kF.dV_m5, kF.dV_m4 ),
> PreCompose( kF.dV_m4, kF.dV_m3 ),
> PreCompose( kF.dV_m3, kF.dV_m2 ),
> PreCompose( kF.dV_m2, kF.dV_m1 ),
> PreCompose( kF.dV_m1, kF.dV_0 ),
> PreCompose( kF.dV_0, kF.dV_1 ),
> PreCompose( kF.dV_1, kF.dV_2 ),
> PreCompose( kF.dV_2, kF.dV_3 ),
> PreCompose( kF.dA_m4, kF.alpha_m3 ),
> PreCompose( kF.alpha_m3, kF.dB_m3 ) - PreCompose( kF.dA_m3, kF.alpha_m2 ),
> PreCompose( kF.alpha_m2, kF.dB_m2 ),
> PreCompose( kF.dA_m4, kF.f_m3 ),
> PreCompose( kF.f_m3, kF.dU_m3 ) - PreCompose( kF.dA_m3, kF.f_m2 ),
> PreCompose( kF.f_m2, kF.dU_m2 ) - PreCompose( kF.dA_m2, kF.f_m1 ),
> PreCompose( kF.f_m1, kF.dU_m1 ),
> PreCompose( kF.dU_m5, kF.nu_m4 ),
> PreCompose( kF.nu_m4, kF.dV_m4 ) - PreCompose( kF.dU_m4, kF.nu_m3 ),
> PreCompose( kF.nu_m3, kF.dV_m3 ) - PreCompose( kF.dU_m3, kF.nu_m2 ),
> PreCompose( kF.nu_m2, kF.dV_m2 ) - PreCompose( kF.dU_m2, kF.nu_m1 ),
> PreCompose( kF.nu_m1, kF.dV_m1 ) - PreCompose( kF.dU_m1, kF.nu_0 ),
> PreCompose( kF.nu_0, kF.dV_0 ) - PreCompose( kF.dU_0, kF.nu_1 ),
> PreCompose( kF.nu_1, kF.dV_1 ),
> PreCompose( kF.g_m4, kF.dV_m4 ) - PreCompose( kF.dB_m4, kF.g_m3 ),
> PreCompose( kF.g_m3, kF.dV_m3 ) - PreCompose( kF.dB_m3, kF.g_m2 ),
> PreCompose( kF.g_m2, kF.dV_m2 ) - PreCompose( kF.dB_m2, kF.g_m1 ),
> PreCompose( kF.g_m1, kF.dV_m1 ) - PreCompose( kF.dB_m1, kF.g_0 ),
> PreCompose( kF.g_0, kF.dV_0 ) - PreCompose( kF.dB_0, kF.g_1 ),
> PreCompose( kF.g_1, kF.dV_1 ),
> PreCompose( kF.f_m3, kF.nu_m3 ) - PreCompose( kF.alpha_m3, kF.g_m3 ),
> PreCompose( kF.f_m2, kF.nu_m2 ) - PreCompose( kF.alpha_m2, kF.g_m2 ),
> PreCompose( kF.f_m1, kF.nu_m1 ) ];;
gap> oid := AlgebroidFromDataTables( kF / rels );;
gap> Aoid := AdditiveClosure( oid );;
gap> AAoid := AdelmanCategory( Aoid );;
gap> Ch_AAoid := ComplexesCategoryByCochains( AAoid );;
gap> for object_info in objects do
>       MakeReadWriteGlobal( object_info[1] );
>       DeclareSynonym( object_info[1],
>         CreateComplex(
>            Ch_AAoid,
>            List( [ object_info[2][1] .. object_info[2][2] - 1 ],
>              i -> oid.( Concatenation( "d", object_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / Aoid / AAoid ),
>            object_info[2][1] ) );
>    od;
gap> for morphism_info in morphisms do
>       MakeReadWriteGlobal( morphism_info[1] );
>       DeclareSynonym( morphism_info[1],
>         CreateComplexMorphism(
>            Ch_AAoid,
>            EvalString( objects[morphism_info[2][1]][1] ),
>            List( [ morphism_info[4][1] .. morphism_info[4][2] ], i -> oid.( Concatenation( morphism_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / Aoid / AAoid ),
>            morphism_info[4][1],
>            EvalString( objects[morphism_info[2][2]][1] ) ) );
>    od;
gap> Assert( 0, ForAll( [ f, g, alpha, nu ], IsWellDefined ) and IsZeroForMorphisms( PreCompose( alpha, g ) - PreCompose( f, nu ) ) );
gap> lambda := KernelObjectFunctorial( alpha, f, nu );;
gap> Assert( 0, IsWellDefined( lambda ) and IsZeroForMorphisms( PreCompose( KernelEmbedding( alpha ), f ) - PreCompose( lambda, KernelEmbedding( nu ) ) ) );
gap> lambda := CokernelObjectFunctorial( alpha, g, nu );;
gap> Assert( 0, IsWellDefined( lambda ) and IsZeroForMorphisms( PreCompose( CokernelProjection( alpha ), lambda ) - PreCompose( g, CokernelProjection( nu ) ) ) );
gap> u := UniversalMorphismIntoFiberProduct( Ch_AAoid, [ g, nu ], A, [ alpha, f ] );;
gap> Assert( 0, IsWellDefined( u ) );
gap> u := UniversalMorphismFromPushout( Ch_AAoid, [ alpha, f ], V, [ g, nu ] );;
gap> Assert( 0, IsWellDefined( u ) );
gap> SetInfoLevel( InfoWarning, 1 );
