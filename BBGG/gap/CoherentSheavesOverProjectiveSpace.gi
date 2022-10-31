# SPDX-License-Identifier: GPL-2.0-or-later
# BBGG: Beilinson monads and derived categories for coherent sheaves over P^n
#
# Implementations
#
##
BindGlobal( "IS_ZERO_SHEAF_OVER_PROJECTIVE_SPACE",
    function( N )
      return IsZero( HilbertPolynomial( AsPresentationInHomalg( N ) ) );
end );

##
InstallMethod( CoherentSheavesOverProjectiveSpace,
          [ IsHomalgGradedRing ],
  function( S )
    local graded_lp_cat_sym, sub_cat;
    
    graded_lp_cat_sym := GradedLeftPresentations( S );
    
    sub_cat := FullSubcategoryByMembershipFunction( graded_lp_cat_sym, IS_ZERO_SHEAF_OVER_PROJECTIVE_SPACE );
    
    return graded_lp_cat_sym / sub_cat;
    
end );

##
InstallMethod( SheafificationFunctor,
          [ IsCapCategory ],
  CanonicalProjection
);

##
InstallMethod( TwistedStructureSheafOp,
          [ IsHomalgGradedRing and IsFreePolynomialRing, IsInt ],
  function( S, d )
    local coh, sh;
    
    coh := CoherentSheavesOverProjectiveSpace( S );
    
    sh := SheafificationFunctor( coh );
    
    return ApplyFunctor( sh, TwistedGradedFreeModule( S, d ) );
    
end );

##
InstallMethod( BasisBetweenTwistedStructureSheaves,
          [ IsHomalgGradedRing and IsFreePolynomialRing, IsInt, IsInt ],
  function( S, i, j )
    local coh, sh, B;
    
    coh := CoherentSheavesOverProjectiveSpace( S );
    
    sh := SheafificationFunctor( coh );
    
    B := BasisBetweenTwistedGradedFreeModules( S, i, j );
    
    return List( B, b -> ApplyFunctor( sh, b ) );
    
end );

##
InstallMethod( TwistedCotangentSheafOp,
          [ IsHomalgGradedRing and IsFreePolynomialRing, IsInt ],
  function( S, d )
    local coh, sh;
    
    coh := CoherentSheavesOverProjectiveSpace( S );
    
    sh := SheafificationFunctor( coh );
    
    return ApplyFunctor( sh, TwistedCotangentModule( S, d ) );
    
end );

##
InstallMethod( BasisBetweenTwistedCotangentSheaves,
          [ IsHomalgGradedRing and IsFreePolynomialRing, IsInt, IsInt ],
  function( S, i, j )
    local coh, sh, B;
    
    coh := CoherentSheavesOverProjectiveSpace( S );
    
    sh := SheafificationFunctor( coh );
    
    B := BasisBetweenTwistedCotangentModulesAsGLP( S, i, j );
    
    return List( B, b -> ApplyFunctor( sh, b ) );
    
end );


