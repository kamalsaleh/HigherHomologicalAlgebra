gap> MAKE_READ_WRITE_GLOBAL( "REREADING" );
gap> REREADING := true;;
gap> SetInfoLevel( InfoWarning, 0 );
gap> k := HomalgFieldOfRationals( );;
gap> objects := [ [ "A", [ -2, 2 ] ], [ "B", [ -2, 2 ] ], [ "C", [ -2, 2 ] ], [ "D", [ -2, 2 ] ] ];;
gap> morphisms := [ [ "alpha",  [ 1, 2 ],  0, [ -2, 2 ] ],
                    [ "beta",   [ 2, 4 ],  0, [ -2, 2 ] ],
                    [ "gamma",  [ 1, 4 ],  0, [ -2, 2 ] ],
                    [ "delta",  [ 1, 3 ],  0, [ -2, 2 ] ],
                    [ "lambda", [ 3, 4 ],  0, [ -2, 2 ] ],
                    [ "x",      [ 1, 4 ], -1, [ -1, 2 ] ],
                    [ "y",      [ 1, 4 ], -1, [ -1, 2 ] ],
                  ];;
gap> relations := [ [ "Differential( alpha )", 1 ],
                    [ "Differential( beta )",  2 ],
                    [ "Differential( gamma )", 1 ],
                    [ "Differential( delta )", 1 ],
                    [ "Differential( lambda )", 3 ],
                    [ "PreCompose( alpha, beta ) - PreCompose( delta, lambda ) - Differential( x )", 1 ],
                    [ "PreCompose( alpha, beta ) - gamma - Differential( y )", 1 ],
                  ];;
