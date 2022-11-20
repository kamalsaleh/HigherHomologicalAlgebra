# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#
#! @Chapter Resolutions
##
#############################################################################

##
InstallMethod( IsAbelianCategoryWithComputableEnoughProjectives,
          [ IsCapCategory ],
          
  function( cat );
    
    return HasIsAbelianCategory( cat )
              and IsAbelianCategory( cat )
                # and CanCompute( cat, "IsProjective" )
                  and CanCompute( cat, "SomeProjectiveObject" )
                    and CanCompute( cat, "EpimorphismFromSomeProjectiveObject" )
                      and CanCompute( cat, "ProjectiveLift" );
end );

##
InstallMethod( IsAbelianCategoryWithComputableEnoughInjectives,
          [ IsCapCategory ],
          
  function( cat );
    
    return HasIsAbelianCategory( cat )
              and IsAbelianCategory( cat )
                # and CanCompute( cat, "IsInjective" )
                  and CanCompute( cat, "SomeInjectiveObject" )
                    and CanCompute( cat, "MonomorphismIntoSomeInjectiveObject" )
                      and CanCompute( cat, "InjectiveColift" );
end );

###############################
#
# Resolutions
#
###############################

##
InstallMethod( QuasiIsomorphismFromProjectiveResolution,
          [ IsBoundedAboveCochainComplex ],
          
  function( C )
    local cat, u, zero, maps, r;
    
    cat := UnderlyingCategory( CapCategory( C ) );
    
    if not ( HasIsAbelianCategory( cat )
              and IsAbelianCategory( cat )
                and CanCompute( cat, "SomeProjectiveObject" )
                  and CanCompute( cat, "EpimorphismFromSomeProjectiveObject" )
                    ) then
                    
      Error( "The underlying category must be abelian with computable enough projectives" );
      
    fi;
    
    u := ActiveUpperBound( C );
    
    zero := ZeroObject( cat );
    
    maps := AsZFunction(
      function( k )
        local diff_kp1, m, p1, p2, ker, pk;
        
        if k > u then
          
          return
            [
              ZeroMorphism( zero, zero ),
              ZeroMorphism( zero, C[ k ] ),
              ZeroMorphism( zero, zero )
            ];
            
        else
          
          diff_kp1 := maps[ k + 1 ][ 1 ];
          
          m := MorphismBetweenDirectSums(
                        [
                          [ AdditiveInverse( diff_kp1 ), maps[ k + 1 ][ 2 ] ],
                          [ ZeroMorphism( C[ k ], Range( diff_kp1 ) ), C^k ]
                        ]
                      );
                      
          p1 := ProjectionInFactorOfDirectSum( [ Source( diff_kp1 ), C[ k ] ], 1 );
          
          p2 := ProjectionInFactorOfDirectSum( [ Source( diff_kp1 ), C[ k ] ], 2 );
          
          ker := KernelEmbedding( m );
          
          pk := EpimorphismFromSomeProjectiveObject( Source( ker ) );
          
          return
            [
              PreCompose( [ pk, ker, p1 ] ),
              AdditiveInverse( PreCompose( [ pk, ker, p2 ] ) ),
              m
            ];
          
        fi;
        
      end );
      
    r := CochainComplex( cat, ApplyMap( maps, j -> j[ 1 ] ) );
    
    SetUpperBound( r, u );
    
    return CochainMorphism( r, C, AsZFunction( j -> maps[ j ][ 2 ] ) );
end );

##
InstallMethod( QuasiIsomorphismFromProjectiveResolution,
        [ IsBoundedBelowChainComplex ],
        
  function( C )
    
    return AsChainMorphism( QuasiIsomorphismFromProjectiveResolution( AsCochainComplex( C ) ) );
    
end );

##
InstallMethod( ProjectiveResolution,
      [ IsBoundedAboveCochainComplex ],
      
  function( C )
    
    return Source( QuasiIsomorphismFromProjectiveResolution( C ) );
    
end );

##
InstallMethod( ProjectiveResolution,
      [ IsBoundedBelowChainComplex ],
      
  function( C )
    
    return Source( QuasiIsomorphismFromProjectiveResolution( C ) );
    
end );

