ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );
BB := BeilinsonFunctor( S );
Ho_C := AsCapCategory( Range( BB ) );
Ch_C := UnderlyingCategory( Ho_C );
C := DefiningCategory( Ho_C );
indec_C := FullSubcategoryGeneratedByIndecProjectiveObjects( C );

#################################

Eq := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( C );
Eq := ExtendFunctorToHomotopyCategories( Eq );
Loc := PreCompose( LocalizationFunctorByProjectiveObjects( HomotopyCategory( C ) ), Eq );

################ create the collection o(0), o(1), o(2) as objects in abelian category #####################
o := TwistedGradedFreeModule( S, 0 );
l := List( [ 0, 1, 2 ], i -> ApplyFunctor( BB, o[ i ] ) );
o_012_ab := List( l, c -> HomologyAt( c, 0 ) );
name := Concatenation( "Full subcategory generated by 𝓞 (i)|i=0,1,2 as objects in ", Name( C ) );

o_012_ab := FullSubcategoryGeneratedByListOfObjects( o_012_ab : name_of_full_subcategory := name );
add_o_012_ab := AdditiveClosure( o_012_ab );
ho_o_012_ab := HomotopyCategory( add_o_012_ab );

Emb := EmbeddingFunctorInHomotopyCategory( C );
Emb := PreCompose( Emb, Loc );
Emb!.Name := "Localisation functor";
Emb := RestrictFunctorToFullSubcategoryOfSource( Emb, o_012_ab );
Emb!.Name := "Restriction of Localisation functor";

name_for_quiver := "quiver{𝓞 (0) -{3}-> 𝓞 (1) -{3}-> 𝓞 (2) as objects in abelian category}";
name_for_algebra := "End( ⊕ {𝓞 (i)|i=0,1,2 as objects in abelian category} )";
collection_ab := CreateStrongExcepptionalCollection( o_012_ab : name_for_underlying_quiver := name_for_quiver,
                                              name_for_endomorphism_algebra := name_for_algebra
                                          );

o_012_ho := ImageOfFullyFaithfullFunctor( Emb );
o_012_ho!.Name := Concatenation( "Full subcategory generated by 𝓞 (i)|i=0,1,2 as objects in ",
                    Name( AmbientCategory( o_012_ho ) ) );

name_for_quiver := "quiver{𝓞 (0) -{3}-> 𝓞 (1) -{3}-> 𝓞 (2) as objects in homotopy category}";
name_for_algebra := "End( ⊕ {𝓞 (i)|i=0,1,2 as objects in homotopy category} )";
collection_ho := CreateStrongExcepptionalCollection( o_012_ho : name_for_underlying_quiver := name_for_quiver,
                                              name_for_endomorphism_algebra := name_for_algebra
                                          );

add_o_012_ho := AdditiveClosure( o_012_ho );
ho_o_012_ho := HomotopyCategory( add_o_012_ho );

I := IsomorphismOntoImageOfFullyFaithfulFunctor( Emb );
J := IsomorphismFromImageOfFullyFaithfulFunctor( Emb );

add_I := ExtendFunctorToAdditiveClosures( I );
add_J := ExtendFunctorToAdditiveClosures( J );

ho_add_I := ExtendFunctorToHomotopyCategories( add_I );
ho_add_J := ExtendFunctorToHomotopyCategories( add_J );

##################### Embedd both homotopy categories in ambient homotopy category ###########

# ho_o_012_ab
inc_ab := InclusionFunctor( o_012_ab );
inc_ab := ExtendFunctorToAdditiveClosureOfSource( inc_ab );
inc_ab := ExtendFunctorToHomotopyCategories( inc_ab );

# ho_0_012_ho
inc_ho := ConvolutionFunctor( collection_ho );
inc_ho := PreCompose(
            inc_ho,
            ExtendFunctorToHomotopyCategories(
              ExtendFunctorToAdditiveClosureOfSource(
                InclusionFunctor( indec_C )
              )
            )
          );

################## to create random objects ################################
U := ExtendFunctorToHomotopyCategories(
      ExtendFunctorToAdditiveClosures(
        IsomorphismFromAlgebroid( collection_ab )
          ) );
quit;
# create random object
c := U( RandomObject( AsCapCategory( Source( U ) ), 3 ) ); 
# or c := U( RandomObject( AsCapCategory( Source( U ) ), [ -3, 3, 2 ] ) );  [ lower_bound, upper_bound, complexity ]

################# compare between embeddings of the two replacements #######
inc_ab_c := inc_ab(c);
inc_ho_c := PreCompose( ho_add_I, inc_ho )(c);
HomologySupport( inc_ab_c );