##
InstallMethod( FullSubcategoryGeneratedByTwistsOfStructureSheaf,
          [ IsHomalgGradedRing and IsFreePolynomialRing ],
  function( S )
    local graded_pres, k, coh, generalized_morphism_cat, sh, name, full, is_additive;
    
    graded_pres := GradedLeftPresentations( S );
    
    DisableSanityChecks( graded_pres );
    DeactivateCachingOfCategory( graded_pres );
    CapCategorySwitchLogicOff( graded_pres );
    
    graded_pres := GradedLeftPresentations( KoszulDualRing( S ) );
    
    DisableSanityChecks( graded_pres );
    DeactivateCachingOfCategory( graded_pres );
    CapCategorySwitchLogicOff( graded_pres );
    
    k := UnderlyingNonGradedRing( CoefficientsRing( S ) );
    
    if not IsRationalsForHomalg( k ) then
      
      Error( "The coefficient ring should be a rational homalg field" );
      
    fi;
    
    k := BBGG!.QQ;
    
    coh := CoherentSheavesOverProjectiveSpace( S );
    
    DisableSanityChecks( coh );
    DeactivateCachingOfCategory( coh );
    CapCategorySwitchLogicOff( coh );
   
    generalized_morphism_cat := UnderlyingGeneralizedMorphismCategory( coh );
    
    DisableSanityChecks( generalized_morphism_cat );
    DeactivateCachingOfCategory( generalized_morphism_cat );
    CapCategorySwitchLogicOff( generalized_morphism_cat );
    
    sh := SheafificationFunctor( coh );
    
    name := "{ 𝓞 (i)| i ∈  Z }";
    
    full := FullSubcategory( coh, name : FinalizeCategory := false );
    
    SetSetOfKnownObjects( full,
          AsZFunction( i -> TwistedStructureSheaf( S, i ) / full )
        );
    
    ##
    AddIsEqualForObjects( full,
      function( full, M, N )
        
        return IsIdenticalObj( M, N )
                or GeneratorDegrees( UnderlyingHonestObject( UnderlyingCell( M ) ) )
                    = GeneratorDegrees( UnderlyingHonestObject( UnderlyingCell( N ) ) );
    end, 99 );
    
    ##
    AddIsEqualForMorphisms( full,
      function( full, alpha, beta )
        
        if IsIdenticalObj( alpha, beta ) then
          
          return true;
          
        fi;
        
        if not ( IsEqualForObjects( Source( alpha ), Source( beta ) ) and IsEqualForObjects( Range( alpha ), Range( beta ) ) ) then
          
          return false;
          
        fi;
        
        return EntriesOfHomalgMatrix( UnderlyingMatrix( HonestRepresentative( UnderlyingGeneralizedMorphism( UnderlyingCell( alpha ) ) ) ) )[ 1 ]
                    = EntriesOfHomalgMatrix( UnderlyingMatrix( HonestRepresentative( UnderlyingGeneralizedMorphism( UnderlyingCell( beta ) ) ) ) )[ 1 ];
    end, 99 );
    
    ##
    AddIsEqualForCacheForObjects( full, IsEqualForObjects, 99 );
    AddIsEqualForCacheForMorphisms( full, IsEqualForMorphisms, 99 );
      
    AddIsWellDefinedForObjects( full,
      function( full, M )
        
        M := UnderlyingCell( M );
        
        M := UnderlyingHonestObject( M );
        
        return NrRows( UnderlyingMatrix( M ) ) = 0 and NrCols( UnderlyingMatrix( M ) ) = 1;
        
    end );
    
    AddIsWellDefinedForMorphisms( full,
      function( full, alpha )
        return IsWellDefined( Source( alpha ) ) and IsWellDefined( Range( alpha ) )
                and IsWellDefined( UnderlyingCell( alpha ) );
                
    end, 99 );
    
    SetIsLinearCategoryOverCommutativeRing( full, true );
    
    SetCommutativeRingOfLinearCategory( full, k );
    
    AddMultiplyWithElementOfCommutativeRingForMorphisms( full,
      function( full, r, alpha )
        local coeff, beta;
        
        coeff := fail;
        
        if HasCoefficientsOfMorphism( alpha ) then
          
          coeff := r * CoefficientsOfMorphism( alpha );
          
        fi;
        
        beta := UnderlyingCell( alpha );
        
        beta := HonestRepresentative( UnderlyingGeneralizedMorphism( beta ) );
        
        beta := GradedPresentationMorphism( Source( beta ), ( r / S ) * UnderlyingMatrix( beta ), Range( beta ) );
        
        beta := ApplyFunctor( sh, beta ) / full;
        
        if not IsIdenticalObj( coeff, fail ) then
          
          SetCoefficientsOfMorphism( beta, coeff );
          
        fi;
        
        return beta;
        
    end, 99 );
        
    AddBasisOfExternalHom( full,
      function( full, M, N )
        local twist_M, twist_N, B, identity_matrix;
        
        twist_M := HomalgElementToInteger( -GeneratorDegrees( UnderlyingHonestObject( UnderlyingCell( M ) ) )[ 1 ] );
        
        twist_N := HomalgElementToInteger( -GeneratorDegrees( UnderlyingHonestObject( UnderlyingCell( N ) ) )[ 1 ] );
        
        B := BasisBetweenTwistedStructureSheaves( S, twist_M, twist_N );
        
        B := List( B, b -> ApplyFunctor( sh, b ) / full );
        
        identity_matrix := EntriesOfHomalgMatrixAsListList( HomalgIdentityMatrix( Length( B ), k ) );
        
        ListN( B, identity_matrix, function( b, c ) SetCoefficientsOfMorphism( b, c ); return true; end );
        
        return B;
        
    end, 99 );
    
    AddCoefficientsOfMorphism( full,
      function( full, phi )
        local B, entry, sol, coeff_mat, current_coeff, current_mono, position_in_basis, j;
        
        B := BasisOfExternalHom( Source( phi ), Range( phi ) );
        
        if B = [  ] then
          
          return [  ];
          
        fi;
        
        phi := UnderlyingCell( phi );
        
        phi := HonestRepresentative( UnderlyingGeneralizedMorphism( phi ) );
        
        entry := UnderlyingMatrix( phi )[ 1, 1 ];
        
        B := List( B, UnderlyingCell );
        
        B := List( B, b -> HonestRepresentative( UnderlyingGeneralizedMorphism( b ) ) );
        
        B := List( B, b -> EntriesOfHomalgMatrix( UnderlyingMatrix( b ) )[ 1 ] );
        
        sol := ListWithIdenticalEntries( Length( B ), Zero( k ) );
        
        coeff_mat := Coefficients( EvalRingElement( entry ) );
          
        for j in [ 1 .. NrRows( coeff_mat ) ] do
            
            current_coeff := coeff_mat[ j, 1 ];
            
            current_mono := coeff_mat!.monomials[ j ] / S;
            
            position_in_basis := Position( B, current_mono );
            
            sol[ position_in_basis ] := current_coeff / k;
            
        od;
        
        return sol;
        
    end, 99 );
    
    Finalize( full );
    
    DisableSanityChecks( full );
    SetCachingOfCategoryCrisp( full );
    #DeactivateCachingOfCategory( full );
    CapCategorySwitchLogicOff( full );
   
    return full;
    
end );