##
InstallMethod( MorphismBetweenProjectiveResolutions,
        [ IsCapCategoryMorphism and IsBoundedAboveCochainMorphism ],
        
  function( phi )
    local C, D, q_C, p_C, q_D, p_D, u, maps;
    
    C := Source( phi );
    
    D := Range( phi );
    
    q_C := QuasiIsomorphismFromProjectiveResolution( C );
    
    p_C := Source( q_C );
    
    q_D := QuasiIsomorphismFromProjectiveResolution( D );
    
    p_D := Source( q_D );
    
    u := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) );
    
    maps := AsZFunction(
      function( k )
        local temp_C, temp_D, m, kappa, ep_C, ep_D;
        
        if k >= u + 1 then
          
          return ZeroMorphism( p_C[ k ], p_D[ k ] );
          
        else
          
          temp_C := BaseZFunctions( Differentials( p_C ) )[ 1 ][ k ][ 3 ];
          
          temp_D := BaseZFunctions( Differentials( p_D ) )[ 1 ][ k ][ 3 ];
         
          m := DirectSumFunctorial( [ maps[ k + 1 ], phi[ k ] ] );
          
          kappa := KernelObjectFunctorial( temp_C, m, temp_D );
          
          ep_C := EpimorphismFromSomeProjectiveObject( Source( kappa ) );
          
          ep_D := EpimorphismFromSomeProjectiveObject( Range( kappa ) );
          
          return ProjectiveLift( PreCompose( ep_C, kappa ), ep_D );
         
         fi;
         
      end );
      
    return CochainMorphism( p_C, p_D, maps );
    
end );

##
InstallMethod( MorphismBetweenProjectiveResolutions,
        [ IsCapCategoryMorphism and IsBoundedBelowChainMorphism ],
        
  function( phi )
    local p_C, p_D, morphism, morphisms;
    
    p_C := ProjectiveResolution( Source( phi ) );
    
    p_D := ProjectiveResolution( Range( phi ) );
    
    morphism := AsChainMorphism( MorphismBetweenProjectiveResolutions( AsCochainMorphism( phi ) ) );
    
    morphisms := Morphisms( morphism );
    
    return ChainMorphism( p_C, p_D, morphisms );
    
end );

##
InstallMethod( ProjectiveResolution,
      [ IsBoundedCochainComplex, IsBool ],
      
  function( C, bool )
    local p, i;
    
    p := ProjectiveResolution( C );
    
    if HasActiveLowerBound( p ) then
      
      return p;
    
    fi;
    
    i := ActiveLowerBound( C ) - 1;
    
    while bool do
      
      if IsZeroForObjects( p[ i ] ) then
        
        SetLowerBound( p, i + 1 );
        
        return p;
      
      fi;
      
      i := i - 1;
    
    od;
    
    return p;
    
end );

##
InstallMethod( ProjectiveResolution,
      [ IsBoundedChainComplex, IsBool ],
      
  function( C, bool )
    local p, i;
    
    p := ProjectiveResolution( C );
    
    if HasActiveUpperBound( p ) then
      
      return p;
      
    fi;
    
    i := ActiveUpperBound( C ) + 1;
    
    while bool do
        
      if IsZeroForObjects( p[ i ] ) then
        
        SetUpperBound( p, i - 1 );
        
        return p;
      
      fi;
      
      i := i + 1;
      
    od;
    
    return p;
    
end );

##
InstallMethod( QuasiIsomorphismFromProjectiveResolution,
          [ IsBoundedChainOrCochainComplex, IsBool ],
          
  function( C, bool )
    local q;
    
    q := QuasiIsomorphismFromProjectiveResolution( C );
    
    ProjectiveResolution( C, bool );
    
    return q;
    
end );

#######################################
##
## resolutions of objects
##
#######################################

