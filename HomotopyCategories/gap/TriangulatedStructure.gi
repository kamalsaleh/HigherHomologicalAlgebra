# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
#
#####################################################################

InstallGlobalFunction( ADD_FUNCTIONS_OF_TRIANGULATED_STRUCTURE_TO_HOMOTOPY_CATEGORY,

function( homotopy_cat )
  local cat, complex_cat, N;
  
  #SetFilterObj( homotopy_cat, IsTriangulatedCategory );
  
  cat := DefiningCategory( homotopy_cat );
  
  complex_cat := UnderlyingCategory( homotopy_cat );
  
  if IsChainComplexCategory( complex_cat ) then
      N := -1;
  else
      N := 1;
  fi;
  
  ## Adding the shift and reverse shift functors
  AddShiftOnObject( homotopy_cat,
    function( homotopy_cat, C )
      local objs, diffs;
      
      C := UnderlyingCell( C );
      
      objs := ApplyShift( Objects( C ), N );
      
      diffs := ApplyShift( ApplyMap( Differentials( C ), AdditiveInverseForMorphisms ), N );
      
      return ObjectConstructor( homotopy_cat, ObjectConstructor( complex_cat, [ objs, diffs, LowerBound( C ) - N, UpperBound( C ) - N ] ) );
      
  end );
  
  ##
  AddShiftOnMorphismWithGivenObjects( homotopy_cat,
    function( homotopy_cat, s, phi, r )
      local morphisms;
      
      phi := UnderlyingCell( phi );
      
      morphisms := ApplyShift( Morphisms( phi ), N );
      
      return MorphismConstructor( homotopy_cat, s, MorphismConstructor( complex_cat, UnderlyingCell( s ), [ morphisms, LowerBound( phi ) - N, UpperBound( phi ) - N ], UnderlyingCell( r ) ), r );
      
  end );
  
  ##
  AddInverseShiftOnObject( homotopy_cat,
    function( homotopy_cat, C )
      local objs, diffs;
      
      C := UnderlyingCell( C );
      
      objs := ApplyShift( Objects( C ), -N );
      
      diffs := ApplyShift( ApplyMap( Differentials( C ), AdditiveInverseForMorphisms ), -N );
      
      return ObjectConstructor( homotopy_cat, ObjectConstructor( complex_cat, [ objs, diffs, LowerBound( C ) + N, UpperBound( C ) + N ] ) );
      
  end );
  
  ##
  AddInverseShiftOnMorphismWithGivenObjects( homotopy_cat,
    function( homotopy_cat, s, phi, r )
      local morphisms;
      
      phi := UnderlyingCell( phi );
      
      morphisms := ApplyShift( Morphisms( phi ), -N );
      
      return MorphismConstructor( homotopy_cat, s, MorphismConstructor( complex_cat, UnderlyingCell( s ), [ morphisms, LowerBound( phi ) + N, UpperBound( phi ) + N ], UnderlyingCell( r ) ), r );
      
  end );
  
  ##
  #AddUnitIsomorphismWithGivenObject( homotopy_cat, { a, b } -> IdentityMorphism( a ) );
  
  #AddInverseOfUnitIsomorphismWithGivenObject( homotopy_cat, { a, b } -> IdentityMorphism( a ) );
  
  #AddCounitIsomorphismWithGivenObject( homotopy_cat, { a, b } -> IdentityMorphism( a ) );
  
  #AddInverseOfCounitIsomorphismWithGivenObject( homotopy_cat, { a, b } -> IdentityMorphism( a ) );
  
  AddStandardConeObject( homotopy_cat,
    function( homotopy_cat, phi )
      local B, C, objs, diffs, standard_cone;
      
      B := Source( phi );
      C := Range( phi );
      
      objs := AsZFunction( i -> DirectSum( cat, [ B[i+N], C[i] ] ) );
      
      diffs := AsZFunction( i ->
                  MorphismBetweenDirectSumsWithGivenDirectSums( cat,
                      objs[i],
                      [ B[i+N], C[i] ],
                      [ [ AdditiveInverseForMorphisms( cat, B^(i+N) ), phi[i+N] ], [ ZeroMorphism( cat, C[i], B[i+2*N] ), C^i ] ],
                      [ B[i+1+N], C[i+1] ],
                      objs[i+1] ) );
      
      standard_cone := CreateComplex( complex_cat, [ objs, diffs, Minimum( LowerBound( B ) - N, LowerBound( C ) ), Maximum( UpperBound( B ) - N, UpperBound( C ) ) ] );
      
      return ObjectConstructor( homotopy_cat, standard_cone );
      
  end );
  
  AddMorphismToStandardConeObjectWithGivenStandardConeObject( homotopy_cat,
    function( homotopy_cat, phi, standard_cone )
      local B, C, morphisms, iota;
      
      B := Source( phi );
      C := Range( phi );
      
      morphisms := AsZFunction( i ->
                      UniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
                          [ B[i+N], C[i] ],
                            C[i],
                          [ ZeroMorphism( cat, C[i], B[i+N] ), IdentityMorphism( cat, C[i] ) ],
                            standard_cone[i] ) );
      
      iota := CreateComplexMorphism(
                    complex_cat,
                    UnderlyingCell( C ),
                    UnderlyingCell( standard_cone ),
                  [ morphisms, Minimum( LowerBound( B ) - N, LowerBound( C ) ), Maximum( UpperBound( B ) - N, UpperBound( C ) ) ] );
      
      return MorphismConstructor( homotopy_cat, C, iota, standard_cone );
      
  end );
  
  #AddMorphismToStandardConeObject( homotopy_cat,
  #  function( phi )
  #    local cell;
  #
  #end );
  
  #AddMorphismFromStandardConeObjectWithGivenObjects( homotopy_cat,
  #  function( alpha, standard_cone, shift_B )
  #    local B, C, morphisms, iota;
  #    
  #    B := Source( alpha );
  #    C := Range( alpha );
  #    
  #    morphisms := AsZFunction( i ->
  #                    UniversalMorphismFromDirectSumWithGivenDirectSum( cat,
  #                        [ B[i+N], C[i] ],
  #                          B[i+N],
  #                        [ IdentityMorphism( cat, B[i+N] ), ZeroMorphism( cat, C[i], B[i+N] ) ],
  #                          standard_cone[i] ) );
  #    
  #    iota := CreateComplexMorphism(
  #                complex_cat,
  #                UnderlyingCell( standard_cone ),
  #                UnderlyingCell( shift_B ),
  #                [ morphisms, Minimum( LowerBound( B ) - N, LowerBound( C ) ), Maximum( UpperBound( B ) - N, UpperBound( C ) ) ] );
  #    
  #    return MorphismConstructor( homotopy_cat, standard_cone, iota, shift_B );
  #    
  #end );
  
  #AddMorphismFromStandardConeObject( homotopy_cat,
  #  function( alpha )
  #    local cell;
  #    
  #    cell := UnderlyingCell( alpha );
  #    
  #    return NaturalProjectionFromMappingCone( cell ) / homotopy_cat;
  #    
  #end );