##
InstallMethod( FullSubcategoryGeneratedByTwistedCotangentSheaves,
          [ IsHomalgGradedRing and IsFreePolynomialRing ],
  function( S )
    local graded_pres, k, coh, generalized_morphism_cat, sh, indeterminates, n, omegas, mats, dims, full;
    
    graded_pres := GradedLeftPresentations( S );
    
    DisableSanityChecks( graded_pres );
    DeactivateCachingOfCategory( graded_pres );
    CapCategorySwitchLogicOff( graded_pres );
    
    graded_pres := GradedLeftPresentations( KoszulDualRing( S ) );
    DisableSanityChecks( graded_pres );
    DeactivateCachingOfCategory( graded_pres );
    CapCategorySwitchLogicOff( graded_pres );
    
    k := UnderlyingNonGradedRing( CoefficientsRing( S ) );
    
    if not IsRationalsForHomalg( k ) then
      
      Error( "The coefficient ring should be a rational homalg field" );
      
    fi;
    
    k := BBGG!.QQ;
    
    coh := CoherentSheavesOverProjectiveSpace( S );
    
    DisableSanityChecks( coh );
    DeactivateCachingOfCategory( coh );
    CapCategorySwitchLogicOff( coh );
   
    generalized_morphism_cat := UnderlyingGeneralizedMorphismCategory( coh );
    
    DisableSanityChecks( generalized_morphism_cat );
    DeactivateCachingOfCategory( generalized_morphism_cat );
    CapCategorySwitchLogicOff( generalized_morphism_cat );
    
    sh := CanonicalProjection( coh );
         
    indeterminates := Indeterminates( S );
    
    n := Length( indeterminates );
    
    omegas := List( [ 0 .. n - 1 ], i -> TwistedCotangentModule( S, i ) );
    
    mats := List( omegas, UnderlyingMatrix );
    
    dims := List( mats, d -> [ NrRows( d ), NrCols( d ) ] );
    
    if not IsDuplicateFree( dims ) then
      
      Error( "This should not happen, please report this!\n" );
      
    fi;
    
    omegas := List( omegas, omega -> ApplyFunctor( sh, omega ) );
    
    full := FullSubcategoryGeneratedByListOfObjects( omegas : FinalizeCategory := false );
             
    SetIsLinearCategoryOverCommutativeRing( full, true );
    
    SetCommutativeRingOfLinearCategory( full, k );
    
    AddMultiplyWithElementOfCommutativeRingForMorphisms( full,
      function( full, r, alpha )
        local coeff, beta;
        
        coeff := fail;
        
        if HasCoefficientsOfMorphism( alpha ) then
          
          coeff := r * CoefficientsOfMorphism( alpha );
          
        fi;
        
        beta := UnderlyingCell( alpha );
        
        beta := HonestRepresentative( UnderlyingGeneralizedMorphism( beta ) );
        
        beta := GradedPresentationMorphism( Source( beta ), ( r / S ) * UnderlyingMatrix( beta ), Range( beta ) );
        
        beta := ApplyFunctor( sh, beta ) / full;
        
        if not IsIdenticalObj( coeff, fail ) then
          
          SetCoefficientsOfMorphism( beta, coeff );
          
        fi;
        
        return beta;
        
    end, 99 );
      
    AddBasisOfExternalHom( full,
      function( full, M, N )
        local mat_M, dim_M, index_M, mat_N, dim_N, index_N;
        
        mat_M := UnderlyingMatrix( UnderlyingHonestObject( UnderlyingCell( M ) ) );
        dim_M := [ NrRows( mat_M ), NrCols( mat_M ) ];
        index_M := Position( dims, dim_M ) - 1;
        
        mat_N := UnderlyingMatrix( UnderlyingHonestObject( UnderlyingCell( N ) ) );
        dim_N := [ NrRows( mat_N ), NrCols( mat_N ) ];
        index_N := Position( dims, dim_N ) - 1;
        
        if index_M = fail or index_N = fail then
          
          Error( "This should not happen!" );
          
        fi;
        
        return List( BasisBetweenTwistedCotangentSheaves( S, index_M, index_N ), b -> b / full );
        
    end, 99 );
    
    AddCoefficientsOfMorphism( full,
      function( full, phi)
        local B, mat, sol;
        
        B := BasisOfExternalHom( Source( phi ), Range( phi ) );
        
        if B = [  ] then
          
          return [  ];
          
        fi;
        
        phi := UnderlyingCell( phi );
        
        phi := HonestRepresentative( UnderlyingGeneralizedMorphism( phi ) );
        
        mat := UnderlyingMatrix( phi ) * k;
        
        mat := ConvertTransposedMatrixToRow( mat );
        
        B := List( B, UnderlyingCell );
        
        B := List( B, b -> HonestRepresentative( UnderlyingGeneralizedMorphism( b ) ) );
        
        B := List( B, b -> UnderlyingMatrix( b ) * k );
        
        B := UnionOfRows( List( B, ConvertTransposedMatrixToRow ) );
        
        sol := RightDivide( mat, B );
        
        return EntriesOfHomalgMatrix( sol );
        
    end );
    
    Finalize( full );
    
    return full;
    
end );

########################################
#
# View & Display methods
#
#######################################

## 𝒪, 𝓞, 𝛀, 𝛚 ⨁,, ⊕, Ω