InstallMethod( ProjectiveResolution,
       [ IsCapCategoryObject ],
       
  function( obj )
    local func, C, cat, ep, ker, ep_ker, d;
    
    if IsBoundedAboveCochainComplex( obj ) or IsBoundedBelowChainComplex( obj ) then
      
      TryNextMethod();
      
    fi;
    
    cat := CapCategory( obj );
    
    if not ( HasIsAbelianCategory( cat )
                and IsAbelianCategory( cat )
                  and CanCompute( cat, "SomeProjectiveObject" )
                    and CanCompute( cat, "EpimorphismFromSomeProjectiveObject" )
                      ) then
                      
      Error( "The category must be abelian with computable enough projectives" );
      
    fi;
    
    func := function( mor )
              local k,p;
              k := KernelEmbedding( mor );
              p := EpimorphismFromSomeProjectiveObject( Source( k ) );
              return PreCompose( p, k );
            end;
            
    ep := EpimorphismFromSomeProjectiveObject( obj );
    
    ker := KernelEmbedding( ep );
    
    ep_ker := EpimorphismFromSomeProjectiveObject( Source( ker ) );
    
    d := PreCompose( ep_ker, ker );
    
    C := CochainComplexWithInductiveNegativeSide( d, func );
    
    return ShiftLazy( C, 1 );
    
end );

##
InstallMethod( ProjectiveResolution,
       [ IsCapCategoryObject, IsBool ],
       
  function( M, bool )
    local p, i;
    
    if IsChainOrCochainComplex( M ) then
      
      TryNextMethod();
    
    fi;
    
    p := ProjectiveResolution( M );
    
    if HasActiveLowerBound( p ) then
      
      return p;
      
    fi;
    
    i := 0;
    
    while bool do
      
      if IsZero( p[ i ] ) then
        
        SetLowerBound( p, i + 1 );
        
        return p;
        
      fi;
      
      i := i - 1;
      
      if IsZero( i mod 5000 ) then
        
        Error( "It seems that the object have infinite resolution; do you want me to continue trying? then return!\n" );
        
      fi;
     
    od;
    
    return p;
    
end );

##
InstallMethod( ProjectiveCochainResolution,
          [ IsCapCategoryObject ],
          
  function( obj )
    
    if IsChainOrCochainComplex( obj ) then
      
      TryNextMethod( );
      
    fi;
    
    return ProjectiveResolution( obj );
    
end );

##
InstallMethod( ProjectiveCochainResolution,
          [ IsCapCategoryObject, IsBool ],
  function( obj, bool )
    
    if IsChainOrCochainComplex( obj ) then
      
      TryNextMethod( );
      
    fi;
    
    return ProjectiveResolution( obj, bool );
    
end );

##
InstallMethod( ProjectiveChainResolution,
          [ IsCapCategoryObject ],
  function( obj )
    
    if IsChainOrCochainComplex( obj ) then
      
      TryNextMethod( );
      
    fi;
    
    return AsChainComplex( ProjectiveResolution( obj ) );
    
end );

##
InstallMethod( ProjectiveChainResolution,
          [ IsCapCategoryObject, IsBool ],
  function( obj, bool )
    
    if IsChainOrCochainComplex( obj ) then
      
      TryNextMethod( );
      
    fi;
    
    return AsChainComplex( ProjectiveResolution( obj, bool ) );
    
end );

##
InstallOtherMethod( ProjectiveChainResolution,
          [ IsChainComplex ], ProjectiveResolution );

##
InstallOtherMethod( ProjectiveChainResolution,
          [ IsChainComplex, IsBool ], ProjectiveResolution );

##
InstallOtherMethod( ProjectiveChainResolution,
          [ IsCochainComplex ], C -> AsChainComplex( ProjectiveResolution( C ) ) );

##
InstallOtherMethod( ProjectiveChainResolution,
          [ IsCochainComplex, IsBool ],
  { C, bool } -> AsChainComplex( ProjectiveResolution( C, bool ) )
);

##
InstallOtherMethod( ProjectiveCochainResolution,
          [ IsCochainComplex ], ProjectiveResolution );

##
InstallOtherMethod( ProjectiveCochainResolution,
          [ IsCochainComplex, IsBool ], ProjectiveResolution );

##
InstallOtherMethod( ProjectiveCochainResolution,
          [ IsChainComplex ], C -> AsCochainComplex( ProjectiveResolution( C ) ) );

##
InstallOtherMethod( ProjectiveCochainResolution,
          [ IsChainComplex, IsBool ],
  { C, bool } -> AsCochainComplex( ProjectiveResolution( C, bool ) )
);


