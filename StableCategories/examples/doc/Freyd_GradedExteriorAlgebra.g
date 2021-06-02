#! @Chunk freyd_categories_graded_exterior_algebra

LoadPackage( "FreydCategoriesForCAP" );
LoadPackage( "StableCategories" );
LoadPackage( "ModulePresentations" );

EnhancePackage( "FreydCategoriesForCAP" );

#! @Example
Q := HomalgFieldOfRationalsInSingular( );
#! Q
EEE := KoszulDualRing( GradedRing( Q * "x,y" ) );
#! Q{e0,e1}
#! (weights: [ -1, -1 ])
Grows_E := CategoryOfGradedRows( EEE );
#! Graded rows( Q{e0,e1} (with weights [ -1, -1 ]) )
Grmod_E := FreydCategory( Grows_E );
#! Category of f.p. graded left modules over Q{e0,e1} (with weights [ -1, -1 ])
IsExactCategory( Grmod_E );
#! true
sU := GradedRow( [ [ [1], 2 ] ], EEE );
#! <A graded row of rank 2>
rU := GradedRow( [ [ [0], 2 ] ], EEE );
#! <A graded row of rank 2>
mU := HomalgMatrix( "[[2*e0,4*e0+e1],[-e0+e1,-e0]]", 2, 2, EEE );
#! <A 2 x 2 matrix over a graded ring>
U := GradedRowOrColumnMorphism( sU, mU, rU ) / Grmod_E;
#! <An object in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsWellDefined( U );
#! true
sV := GradedRow( [ [ [1], 1 ], [ [0], 1 ] ], EEE );
#! <A graded row of rank 2>
rV := GradedRow( [ [ [-1], 1 ], [ [0], 1 ] ], EEE );
#! <A graded row of rank 2>
mV := HomalgMatrix( "[[0,-2*e0],[e0+e1,0]]", 2, 2, EEE );
#! <A 2 x 2 matrix over a graded ring>
V := GradedRowOrColumnMorphism( sV, mV, rV ) / Grmod_E;
#! <An object in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsWellDefined( V );
#! true
mat := HomalgMatrix( "[[-e1,0],[-e1,0]]", 2, 2, EEE );
#! <A 2 x 2 matrix over a graded ring>
mu := GradedRowOrColumnMorphism( rU, mat, rV );
#! <A morphism in Category of graded rows over Q{e0,e1} (with weights [ -1, -1 ])>
mu := FreydCategoryMorphism( U, mu, V );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsWellDefined( mu );
#! true
IsConflationPair( ExactKernelEmbedding( mu ), mu );
#! false
IsConflationPair( mu, ExactCokernelProjection( mu ) );
#! false
iota := KernelEmbedding( mu );
#! <A monomorphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
pi_iota := ExactCokernelProjection( iota );
#! <An epimorphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsConflationPair( iota, pi_iota );
#! true
pi := CokernelProjection( mu );
#! <An epimorphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
iota_pi := ExactKernelEmbedding( pi );
#! <A monomorphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsConflationPair( iota_pi, pi );
#! true
lambda := ExactCokernelColift( iota, mu );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms( PreCompose( pi_iota, lambda ), mu );
#! true
lambda := ExactKernelLift( pi, mu );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms( PreCompose( lambda, iota_pi ), mu );
#! true
#! @EndExample


#! @Chunk freyd_categories_graded_exterior_algebra-fiber-product

#! @Example
alpha := mu;
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
B := Source( alpha );
#! <An object in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
C := Range( alpha );
#! <An object in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
pi := EpimorphismFromSomeProjectiveObject( C );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
p_A := ProjectionInFirstFactorOfExactFiberProduct( pi, alpha );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
p_B := ProjectionInSecondFactorOfExactFiberProduct( pi, alpha );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms( PreCompose( p_A, pi ), PreCompose( p_B, alpha ) );
#! true
pprime_B := EpimorphismFromSomeProjectiveObject( B );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
pprime_A := ProjectiveLift( PreCompose( pprime_B, alpha ), pi );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms(
      PreCompose( pprime_A, pi ), PreCompose( pprime_B, alpha )
  );
#! true
u := UniversalMorphismIntoExactFiberProduct( pi, alpha, pprime_A, pprime_B );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms( PreCompose( u, p_B ), pprime_B );
#! true
IsCongruentForMorphisms( PreCompose( u, p_A ), pprime_A );
#! true
IsIsomorphism( u );
#! false
#! @EndExample


#! @Chunk freyd_categories_graded_exterior_algebra-pushout

#! @Example
alpha := mu;
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
C := Source( alpha );
#! <An object in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
B := Range( alpha );
#! <An object in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
iota := MonomorphismIntoSomeInjectiveObject( C );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
q_A := InjectionOfFirstCofactorOfExactPushout( iota, alpha );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
q_B := InjectionOfSecondCofactorOfExactPushout( iota, alpha );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms( PreCompose( iota, q_A ), PreCompose( alpha, q_B ) );
#! true
qprime_B := MonomorphismIntoSomeInjectiveObject( B );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
qprime_A := InjectiveColift( iota, PreCompose( alpha, qprime_B ) );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms(
      PreCompose( iota, qprime_A ), PreCompose( alpha, qprime_B )
  );
#! true
u := UniversalMorphismFromExactPushout( iota, alpha, qprime_A, qprime_B );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms( PreCompose( q_A, u ), qprime_A );
#! true
IsCongruentForMorphisms( PreCompose( q_B, u ), qprime_B );
#! true
IsIsomorphism( u );
#! false
#! @EndExample

#! @Chunk freyd_categories_graded_exterior_algebra-exact-projectives

