ReadPackage( "StableCategories", "examples/doc/CategoryOfArrows.g" );

#! @Chunk category_of_arrows_of_additive_closure_of_algeboid
#!
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A_1 \arrow[rrr, "\alpha" description] \arrow[dd, "\phi_1" description] \arrow[rrr, "u" description, bend left] \arrow[dd, "\psi_1" description, bend left=49] \arrow[dd, "\tau" description, bend right=49] &  &  & A_2 \arrow[dd, "\phi_2" description] \arrow[lll, "v" description, bend right=49, shift right] \arrow[dd, "\psi_2" description, bend left=49] \arrow[llldd, "w" description] \\
#! {}                                                                                                                                                                                                          &  &  &                                                                                                                                                                             \\
#! B_1 \arrow[rrr, "\beta" description]                                                                                                                                                                        &  &  & B_2                                                                                                                                                                        
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Example
ReadPackage( "StableCategories", "examples/doc/CategoryOfArrows.g" );
#! true
MAKE_READ_WRITE_GLOBAL( "REREADING" );
REREADING := true;;
SetInfoLevel( InfoWarning, 0 );

vertices := [ "A_1", "A_2", "B_1", "B_2" ];;
sources := [ 1, 1, 1, 1, 1, 2, 2, 2, 2, 3 ];;
targets := [ 2, 2, 3, 3, 3, 1, 3, 4, 4, 4 ];;
arrows :=  [ "u", "alpha",   "tau", "phi_1", "psi_1",
             "v", "w", "phi_2", "psi_2", "beta" ];;
quiver := RightQuiver( "quiver", vertices, arrows, sources, targets );
#! quiver(A_1,A_2,B_1,B_2)[u:A_1->A_2,alpha:A_1->A_2,tau:A_1->B_1,phi_1:A_1->B_1,
#! psi_1:A_1->B_1,v:A_2->A_1,w:A_2->B_1,phi_2:A_2->B_2,psi_2:A_2->B_2,beta:B_1->B_2]
QQ := HomalgFieldOfRationals( );
#! Q
oid := Algebroid( QQ, quiver );;
AssignSetOfObjects( oid );
AssignSetOfGeneratingMorphisms( oid );
rels := [
              PreCompose( v, alpha ),
              PreCompose( v, tau ),
              PreCompose( v, phi_1 ),
              PreCompose( v, psi_1 ),
              PreCompose( v, u ) - IdentityMorphism( A_2 ),
              PreCompose( alpha, phi_2 ) - PreCompose( phi_1, beta ),
              PreCompose( alpha, phi_2 ) - PreCompose( tau, beta ),
              PreCompose( alpha, psi_2 ) - PreCompose( psi_1, beta ),
              PreCompose( w, beta ) - psi_2
           ];
#! [ (A_2)-[1*(v*alpha)]->(A_2), (A_2)-[1*(v*tau)]->(B_1),
#!   (A_2)-[1*(v*phi_1)]->(B_1), (A_2)-[1*(v*psi_1)]->(B_1), 
#!   (A_2)-[1*(v*u) - 1*(A_2)]->(A_2),
#!   (A_1)-[-1*(phi_1*beta) + 1*(alpha*phi_2)]->(B_2), 
#!   (A_1)-[-1*(tau*beta) + 1*(alpha*phi_2)]->(B_2),
#!   (A_1)-[-1*(psi_1*beta) + 1*(alpha*psi_2)]->(B_2), 
#!   (A_2)-[1*(w*beta) - 1*(psi_2)]->(B_2) ]
oid := oid / rels;;
oid!.Name := "Algebroid( V=4, E=10, Rel=7 )";;
AssignSetOfObjects( oid );
AssignSetOfGeneratingMorphisms( oid );
Aoid := AdditiveClosure( oid );
#! Additive closure( Algebroid( V=4, E=10, Rel=7 ) )
AAoid := CategoryOfArrows( Aoid );
#! The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )
1_m_2 := Source( AAoid );
#! Algebroid( q(2)[m:1->2] )
Aoid = Range( AAoid );
#! true
A := CategoryOfArrowsObject( AAoid, [ [ alpha ] ] / Aoid );
#! <An object in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsZero( A );
#! false
B := CategoryOfArrowsObject( AAoid, [ [ beta ] ] / Aoid );
#! <An object in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsZero( B );
#! false
phi := CategoryOfArrowsMorphism(
            A,
            [ [ phi_1 ] ] / Aoid,
            [ [ phi_2 ] ] / Aoid,
            B
        );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
psi := CategoryOfArrowsMorphism(
            A,
            [ [ psi_1 ] ] / Aoid,
            [ [ psi_2 ] ] / Aoid,
            B
        );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsWellDefined( phi );