##
InstallMethod( MorphismBetweenProjectiveResolutions,
       [ IsCapCategoryMorphism ],
       
  function( phi )
    local cat, P, Q, func, maps, temp;
    
    if IsChainOrCochainMorphism( phi ) then
      
      TryNextMethod( );
    
    fi;
    
    cat := CapCategory( phi );
    
    if not IsAbelianCategoryWithComputableEnoughProjectives( cat ) then 
      
      Error( "The category must be abelian with computable enough projectives" );
      
    fi;
    
    P := ProjectiveResolution( Source( phi ) );
    
    Q := ProjectiveResolution( Range( phi ) );
    
    temp := rec(  );
    
    func := function( i )
              local a, b, c;
              if i > 0 then
                c := ZeroMorphism( P[i], Q[i] );
              elif i = 0 then
                a := PreCompose( EpimorphismFromSomeProjectiveObject( Source( phi ) ), phi );
                b := EpimorphismFromSomeProjectiveObject( Range( phi ) );
                c := ProjectiveLift( a, b );
              else
                if IsBound( temp!.( i + 1 ) ) then
                  a := KernelLift( Q^( i+1 ), PreCompose( P^i, temp!.( i + 1 ) ) );
                else
                  a := KernelLift( Q^( i+1 ), PreCompose( P^i, func( i + 1 ) ) );
                fi;
                b := KernelLift( Q^( i+1 ), Q^i );
                c := ProjectiveLift( a, b );
              fi;
              temp!.( String( i ) ) := c;
              return c;
            end;
            
    maps := AsZFunction( func );
    
    return CochainMorphism( P, Q, maps );
    
end );

##
InstallMethod( MorphismBetweenProjectiveResolutions,
       [ IsCapCategoryMorphism, IsBool ],
       
  function( phi, bool )
    local psi;
    
    psi := MorphismBetweenProjectiveResolutions( phi );
    
    ProjectiveResolution( Source( phi ), bool );
    
    ProjectiveResolution( Range( phi ), bool );
    
    return psi;
    
end );

##
InstallMethod( MorphismBetweenProjectiveCochainResolutions,
          [ IsCapCategoryMorphism ],
          
  function( phi )
      
    if IsChainOrCochainMorphism( phi ) then
      TryNextMethod( );
    fi;
    
    return MorphismBetweenProjectiveResolutions( phi );
    
end );

##
InstallMethod( MorphismBetweenProjectiveCochainResolutions,
          [ IsCapCategoryMorphism, IsBool ],
          
  function( phi, bool )
    
    if IsChainOrCochainMorphism( phi ) then
      TryNextMethod( );
    fi;
    
    return MorphismBetweenProjectiveResolutions( phi, bool );
    
end );

##
InstallMethod( MorphismBetweenProjectiveChainResolutions,
          [ IsCapCategoryMorphism ],
          
  function( phi )
    
    if IsChainOrCochainMorphism( phi ) then
      
      TryNextMethod( );
      
    fi;
    
    return AsChainMorphism( MorphismBetweenProjectiveResolutions( phi ) );
     
end );

##
InstallMethod( MorphismBetweenProjectiveChainResolutions,
          [ IsCapCategoryMorphism, IsBool ],
          
  function( phi, bool )
    
    if IsChainOrCochainMorphism( phi ) then
      
      TryNextMethod( );
      
    fi;
    
    return AsChainMorphism( MorphismBetweenProjectiveResolutions( phi, bool ) );
    
end );

##
InstallOtherMethod( MorphismBetweenProjectiveChainResolutions,
          [ IsChainMorphism ], MorphismBetweenProjectiveResolutions );

##
InstallOtherMethod( MorphismBetweenProjectiveChainResolutions,
          [ IsChainMorphism, IsBool ], MorphismBetweenProjectiveResolutions );

##
InstallOtherMethod( MorphismBetweenProjectiveChainResolutions,
          [ IsCochainMorphism ], phi -> AsChainMorphism( MorphismBetweenProjectiveResolutions( phi ) ) );

##
InstallOtherMethod( MorphismBetweenProjectiveChainResolutions,
          [ IsCochainMorphism, IsBool ],
  { phi, bool } -> AsChainMorphism( MorphismBetweenProjectiveResolutions( phi, bool ) )
);

##
InstallOtherMethod( MorphismBetweenProjectiveCochainResolutions,
          [ IsCochainMorphism ], MorphismBetweenProjectiveResolutions );

##
InstallOtherMethod( MorphismBetweenProjectiveCochainResolutions,
          [ IsCochainMorphism, IsBool ], MorphismBetweenProjectiveResolutions );

