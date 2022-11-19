gap> MAKE_READ_WRITE_GLOBAL( "REREADING" );
gap> REREADING := true;;
gap> SetInfoLevel( InfoWarning, 0 );
gap> k := HomalgFieldOfRationals( );;
gap> objects := [ [ "A", [ -5, 5 ] ], [ "B", [ -2, 2 ] ], [ "C", [ -2, 2 ] ], [ "D", [ -5, 5 ] ] ];;
gap> morphisms := [ [ "x", [ 1, 2 ], -1, [ -1, 3 ], "x" ], [ "alpha", [ 1, 2 ], 0, [ -2, 2 ], "\\alpha" ], [ "y", [ 3, 4 ], -1, [ -2, 2 ], "y" ], [ "beta", [ 3, 4 ], 0, [ -2, 2 ], "\\beta" ] ];;
gap> relations := [  [ "alpha - Differential( x )", 1 ], [ "Differential( alpha )", 1 ], [ "beta - Differential( y )", 3 ], [ "Differential( beta )", 3 ] ];;
gap> q := RightQuiver( "q(A_m5,A_m4,A_m3,A_m2,A_m1,A_0,A_1,A_2,A_3,A_4,A_5,B_m2,B_m1,B_0,B_1,B_2,C_m2,C_m1,C_0,C_1,C_2,D_m5,D_m4,D_m3,D_m2,D_m1,D_0,D_1,D_2,D_3,D_4,D_5)[dA_m5:A_m5->A_m4,dA_m4:A_m4->A_m3,dA_m3:A_m3->A_m2,dA_m2:A_m2->A_m1,dA_m1:A_m1->A_0,dA_0:A_0->A_1,dA_1:A_1->A_2,dA_2:A_2->A_3,dA_3:A_3->A_4,dA_4:A_4->A_5,dB_m2:B_m2->B_m1,dB_m1:B_m1->B_0,dB_0:B_0->B_1,dB_1:B_1->B_2,dC_m2:C_m2->C_m1,dC_m1:C_m1->C_0,dC_0:C_0->C_1,dC_1:C_1->C_2,dD_m5:D_m5->D_m4,dD_m4:D_m4->D_m3,dD_m3:D_m3->D_m2,dD_m2:D_m2->D_m1,dD_m1:D_m1->D_0,dD_0:D_0->D_1,dD_1:D_1->D_2,dD_2:D_2->D_3,dD_3:D_3->D_4,dD_4:D_4->D_5,x_m1:A_m1->B_m2,x_0:A_0->B_m1,x_1:A_1->B_0,x_2:A_2->B_1,x_3:A_3->B_2,alpha_m2:A_m2->B_m2,alpha_m1:A_m1->B_m1,alpha_0:A_0->B_0,alpha_1:A_1->B_1,alpha_2:A_2->B_2,y_m2:C_m2->D_m3,y_m1:C_m1->D_m2,y_0:C_0->D_m1,y_1:C_1->D_0,y_2:C_2->D_1,beta_m2:C_m2->D_m2,beta_m1:C_m1->D_m1,beta_0:C_0->D_0,beta_1:C_1->D_1,beta_2:C_2->D_2]" );;
gap> F := FreeCategory( q );;
gap> kF := k[F];;
gap> AssignSetOfObjects( kF );;
gap> AssignSetOfGeneratingMorphisms( kF );;
gap> rels := [ ];;
gap> oid := kF / rels;;
gap> Aoid := AdditiveClosure( oid );;
gap> Ch_Aoid := ComplexesCategoryByCochains( Aoid );;
gap> for object_info in objects do
>       MakeReadWriteGlobal( object_info[1] );
>       DeclareSynonym( object_info[1],
>         CreateComplex(
>            Ch_Aoid,
>            List( [ object_info[2][1] .. object_info[2][2] - 1 ],
>              i -> oid.( Concatenation( "d", object_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / Aoid ),
>            object_info[2][1] ) );
>    od;
gap> for morphism_info in [ morphisms[2], morphisms[4] ] do
>       MakeReadWriteGlobal( morphism_info[1] );
>       DeclareSynonym( morphism_info[1],
>         CreateComplexMorphism(
>            Ch_Aoid,
>            EvalString( objects[morphism_info[2][1]][1] ),
>            EvalString( objects[morphism_info[2][2]][1] ),
>            List( [ morphism_info[4][1] .. morphism_info[4][2] ], i -> oid.( Concatenation( morphism_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / Aoid ),
>            morphism_info[4][1] ) );
>    od;
gap> ForAll( [ alpha, beta ], IsHomotopicToZeroMorphism );
true
gap> MorphismMatrix( WitnessForBeingHomotopicToZeroMorphism( DirectSumFunctorial( [ alpha, beta ] ) )[0] );
[ [ (A_0)-[{ 1*(x_0) }]->(B_m1), (A_0)-[{ 0 }]->(D_m1) ], [ (C_0)-[{ 0 }]->(B_m1), (C_0)-[{ 1*(y_0) }]->(D_m1) ] ]