# #   A ----- alpha ----> B ----------> Cone( alpha ) -----> Shift A
# #   |                   |                |                 |
# #   | mu                | nu             |                 | Shift( mu, 1 )
# #   |                   |                |                 |
# #   v                   v                v                 v
# #   A' ---- beta -----> B' ---------> Cone( beta  ) -----> Shift A'

  ###
  #AddMorphismBetweenStandardConeObjectsWithGivenObjects( homotopy_cat,
  #   function( s, list, r )
  #     local alpha, mu, nu, beta, homotopy_maps, maps;
  #     
  #     alpha := list[1];
  #     mu := list[2];
  #     nu := list[3];
  #     beta := list[4];
  #     
  #     homotopy_maps := HomotopyMorphisms( PreCompose( alpha, nu ) - PreCompose( mu, beta ) );
  #     
  #     maps := AsZFunction(
  #               function( i )
  #                 return
  #                   MorphismBetweenDirectSums(
  #                    [
  #                      [
  #                        mu[ i + N ],
  #                        homotopy_maps[ i + N ]
  #                      ],
  #                      [
  #                        ZeroMorphism( Source( nu )[ i ], Range( mu )[ i + N ] ),
  #                        nu[ i ]
  #                      ]
  #                    ] );
  #               end );
  #               
  #     return HomotopyCategoryMorphism( s, r, maps );
  #     
  #end );
  #
  ###
  #AddWitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects( homotopy_cat,
  #  function( s, alpha, r )
  #    local A, B, maps;
  #    
  #    A := Source( alpha );
  #    
  #    B := Range( alpha );
  #    
  #    maps := AsZFunction(
  #              function( i )
  #                return
  #                MorphismBetweenDirectSums(
  #                  [
  #                    [
  #                      AdditiveInverse( alpha[ i + N ] ),
  #                      IdentityMorphism( A[ i + N ] ),
  #                      ZeroMorphism( A[ i + N ], B[ i ] )
  #                    ]
  #                  ] );
  #              end );
  #              
  #    return HomotopyCategoryMorphism( s, maps, r );
  #    
  #end );

  ###
  #AddWitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects( homotopy_cat,
  #  function( s, alpha, r )
  #    local A, B, maps;
  #    
  #    A := Source( alpha );
  #    
  #    B := Range( alpha );
  #    
  #    maps := AsZFunction(
  #              function( i )
  #                return
  #                MorphismBetweenDirectSums(
  #                  [
  #                    [ ZeroMorphism( B[ i + N ], A[ i + N ] ) ],
  #                    [ IdentityMorphism( A[ i + N ] ) ],
  #                    [ ZeroMorphism( B[ i ], A[ i + N ] ) ]
  #                  ] );
  #                  
  #              end );
  #     
  #    return HomotopyCategoryMorphism( s, maps, r );
  #    
  #end );
  #
  ###
  #AddWitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects( homotopy_cat,
  #  function( s, alpha, r )
  #    local A, B, maps;
  #    
  #    A := Source( alpha );
  #    
  #    B := Range( alpha );
  #    
  #    maps := AsZFunction(
  #              function( i )
  #                return
  #                MorphismBetweenDirectSums(
  #                  [
  #                    [
  #                      ZeroMorphism( B[ i ], A[ i + N ] ),
  #                      IdentityMorphism( B[ i ] ),
  #                      ZeroMorphism( B[ i ], A[ i ] )
  #                    ]
  #                  ] );
  #              end );
  #              
  #    return HomotopyCategoryMorphism( s, maps, r );
  #      
  #end );

  ###
  #AddWitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects( homotopy_cat,
  #  function( s, alpha, r )
  #    local A, B, maps;
  #    
  #    A := Source( alpha );
  #    
  #    B := Range( alpha );
  #   
  #    maps := AsZFunction(
  #              function( i )
  #                return
  #                  MorphismBetweenDirectSums(
  #                    [
  #                      [ ZeroMorphism( A[ i + N ], B[ i ] ) ],
  #                      [ IdentityMorphism( B[ i ] ) ],
  #                      [ alpha[ i ] ]
  #                    ] );
  #              end );
  #              
  #    return HomotopyCategoryMorphism( s, maps, r );
  #      
  #end );
  #
  ### Can be derived, but here is a direct implementation    
  ###
  #AddDomainMorphismByOctahedralAxiomWithGivenObjects( homotopy_cat,
  #  function( s, alpha, beta, gamma, r )
  #    local A, id_A;
  #    
  #    A := Source( alpha );
  #    
  #    id_A := IdentityMorphism( A );
  #    
  #    return MorphismBetweenStandardConeObjectsWithGivenObjects( s, [ alpha, id_A, beta, gamma ], r );
  #    
  #end );
  #
  ###
  #AddMorphismToConeObjectByOctahedralAxiomWithGivenObjects( homotopy_cat,
  #  function( s, alpha, beta, gamma, r )
  #    local A, B, C, h, maps;
  #    
  #    A := Source( alpha );
  #    
  #    B := Range( alpha );
  #    
  #    C := Range( beta );
  #    
  #    h := HomotopyMorphisms( PreCompose( alpha, beta ) - gamma );
  #    
  #    maps := AsZFunction(
  #              i -> MorphismBetweenDirectSums(
  #                [
  #                  [
  #                    alpha[ i + N ],
  #                    -h[ i + N ]
  #                  ],
  #                  [
  #                    ZeroMorphism( C[ i ], B[ i + N ] ),
  #                    IdentityMorphism( C[ i ] )
  #                  ],
  #                ]
  #              )
  #            );
  #            
  #    return HomotopyCategoryMorphism( s, maps, r );
  #     
  #end );
  #
  ### Can be derived, but here is a direct implementation
  ###
  #AddMorphismFromConeObjectByOctahedralAxiomWithGivenObjects( homotopy_cat,
  #  function( s, alpha, beta, gamma, r )
  #    local A, B, C, maps;
  #    
  #    A := Source( alpha );
  #    
  #    B := Range( alpha );
  #    
  #    C := Range( beta );
  #    
  #    maps := AsZFunction(
  #              i -> MorphismBetweenDirectSums(
  #                [
  #                  [ 
  #                    ZeroMorphism( B[ i + N ], A[ i + 2 * N ] ),
  #                    IdentityMorphism( B[ i + N ] )
  #                  ],
  #                  [
  #                    ZeroMorphism( C[ i ], A[ i + 2 * N ]  ),
  #                    ZeroMorphism( C[ i ], B[ i + N ] )
  #                  ],
  #                ]
  #              ) 
  #            );
  #            
  #    return HomotopyCategoryMorphism( s, maps, r );
  #    
  #end );
  #
  ###
  #AddWitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects( homotopy_cat,
  #  function( s, alpha, beta, gamma, r )
  #    local A, B, C, maps;
  #    
  #    A := Source( alpha );
  #    
  #    B := Range( alpha );
  #    
  #    C := Range( beta );
  #   
  #    maps := AsZFunction(
  #              i -> MorphismBetweenDirectSums(
  #                [
  #                  [
  #                    ZeroMorphism( B[ i + N ], A[ i + 2 * N ] ),
  #                    IdentityMorphism( B[ i + N ] ),
  #                    ZeroMorphism( B[ i + N ], A[ i + N ] ),
  #                    ZeroMorphism( B[ i + N ], C[ i ] )
  #                  ],
  #                  [
  #                    ZeroMorphism( C[ i ] , A[ i + 2 * N ] ),
  #                    ZeroMorphism( C[ i ], B[ i + N ] ),
  #                    ZeroMorphism( C[ i ], A[ i + N ] ),
  #                    IdentityMorphism( C[ i ] )
  #                  ]
  #                ]
  #              )
  #            );
  #            
  #    return HomotopyCategoryMorphism( s, maps, r );
  #    
  #end );

  ###
  #AddWitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects( homotopy_cat,
  #  function( s, alpha, beta, gamma, r )
  #    local A, B, C, h, maps;
  #    
  #    A := Source( alpha );
  #    
  #    B := Range( alpha );
  #    
  #    C := Range( beta );
  #    
  #    h := HomotopyMorphisms( PreCompose( alpha, beta ) - gamma );
  #    
  #    maps := AsZFunction(
  #              i -> MorphismBetweenDirectSums(
  #                [
  #                  [
  #                    ZeroMorphism( A[ i + 2 * N ], B[ i + N ] ),
  #                    ZeroMorphism( A[ i + 2 * N ], C[ i ] )
  #                  ],
  #                  [
  #                    IdentityMorphism( B[ i + N ] ),
  #                    ZeroMorphism( B[ i + N ], C[ i ] )
  #                  ],
  #                  [
  #                    alpha[ i + N ],
  #                    -h[ i + N ]
  #                  ],
  #                  [
  #                    ZeroMorphism( C[ i ], B[ i + N ] ),
  #                    IdentityMorphism( C[ i ] )
  #                  ]
  #                ]
  #              )
  #            );
  #            
  #    return HomotopyCategoryMorphism( s, maps, r );
  #    
  #end );
  
end );

##
InstallMethod( UnitIsomorphism,
          [ IsHomotopyCategoryObject ],
          
  IdentityMorphism
);

##
InstallMethod( InverseOfUnitIsomorphism,
          [ IsHomotopyCategoryObject ],
          
  IdentityMorphism
);

##
InstallMethod( CounitIsomorphism,
          [ IsHomotopyCategoryObject ],
          
  IdentityMorphism
);

##
InstallMethod( InverseOfCounitIsomorphism,
          [ IsHomotopyCategoryObject ],
          
  IdentityMorphism
);