##
InstallOtherMethod( MorphismBetweenProjectiveCochainResolutions,
          [ IsChainMorphism ], phi -> AsCochainMorphism( MorphismBetweenProjectiveResolutions( phi ) ) );

##
InstallOtherMethod( MorphismBetweenProjectiveCochainResolutions,
          [ IsChainMorphism, IsBool ],
  { phi, bool } -> AsCochainMorphism( MorphismBetweenProjectiveResolutions( phi, bool ) )
);

##############################
#
# Injective resolutions
#
##############################

##
InstallMethod( QuasiIsomorphismIntoInjectiveResolution,
          [ IsBoundedBelowCochainComplex ],
          
  function( C )
    local cat, u, zero, maps, inj;
    
    cat := UnderlyingCategory( CapCategory( C ) );
    
    if not ( HasIsAbelianCategory( cat )
              and IsAbelianCategory( cat )
                and CanCompute( cat, "SomeInjectiveObject" )
                  and CanCompute( cat, "MonomorphismIntoSomeInjectiveObject" )
                    ) then
                    
      Error( "The underlying category must be abelian with enough injectives" );
      
    fi;
    
    u := ActiveLowerBound( C ) - 1;
    
    zero := ZeroObject( cat );
    
    maps := AsZFunction(
        function( k )
          local temp, m, coker, iota, mor1, mor2;
          
          if k <= u then
            
            return [ ZeroMorphism( zero, zero ), ZeroMorphism( C[ k ], zero ), ZeroMorphism( zero, zero ) ];
            
          else
            
            temp := maps[ k - 1 ][ 1 ];
            
            m := MorphismBetweenDirectSums(
                                [
                                  [ AdditiveInverse( C^( k - 1 ) ), maps[ k - 1 ][ 2 ] ],
                                  [ ZeroMorphism( Source( temp ), C[ k ] ), temp ]
                                ]
                            );
                            
            coker := CokernelProjection( m );
            
            iota := MonomorphismIntoSomeInjectiveObject( Range( coker ) );
            
            mor1 := InjectionOfCofactorOfDirectSum( [ C[ k ], Range( temp ) ], 1 );
            
            mor2 := InjectionOfCofactorOfDirectSum( [ C[ k ], Range( temp ) ], 2 );
            
            return [ PostCompose( [ iota, coker, mor2 ] ), PostCompose( [ iota, coker, mor1 ] ), m ];
            
          fi;
          
    end );
    
    inj := CochainComplex( cat, ApplyShift( ApplyMap( maps, j -> j[ 1 ] ), 1 ) );
    
    SetLowerBound( inj, u + 1 );
    
    return CochainMorphism( C, inj, ApplyMap( maps, j -> j[ 2 ] ) );
    
 end );

##
InstallMethod( QuasiIsomorphismIntoInjectiveResolution,
          [ IsBoundedAboveChainComplex ],
          
  function( C )
    
    return AsChainMorphism( QuasiIsomorphismIntoInjectiveResolution( AsCochainComplex( C ) ) );
    
end );

##
InstallMethod( InjectiveResolution,
          [ IsBoundedBelowCochainComplex ],
          
  function( C )
    
    return Range( QuasiIsomorphismIntoInjectiveResolution( C ) );
    
end );

##
InstallMethod( InjectiveResolution,
          [ IsBoundedAboveChainComplex ],
          
  function( C )
    
    return Range( QuasiIsomorphismIntoInjectiveResolution( C ) );
    
end );