#! @Example
pi := CokernelProjection( mu );
#! <An epimorphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsConflationPair( ExactKernelEmbedding( pi ), pi );
#! true
C := Range( pi );
#! <An object in Category of f.p. graded left modules over Q{e0,e1} 
#! (with weights [ -1, -1 ])>
P := GradedRow( [ [ [0], 2 ], [ [1], 1 ] ], EEE );
#! <A graded row of rank 3>
P := AsFreydCategoryObject( P );
#! <A projective object in Category of f.p. graded left modules over Q{e0,e1} 
#! (with weights [ -1, -1 ])>
IsExactProjectiveObject( P );
#! true
Hom_PC := BasisOfExternalHom( P, C );;
Size( Hom_PC );
#! 3
tau := Random( Hom_PC );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
lambda := ExactProjectiveLift( tau, pi );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms( PreCompose( lambda, pi ), tau );
#! true
#! @EndExample


#! @Chunk freyd_categories_graded_exterior_algebra-enough-exact-projectives

#! @Example
IsExactCategoryWithEnoughExactProjectives( Grmod_E );
#! true
V;
#! <An object in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
P_V := SomeExactProjectiveObject( U );
#! <A projective object in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsExactProjectiveObject( P_V );
#! true
pi_V := DeflationFromSomeExactProjectiveObject( V );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsConflationPair( ExactKernelEmbedding( pi_V ), pi_V );
#! true
#! @EndExample

#! @Chunk freyd_categories_graded_exterior_algebra-exact-injectives

#! @Example
iota := KernelEmbedding( mu );
#! <A monomorphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsConflationPair( iota, ExactCokernelProjection( iota ) );
#! true
A := Source( iota );
#! <An object in Category of f.p. graded left modules over Q{e0,e1} 
#! (with weights [ -1, -1 ])>
I := GradedRow( [ [ [0], 2 ], [ [-1], 2 ], [ [-2], 1 ] ], EEE );
#! <A graded row of rank 5>
I := AsFreydCategoryObject( I );
#! <A projective object in Category of f.p. graded left modules over Q{e0,e1} 
#! (with weights [ -1, -1 ])>
IsExactInjectiveObject( I );
#! true
Hom_AI := BasisOfExternalHom( A, I );;
Size( Hom_AI );
#! 5
tau := Random( Hom_AI );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
lambda := ExactInjectiveColift( iota, tau );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms( PreCompose( iota, lambda ), tau );
#! true
#! @EndExample

#! @Chunk freyd_categories_graded_exterior_algebra-enough-exact-injectives

#! @Example
IsExactCategoryWithEnoughExactInjectives( Grmod_E );
#! true
U;
#! <An object in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
I_U := SomeExactInjectiveObject( U );
#! <An object in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsExactInjectiveObject( I_U );
#! true
iota_U := InflationIntoSomeExactInjectiveObject( U );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsConflationPair( iota_U, ExactCokernelProjection( iota_U ) );
#! true
#! @EndExample

#! @Chunk freyd_categories_graded_exterior_algebra-enough-exact-projectives-liftable-along-deflation

#! @Example
V = Range( mu );
#! true
pi_V := DeflationFromSomeExactProjectiveObject( V );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsLiftableAlongDeflationFromSomeExactProjectiveObject( mu );
#! true
lambda := LiftAlongDeflationFromSomeExactProjectiveObject( mu );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms( PreCompose( lambda, pi_V ), mu );
#! true
#! @EndExample

#! @Chunk freyd_categories_graded_exterior_algebra-enough-exact-injectives-coliftable-along-inflation

#! @Example
U = Source( mu );
#! true
iota_U := InflationIntoSomeExactInjectiveObject( U );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsColiftableAlongInflationIntoSomeExactInjectiveObject( mu );
#! true
lambda := ColiftAlongInflationIntoSomeExactInjectiveObject( mu );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms( PreCompose( iota_U, lambda ), mu );
#! true
#! @EndExample

#? @Chunk freyd_categories_graded_exterior_algebra-is-frobenius
#? @Example
IsFrobeniusCategory( Grmod_E );
#? true
#? @EndExample

#! @Chunk freyd_categories_graded_exterior_algebra-lifting-system

#! @Example
alpha := mu;
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
A := Source( alpha );
#! <An object in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
B := Range( alpha );
#! <An object in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
ell_A := MorphismFromLiftingObject( A );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
ell_B := MorphismFromLiftingObject( B );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
L_alpha := LiftingMorphism( alpha );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms(
      PreCompose( L_alpha, ell_B ), PreCompose( ell_A, alpha ) 
    );
#! true
IsLiftableAlongMorphismFromLiftingObject( alpha );
#! true
lambda := WitnessForBeingLiftableAlongMorphismFromLiftingObject( alpha );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms( PreCompose( lambda, ell_B ), alpha );
#! true
#! @EndExample

#! @Chunk freyd_categories_graded_exterior_algebra-colifting-system

#! @Example
alpha := mu;
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
A := Source( alpha );
#! <An object in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
B := Range( alpha );
#! <An object in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
q_A := MorphismToColiftingObject( A );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
q_B := MorphismToColiftingObject( B );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
Q_alpha := ColiftingMorphism( alpha );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms(
      PreCompose( q_A, Q_alpha ), PreCompose( alpha, q_B )
    );
#! true
IsColiftableAlongMorphismToColiftingObject( alpha );
#! true
lambda := WitnessForBeingColiftableAlongMorphismToColiftingObject( alpha );
#! <A morphism in Category of f.p. graded left modules over Q{e0,e1}
#! (with weights [ -1, -1 ])>
IsCongruentForMorphisms( PreCompose( q_A, lambda ), alpha );
#! true
#! @EndExample