#! true
IsWellDefined( psi );
#! true
Q_A := ColiftingObject( A );
#! <An object in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
Q_B := ColiftingObject( B );
#! <An object in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
q_A := MorphismToColiftingObjectWithGivenColiftingObject( A, Q_A );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
q_B := MorphismToColiftingObjectWithGivenColiftingObject( B, Q_B );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
Q_phi := ColiftingMorphismWithGivenColiftingObjects( Q_A, phi, Q_B );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsCongruentForMorphisms( PreCompose( q_A, Q_phi ), PreCompose( phi, q_B ) );
#! true
Q_psi := ColiftingMorphismWithGivenColiftingObjects( Q_A, psi, Q_B );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsCongruentForMorphisms( PreCompose( q_A, Q_psi ), PreCompose( psi, q_B ) );
#! true
IsSplitEpimorphism( [ [ u ] ] / Aoid );
#! true
U := CategoryOfArrowsObject( AAoid, [ [ u ] ] / Aoid );
#! <An object in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsZero( U );
#! false
Q_U := ColiftingObject( U );
#! <An object in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
q_U := MorphismToColiftingObjectWithGivenColiftingObject( U, Q_U );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsSplitMonomorphism( q_U );
#! true
r_U := RetractionOfMorphismToColiftingObject( U );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsWellDefined( r_U );
#! true
IsCongruentForMorphisms( PreCompose( q_U, r_U ), IdentityMorphism( U ) );
#! true
St_AAoid := StableCategoryBySystemOfColiftingObjects( AAoid );
#! Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects
class_A := StableCategoryObject( St_AAoid, A );
#! <An object in Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects>
IsZero( class_A );
#! false
class_B := StableCategoryObject( St_AAoid, B );
#! <An object in Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects>
IsZero( class_B );
#! false
class_U := StableCategoryObject( St_AAoid, U );
#! <An object in Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects>
IsZero( class_U );
#! true
class_phi := StableCategoryMorphism( class_A, phi, class_B );
#! <A morphism in Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects>
IsZeroForMorphisms( class_phi );
#! false
class_psi := StableCategoryMorphism( class_A, psi, class_B );
#! <A morphism in Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects>
IsZeroForMorphisms( class_psi );
#! true
IsLiftable( [ [ psi_2 ] ] / Aoid, [ [ beta ] ] / Aoid );
#! true
IsCongruentForMorphisms(
    PreCompose( [ [ w ] ] / Aoid, [ [ beta ] ] / Aoid ),
    [ [ psi_2 ] ] / Aoid
  );
#! true
HomStructure( A, B );
#! <A vector space object over Q of dimension 4>
HomStructure( class_A, class_B );
#! <A vector space object over Q of dimension 1>
Hom_class_A_class_B := BasisOfExternalHom( class_A, class_B );
#! [ <A morphism in Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects> ]
Display( Hom_class_A_class_B[ 1 ] );
#! A morphism in Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects defined by the underlying morphism:
#! 
#! A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )
#! defined by the following data:
#! 
#! Image of <(1)>:
#! A 1 x 1 matrix with entries in Algebroid( V=4, E=10, Rel=7 )
#! 
#! [1,1]: (A_1)-[{ 1*(tau) }]->(B_1)
#! 
#! Image of <(2)>:
#! A 1 x 1 matrix with entries in Algebroid( V=4, E=10, Rel=7 )
#! 
#! [1,1]: (A_2)-[{ 1*(phi_2) }]->(B_2)
Freyd_Aoid := FreydCategory( Aoid );
#! Freyd( Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) )
FA := FreydCategoryObject( [ [ alpha ] ] / Aoid );
#! <An object in Freyd( Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) )>
FB := FreydCategoryObject( [ [ beta ] ] / Aoid );
#! <An object in Freyd( Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) )>
HomStructure( FA, FB );
#! <A vector space object over Q of dimension 1>
Hom_FA_FB := BasisOfExternalHom( FA, FB );
#! [ <A morphism in Freyd( Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) )> ]
Display( Hom_FA_FB[1] );
#! 
#! --------------------------------
#! Source:
#! --------------------------------
#! 
#! A 1 x 1 matrix with entries in Algebroid( V=4, E=10, Rel=7 )
#! 
#! [1,1]: (A_1)-[{ 1*(alpha) }]->(A_2)
#! 
#! --------------------------------
#! Morphism datum:
#! --------------------------------
#! 
#! A 1 x 1 matrix with entries in Algebroid( V=4, E=10, Rel=7 )
#! 
#! [1,1]: (A_2)-[{ 1*(phi_2) }]->(B_2)
#! 
#! --------------------------------
#! Range:
#! --------------------------------
#! 
#! A 1 x 1 matrix with entries in Algebroid( V=4, E=10, Rel=7 )
#! 
#! [1,1]: (B_1)-[{ 1*(beta) }]->(B_2)
#! 
#! --------------------------------
#! General description:
#! --------------------------------
#! 
#! A morphism in Freyd( Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) )
#! @EndExample