##
InstallMethod( MorphismBetweenInjectiveResolutions,
        [ IsCapCategoryMorphism and IsBoundedBelowCochainMorphism ],
        
  function( phi )
    local C, D, q_C, i_C, q_D, i_D, u, maps;
    
    C := Source( phi );
    
    D := Range( phi );
    
    q_C := QuasiIsomorphismIntoInjectiveResolution( C );
    
    i_C := Range( q_C );
    
    q_D := QuasiIsomorphismIntoInjectiveResolution( D );
    
    i_D := Range( q_D );
    
    u := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) ) - 1;
    
    maps := AsZFunction(
      function( k )
        local temp_C, temp_D, m, kappa, mo_C, mo_D;
        
        if k <= u then
          
          return ZeroMorphism( i_C[ k ], i_D[ k ] );
          
        else
          
          temp_C := BaseZFunctions( ApplyShift( Differentials( i_C ), -1 ) )[ 1 ][ k ][ 3 ];
          
          temp_D := BaseZFunctions( ApplyShift( Differentials( i_D ), -1 ) )[ 1 ][ k ][ 3 ];
          
          m := DirectSumFunctorial( [ phi[ k ], maps[ k - 1 ] ] );
          
          kappa := CokernelObjectFunctorial( temp_C, m, temp_D );
          
          mo_C := MonomorphismIntoSomeInjectiveObject( Source( kappa ) );
          
          mo_D := MonomorphismIntoSomeInjectiveObject( Range( kappa ) );
          
          return InjectiveColift( mo_C, PreCompose( kappa, mo_D ) );
          
         fi;
         
      end );
      
    return CochainMorphism( i_C, i_D, maps );
    
end );

##
InstallMethod( MorphismBetweenInjectiveResolutions,
        [ IsCapCategoryMorphism and IsBoundedAboveChainMorphism ],
        
  function( phi )
    local i_C, i_D, morphism, morphisms;
    
    i_C := InjectiveResolution( Source( phi ) );
    
    i_D := InjectiveResolution( Range( phi ) );
    
    morphism := AsChainMorphism( MorphismBetweenInjectiveResolutions( AsCochainMorphism( phi ) ) );
    
    morphisms := Morphisms( morphism );
    
    return ChainMorphism( i_C, i_D, morphisms );
    
end );

##
InstallMethod( InjectiveResolution,
      [ IsBoundedCochainComplex, IsBool ],
      
  function( C, bool )
    local p, i;
    
    p := InjectiveResolution( C );
    
    if HasActiveUpperBound( p ) then
      
      return p;
      
    fi;
    
    i := ActiveUpperBound( C ) + 1;
    
    while bool do
      
      if IsZeroForObjects( p[ i ] ) then
        
        SetUpperBound( p, i - 1 );
        
        return p;
        
      fi;
      
      i := i + 1;
      
    od;
    
    return p;
    
end );

##
InstallMethod( InjectiveResolution,
      [ IsBoundedChainComplex, IsBool ],
      
  function( C, bool )
    local p, i;
    
    p := InjectiveResolution( C );
    
    if HasActiveLowerBound( p ) then
      
      return p;
      
    fi;
    
    i := ActiveLowerBound( C ) - 1;
    
    while bool do
      
      if IsZeroForObjects( p[ i ] ) then
        
        SetLowerBound( p, i + 1 );
        
        return p;
        
      fi;
      
      i := i - 1;
      
    od;
    
    return p;
    
end );

##
InstallMethod( QuasiIsomorphismIntoInjectiveResolution,
          [ IsBoundedChainOrCochainComplex, IsBool ],
          
  function( C, bool )
    local q;
    
    q := QuasiIsomorphismIntoInjectiveResolution( C );
    
    InjectiveResolution( C, bool );
    
    return q;
    
end );

#######################################
##
## injective resolutions of objects
##
#######################################

InstallMethod( InjectiveResolution,
       [ IsCapCategoryObject ],
       
  function( obj )
    local func, C, cat, em, coker, em_coker, d;
    
    if IsBoundedBelowCochainComplex( obj ) or IsBoundedAboveChainComplex( obj ) then
      
      TryNextMethod();
      
    fi;
    
    cat := CapCategory( obj );
    
    if not ( HasIsAbelianCategory( cat )
                and IsAbelianCategory( cat )
                  and CanCompute( cat, "SomeInjectiveObject" )
                    and CanCompute( cat, "MonomorphismIntoSomeInjectiveObject" )
                      ) then
                      
      Error( "The category must be abelian with computable enough injectives" );
      
    fi;
    
    func :=
      function( mor )
        local k, p;
        
        k := CokernelProjection( mor );
        
        p := MonomorphismIntoSomeInjectiveObject( Range( k ) );
        
        return PreCompose( k, p );
        
      end;
      
    em := MonomorphismIntoSomeInjectiveObject( obj );
    
    coker := CokernelProjection( em );
    
    em_coker := MonomorphismIntoSomeInjectiveObject( Range( coker ) );
    
    d := PreCompose( coker, em_coker );
    
    C := CochainComplexWithInductivePositiveSide( d, func );
    
    return C;
    
end );