gap> q := RightQuiver( "q(A_m2,A_m1,A_0,A_1,A_2,B_m2,B_m1,B_0,B_1,B_2,C_m2,C_m1,C_0,C_1,C_2,D_m2,D_m1,D_0,D_1,D_2)[dA_m2:A_m2->A_m1,dA_m1:A_m1->A_0,dA_0:A_0->A_1,dA_1:A_1->A_2,dB_m2:B_m2->B_m1,dB_m1:B_m1->B_0,dB_0:B_0->B_1,dB_1:B_1->B_2,dC_m2:C_m2->C_m1,dC_m1:C_m1->C_0,dC_0:C_0->C_1,dC_1:C_1->C_2,dD_m2:D_m2->D_m1,dD_m1:D_m1->D_0,dD_0:D_0->D_1,dD_1:D_1->D_2,alpha_m2:A_m2->B_m2,alpha_m1:A_m1->B_m1,alpha_0:A_0->B_0,alpha_1:A_1->B_1,alpha_2:A_2->B_2,beta_m2:B_m2->D_m2,beta_m1:B_m1->D_m1,beta_0:B_0->D_0,beta_1:B_1->D_1,beta_2:B_2->D_2,gamma_m2:A_m2->D_m2,gamma_m1:A_m1->D_m1,gamma_0:A_0->D_0,gamma_1:A_1->D_1,gamma_2:A_2->D_2,delta_m2:A_m2->C_m2,delta_m1:A_m1->C_m1,delta_0:A_0->C_0,delta_1:A_1->C_1,delta_2:A_2->C_2,lambda_m2:C_m2->D_m2,lambda_m1:C_m1->D_m1,lambda_0:C_0->D_0,lambda_1:C_1->D_1,lambda_2:C_2->D_2,x_m1:A_m1->D_m2,x_0:A_0->D_m1,x_1:A_1->D_0,x_2:A_2->D_1,y_m1:A_m1->D_m2,y_0:A_0->D_m1,y_1:A_1->D_0,y_2:A_2->D_1]" );;
gap> F := FreeCategory( q );;
gap> kF := k[F];;
gap> AssignSetOfObjects( kF );;
gap> AssignSetOfGeneratingMorphisms( kF );;
gap> rels := [ PreCompose( dA_m2, dA_m1 ),
>  PreCompose( dA_m1, dA_0 ),
>  PreCompose( dA_0, dA_1 ),
>  PreCompose( dB_m2, dB_m1 ),
>  PreCompose( dB_m1, dB_0 ),
>  PreCompose( dB_0, dB_1 ),
>  PreCompose( dC_m2, dC_m1 ),
>  PreCompose( dC_m1, dC_0 ),
>  PreCompose( dC_0, dC_1 ),
>  PreCompose( dD_m2, dD_m1 ),
>  PreCompose( dD_m1, dD_0 ),
>  PreCompose( dD_0, dD_1 ),
> -PreCompose( alpha_m2, dB_m2 ) + PreCompose( dA_m2, alpha_m1 ),
> -PreCompose( alpha_m1, dB_m1 ) + PreCompose( dA_m1, alpha_0 ),
> -PreCompose( alpha_0, dB_0 ) + PreCompose( dA_0, alpha_1 ),
> -PreCompose( alpha_1, dB_1 ) + PreCompose( dA_1, alpha_2 ),
> -PreCompose( beta_m2, dD_m2 ) + PreCompose( dB_m2, beta_m1 ),
> -PreCompose( beta_m1, dD_m1 ) + PreCompose( dB_m1, beta_0 ),
> -PreCompose( beta_0, dD_0 ) + PreCompose( dB_0, beta_1 ),
> -PreCompose( beta_1, dD_1 ) + PreCompose( dB_1, beta_2 ),
> -PreCompose( gamma_m2, dD_m2 ) + PreCompose( dA_m2, gamma_m1 ),
> -PreCompose( gamma_m1, dD_m1 ) + PreCompose( dA_m1, gamma_0 ),
> -PreCompose( gamma_0, dD_0 ) + PreCompose( dA_0, gamma_1 ),
> -PreCompose( gamma_1, dD_1 ) + PreCompose( dA_1, gamma_2 ),
> -PreCompose( delta_m2, dC_m2 ) + PreCompose( dA_m2, delta_m1 ),
> -PreCompose( delta_m1, dC_m1 ) + PreCompose( dA_m1, delta_0 ),
> -PreCompose( delta_0, dC_0 ) + PreCompose( dA_0, delta_1 ),
> -PreCompose( delta_1, dC_1 ) + PreCompose( dA_1, delta_2 ),
> -PreCompose( lambda_m2, dD_m2 ) + PreCompose( dC_m2, lambda_m1 ),
> -PreCompose( lambda_m1, dD_m1 ) + PreCompose( dC_m1, lambda_0 ),
> -PreCompose( lambda_0, dD_0 ) + PreCompose( dC_0, lambda_1 ),
> -PreCompose( lambda_1, dD_1 ) + PreCompose( dC_1, lambda_2 ),
> -PreCompose( delta_m2, lambda_m2 ) + PreCompose( alpha_m2, beta_m2 ) - PreCompose( dA_m2, x_m1 ),
> -PreCompose( x_m1, dD_m2 ) - PreCompose( delta_m1, lambda_m1 ) + PreCompose( alpha_m1, beta_m1 ) - PreCompose( dA_m1, x_0 ),
> -PreCompose( x_0, dD_m1 ) - PreCompose( delta_0, lambda_0 ) + PreCompose( alpha_0, beta_0 ) - PreCompose( dA_0, x_1 ),
> -PreCompose( x_1, dD_0 ) - PreCompose( delta_1, lambda_1 ) + PreCompose( alpha_1, beta_1 ) - PreCompose( dA_1, x_2 ),
> -PreCompose( x_2, dD_1 ) - PreCompose( delta_2, lambda_2 ) + PreCompose( alpha_2, beta_2 ),
>  PreCompose( alpha_m2, beta_m2 ) - PreCompose( dA_m2, y_m1 ) - (gamma_m2),
> -PreCompose( y_m1, dD_m2 ) + PreCompose( alpha_m1, beta_m1 ) - PreCompose( dA_m1, y_0 ) - (gamma_m1),
> -PreCompose( y_0, dD_m1 ) + PreCompose( alpha_0, beta_0 ) - PreCompose( dA_0, y_1 ) - (gamma_0),
> -PreCompose( y_1, dD_0 ) + PreCompose( alpha_1, beta_1 ) - PreCompose( dA_1, y_2 ) - (gamma_1),
> -PreCompose( y_2, dD_1 ) + PreCompose( alpha_2, beta_2 ) - (gamma_2) ];;
gap> oid := kF / rels;;
gap> cat := AdditiveClosure( oid );;
gap> homotopy_cat := HomotopyCategoryByCochains( cat );;
gap> complex_cat := UnderlyingCategory( homotopy_cat );;
gap> for object_info in objects do
>       MakeReadWriteGlobal( object_info[1] );
>       DeclareSynonym( object_info[1],
>         ObjectConstructor(
>           homotopy_cat,
>           CreateComplex(
>             complex_cat,
>             List( [ object_info[2][1] .. object_info[2][2] - 1 ],
>               i -> oid.( Concatenation( "d", object_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / cat ),
>             object_info[2][1] ) ) );
>    od;
gap> for morphism_info in morphisms{[1..5]} do
>       MakeReadWriteGlobal( morphism_info[1] );
>       DeclareSynonym( morphism_info[1],
>         MorphismConstructor(
>           homotopy_cat,
>           EvalString( objects[morphism_info[2][1]][1] ),
>           CreateComplexMorphism(
>             complex_cat,
>             UnderlyingCell( EvalString( objects[morphism_info[2][1]][1] ) ),
>             UnderlyingCell( EvalString( objects[morphism_info[2][2]][1] ) ),
>             List( [ morphism_info[4][1] .. morphism_info[4][2] ], i -> oid.( Concatenation( morphism_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / cat ),
>             morphism_info[4][1] ),
>           EvalString( objects[morphism_info[2][2]][1] ) ) );
>    od;