##
InstallMethod( InjectiveResolution,
       [ IsCapCategoryObject, IsBool ],
       
  function( M, bool )
    local p, i;
    
    if IsChainOrCochainComplex( M ) then
      
      TryNextMethod();
      
    fi;
    
    p := InjectiveResolution( M );
    
    if HasActiveUpperBound( p ) then
      
      return p;
      
    fi;
    
    i := 0;
    
    while bool do
       
      if IsZero( p[ i ] ) then
        
        SetUpperBound( p, i - 1 );
        
        return p;
        
      fi;
        
      i := i + 1;
      
      if IsZero( i mod 5000 ) then
        
        Error( "It seems that the object have infinite resolution; do you want me to continue trying? then return!\n" );
        
      fi;
      
    od;
    
    return p;
    
end );

##
InstallMethod( InjectiveCochainResolution,
          [ IsCapCategoryObject ],
          
  function( obj )
    
    if IsChainOrCochainComplex( obj ) then
      
      TryNextMethod( );
      
    fi;
    
    return InjectiveResolution( obj );
    
end );

##
InstallMethod( InjectiveCochainResolution,
          [ IsCapCategoryObject, IsBool ],
          
  function( obj, bool )
    
    if IsChainOrCochainComplex( obj ) then
      
      TryNextMethod( );
      
    fi;
    
    return InjectiveResolution( obj, bool );
    
end );

##
InstallMethod( InjectiveChainResolution,
          [ IsCapCategoryObject ],
          
  function( obj )
    
    if IsChainOrCochainComplex( obj ) then
      
      TryNextMethod( );
      
    fi;
    
    return AsChainComplex( InjectiveResolution( obj ) );
    
end );

##
InstallMethod( InjectiveChainResolution,
          [ IsCapCategoryObject, IsBool ],
          
  function( obj, bool )
    
    if IsChainOrCochainComplex( obj ) then
      
      TryNextMethod( );
      
    fi;
    
    return AsChainComplex( InjectiveResolution( obj, bool ) );
    
end );

##
InstallOtherMethod( InjectiveChainResolution,
          [ IsChainComplex ], InjectiveResolution );

##
InstallOtherMethod( InjectiveChainResolution,
          [ IsChainComplex, IsBool ], InjectiveResolution );

##
InstallOtherMethod( InjectiveChainResolution,
          [ IsCochainComplex ], C -> AsChainComplex( InjectiveResolution( C ) ) );

##
InstallOtherMethod( InjectiveChainResolution,
          [ IsCochainComplex, IsBool ],
  { C, bool } -> AsChainComplex( InjectiveResolution( C, bool ) )
);

##
InstallOtherMethod( InjectiveCochainResolution,
          [ IsCochainComplex ], InjectiveResolution );

##
InstallOtherMethod( InjectiveCochainResolution,
          [ IsCochainComplex, IsBool ], InjectiveResolution );

##
InstallOtherMethod( InjectiveCochainResolution,
          [ IsChainComplex ], C -> AsCochainComplex( InjectiveResolution( C ) ) );

##
InstallOtherMethod( InjectiveCochainResolution,
          [ IsChainComplex, IsBool ],
  { C, bool } -> AsCochainComplex( InjectiveResolution( C, bool ) )
);


# TODO
InstallMethod( MorphismBetweenInjectiveResolutions,
          [ IsCapCategoryMorphism ],
          
  function( phi )
    local cat, P, Q, func, maps, temp;
    
    if IsChainOrCochainMorphism( phi ) then
      
      TryNextMethod( );
      
    fi;
    
    cat := CapCategory( phi );
    
    if not IsAbelianCategoryWithComputableEnoughInjectives( cat ) then
      
      Error( "The category must be abelian with computable enough injectives" );
      
    fi;
    
    P := InjectiveResolution( Source( phi ) );
    
    Q := InjectiveResolution( Range( phi ) );
    
    temp := rec(  );
    
    func :=
      function( i )
         local a, b, c;
         
         if i < 0 then
           
           c := ZeroMorphism( P[i], Q[i] );
           
         elif i = 0 then
           
           a := PreCompose( phi, MonomorphismIntoSomeInjectiveObject( Range( phi ) ) );
           
           b := MonomorphismIntoSomeInjectiveObject( Source( phi ) );
           
           c := InjectiveColift( b, a );
           
         else
           
           if IsBound( temp!.( i - 1 ) ) then
             
             a := CokernelColift( P^( i - 2 ), PreCompose( temp!.( i - 1 ), Q^( i - 1 )  ) );
             
           else
             
             a := CokernelColift( P^( i - 2 ), PreCompose( func( i - 1 ), Q^( i - 1 )  ) );
             
           fi;
           
           b := CokernelColift( P^( i - 2 ), P^( i - 1 ) );
           
           c := InjectiveColift( b, a );
           
         fi;
         
         temp!.( String( i ) ) := c;
         
         return c;
         
      end;
      
    maps := AsZFunction( func );
    
    return CochainMorphism( P, Q, maps );
    
end );

##
InstallMethod( MorphismBetweenInjectiveResolutions,
       [ IsCapCategoryMorphism, IsBool ],
       
  function( phi, bool )
    local psi;
    
    psi := MorphismBetweenInjectiveResolutions( phi );
    
    InjectiveResolution( Source( phi ), bool );
    
    InjectiveResolution( Range( phi ), bool );
    
    return psi;
    
end );

##
InstallMethod( MorphismBetweenInjectiveCochainResolutions,
          [ IsCapCategoryMorphism ],
          
  function( phi )
      
    if IsChainOrCochainMorphism( phi ) then
      TryNextMethod( );
    fi;
    
    return MorphismBetweenInjectiveResolutions( phi );
    
end );

##
InstallMethod( MorphismBetweenInjectiveCochainResolutions,
          [ IsCapCategoryMorphism, IsBool ],
          
  function( phi, bool )
    
    if IsChainOrCochainMorphism( phi ) then
      TryNextMethod( );
    fi;
    
    return MorphismBetweenInjectiveResolutions( phi, bool );
    
end );

##
InstallMethod( MorphismBetweenInjectiveChainResolutions,
          [ IsCapCategoryMorphism ],
          
  function( phi )
    
    if IsChainOrCochainMorphism( phi ) then
      TryNextMethod( );
    fi;
    
    return AsChainMorphism( MorphismBetweenInjectiveResolutions( phi ) );
    
end );

##
InstallMethod( MorphismBetweenInjectiveChainResolutions,
          [ IsCapCategoryMorphism, IsBool ],
          
  function( phi, bool )
    
    if IsChainOrCochainMorphism( phi ) then
      TryNextMethod( );
    fi;
    
    return AsChainMorphism( MorphismBetweenInjectiveResolutions( phi, bool ) );
    
end );

##
InstallOtherMethod( MorphismBetweenInjectiveChainResolutions,
          [ IsChainMorphism ], MorphismBetweenInjectiveResolutions );

##
InstallOtherMethod( MorphismBetweenInjectiveChainResolutions,
          [ IsChainMorphism, IsBool ], MorphismBetweenInjectiveResolutions );

##
InstallOtherMethod( MorphismBetweenInjectiveChainResolutions,
          [ IsCochainMorphism ], phi -> AsChainMorphism( MorphismBetweenInjectiveResolutions( phi ) ) );

##
InstallOtherMethod( MorphismBetweenInjectiveChainResolutions,
          [ IsCochainMorphism, IsBool ],
  { phi, bool } -> AsChainMorphism( MorphismBetweenInjectiveResolutions( phi, bool ) )
);

##
InstallOtherMethod( MorphismBetweenInjectiveCochainResolutions,
          [ IsCochainMorphism ], MorphismBetweenInjectiveResolutions );

##
InstallOtherMethod( MorphismBetweenInjectiveCochainResolutions,
          [ IsCochainMorphism, IsBool ], MorphismBetweenInjectiveResolutions );

##
InstallOtherMethod( MorphismBetweenInjectiveCochainResolutions,
          [ IsChainMorphism ], phi -> AsCochainMorphism( MorphismBetweenInjectiveResolutions( phi ) ) );

##
InstallOtherMethod( MorphismBetweenInjectiveCochainResolutions,
          [ IsChainMorphism, IsBool ],
  { phi, bool } -> AsCochainMorphism( MorphismBetweenInjectiveResolutions( phi, bool ) )
);
