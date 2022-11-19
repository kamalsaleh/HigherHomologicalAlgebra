







########################################
#
# Representations, families and types
#
########################################


DeclareRepresentation( "IsChainMorphismRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfChainMorphisms",
            NewFamily( "chain morphisms" ) );

BindGlobal( "TheTypeOfChainMorphism",
            NewType( FamilyOfChainMorphisms,
                     IsChainMorphism and IsChainMorphismRep ) );

DeclareRepresentation( "IsCochainMorphismRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfCochainMorphisms",
            NewFamily( "cochain morphisms" ) );

BindGlobal( "TheTypeOfCochainMorphism",
            NewType( FamilyOfCochainMorphisms,
                     IsCochainMorphism and IsCochainMorphismRep ) );

#########################################
#
# (Co)chain morphisms constructors
#
#########################################

## Morphisms
##
InstallMethod( CreateComplexMorphism,
            [ IsChainOrCochainComplexCategory, IsChainOrCochainComplex, IsChainOrCochainComplex, IsList ],
  
  { ch_cat, S, R, datum }  -> MorphismConstructor( ch_cat, S, datum, R )
);

##
InstallOtherMethod( CreateComplexMorphism,
        [ IsChainOrCochainComplexCategory, IsChainOrCochainComplex, IsChainOrCochainComplex, IsZFunction, IsObject, IsObject ],
  
  { ch_cat, S, R, morphisms, lower_bound, upper_bound } -> CreateComplexMorphism( ch_cat, S, R, [ morphisms, lower_bound, upper_bound ] )
);

##
InstallOtherMethod( CreateComplexMorphism,
        [ IsChainOrCochainComplexCategory, IsChainOrCochainComplex, IsChainOrCochainComplex, IsFunction, IsObject, IsObject ],
  
  { ch_cat, S, R, morphisms, lower_bound, upper_bound } -> CreateComplexMorphism( ch_cat, S, R, AsZFunction( morphisms ), lower_bound, upper_bound )
);

##
InstallOtherMethod( CreateComplexMorphism,
            [ IsChainOrCochainComplexCategory, IsChainOrCochainComplex, IsChainOrCochainComplex, IsZFunction ],
  
  { ch_cat, S, R, morphisms } -> CreateComplexMorphism( ch_cat, S, R, morphisms, Minimum( LowerBound( S ), LowerBound( R ) ), Maximum( UpperBound( S ), UpperBound( R ) ) )
);

##
InstallOtherMethod( CreateComplexMorphism,
            [ IsChainOrCochainComplexCategory, IsChainOrCochainComplex, IsChainOrCochainComplex, IsFunction ],
  
  { ch_cat, S, R, morphisms } -> CreateComplexMorphism( ch_cat, S, R, AsZFunction( morphisms ) )
);

##
InstallOtherMethod( CreateComplexMorphism,
        [ IsChainOrCochainComplexCategory, IsChainOrCochainComplex, IsChainOrCochainComplex, IsDenseList, IsInt ],
  
  function ( ch_cat, S, R, dense_list_of_morphisms, lower_bound )
    local upper_bound, morphisms;
    
    upper_bound := lower_bound + Length( dense_list_of_morphisms ) - 1;
    
    morphisms :=
      function( i )
        
        if i >= lower_bound and i <= upper_bound then
          return dense_list_of_morphisms[i - lower_bound + 1];
        else
          return ZeroMorphism( UnderlyingCategory( ch_cat ), S[i], R[i] );
        fi;
        
      end;
    
    return CreateComplexMorphism( ch_cat, S, R, morphisms, lower_bound, upper_bound );
    
end );

##
InstallOtherMethod( CreateComplexMorphism,
        [ IsChainOrCochainComplex, IsChainOrCochainComplex, IsDenseList, IsInt ],
  
  { S, R, dense_list_of_morphisms, lower_bound } -> CreateComplexMorphism( CapCategory( S ), S, R, dense_list_of_morphisms, lower_bound )
);

###################################
#
# Components of co-chain morphisms
#
###################################

##
InstallMethod( LowerBoundOfSourceAndRange,
          [ IsChainOrCochainMorphism ],
  
  phi -> Minimum( LowerBound( Source( phi ) ), LowerBound( Range( phi ) ) )
);

##
InstallMethod( UpperBoundOfSourceAndRange,
          [ IsChainOrCochainMorphism ],
  
  phi -> Maximum( UpperBound( Source( phi ) ), UpperBound( Range( phi ) ) )
);

##
InstallMethod( MorphismAtOp,
          [ IsChainOrCochainMorphism, IsInt ],
  
  { phi, i } -> Morphisms( phi )[ i ]
);

##
InstallMethod( \[\],
          [ IsChainOrCochainMorphism, IsInt ],
  
  MorphismAt
);

##
InstallMethod( MorphismsSupport,
          [ IsChainOrCochainMorphism, IsInt, IsInt ],
  
  { phi, m, n } -> Filtered( [ m .. n ], i -> not IsZeroForMorphisms( MorphismAt( phi, i ) ) )
);

##
InstallMethod( MorphismsSupport,
          [ IsChainOrCochainMorphism ],
  
  phi -> MorphismsSupport( phi, LowerBound( phi ), UpperBound( phi ) )
);

##
InstallMethod( CocyclesFunctorialAtOp,
          [ IsCochainMorphism, IsInt ],
  
  { phi, i } -> CocyclesFunctorialAt( CocyclesAt( Source( phi ), i ), phi, i, CocyclesAt( Range( phi ), i ) )
);

##
InstallOtherMethod( CocyclesFunctorialAt,
          [ IsCapCategoryObject, IsCochainMorphism, IsInt, IsCapCategoryObject ],
  
  { source_cocycles, phi, i, range_cocycles } -> KernelObjectFunctorialWithGivenKernelObjects( source_cocycles, Source( phi )^i, phi[i], Range( phi )^i, range_cocycles )
);

##
InstallMethod( CyclesFunctorialAtOp,
          [ IsChainMorphism, IsInt ],
  
  { phi, i } -> CocyclesFunctorialAt( AsCochainComplexMorphism( phi ), -i )
);

##
InstallMethod( CohomologyFunctorialAtOp,
          [ IsCochainMorphism, IsInt ],
  
  function( phi, i )
    local B, C, iota_B, iota_C, kappa;
    
    B := Source( phi );
    C := Range( phi );
    
    iota_B := KernelLiftWithGivenKernelObject( B^i, CoboundariesEmbeddingAt( B, i ), CocyclesAt( B, i ) );
    iota_C := KernelLiftWithGivenKernelObject( C^i, CoboundariesEmbeddingAt( C, i ), CocyclesAt( C, i ) );
    
    kappa := CocyclesFunctorialAt( phi, i );
    
    return CokernelObjectFunctorialWithGivenCokernelObjects( CohomologyAt( B, i ), iota_B, kappa, iota_C, CohomologyAt( C, i ) );
    
end );

##
InstallMethod( HomologyFunctorialAtOp,
          [ IsChainMorphism, IsInt ],
  
  { phi, i } -> CohomologyFunctorialAt( AsCochainComplexMorphism( phi ), -i )
);

##
InstallMethod( IsQuasiIsomorphism,
          [ IsCochainMorphism ],
  
  phi -> ForAll( [ LowerBoundOfSourceAndRange( phi ) .. UpperBoundOfSourceAndRange( phi ) ], i -> IsIsomorphism( CohomologyFunctorialAt( phi, i ) ) )
);

##
InstallMethod( IsQuasiIsomorphism,
          [ IsChainMorphism ],
  
  phi -> ForAll( [ LowerBoundOfSourceAndRange( phi ) .. UpperBoundOfSourceAndRange( phi ) ], i -> IsIsomorphism( HomologyFunctorialAt( phi, i ) ) )
);


##
InstallOtherMethod( IsHomotopicToZeroMorphism,
          [ IsCochainComplexCategory, IsCochainMorphism ],
          
  function( ch_cat, phi )
    local range_cat, ell;
    
    range_cat := RangeCategoryOfHomomorphismStructure( UnderlyingCategory( ch_cat ) );
    
    ell := _complexes_InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( ch_cat, phi );
    
    return IsLiftable( range_cat, ell[0], Range( ell )^(-1) );
    
end );

##
InstallOtherMethod( IsHomotopicToZeroMorphism,
          [ IsCochainMorphism ],
  
  phi -> IsHomotopicToZeroMorphism( CapCategory( phi ), phi )
);

##
InstallOtherMethod( WitnessForBeingHomotopicToZeroMorphism,
          [ IsCochainComplexCategory, IsCochainMorphism ],
          
  function( ch_cat, phi )
    local B, C, l_BC, u_BC, cat, range_cat, ell, hom_BC, diagram, m;
    
    B := Source( phi );
    C := Range( phi );
    
    l_BC := Maximum( LowerBound( C ), LowerBound( B ) - 1 );
    u_BC := Minimum( UpperBound( C ), UpperBound( B ) - 1 );
    
    cat := UnderlyingCategory( ch_cat );
    
    range_cat := RangeCategoryOfHomomorphismStructure( UnderlyingCategory( ch_cat ) );
    
    ell := _complexes_InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( ch_cat, phi );
    
    hom_BC := Range( ell );
    
    if HasBaseZFunctions( Objects( hom_BC ) ) then
        diagram := BaseZFunctions( Objects( hom_BC ) )[1][-1];
    else
        diagram := List( [ l_BC .. u_BC ], j -> HomomorphismStructureOnObjects( cat, B[j+1], C[j] ) );
    fi;
    
    ell := Lift( range_cat, ell[0], Range( ell )^(-1) );
    
    m := List( [ 1 .. Length( diagram ) ], i -> PreCompose( range_cat, ell, ProjectionInFactorOfDirectSumWithGivenDirectSum( range_cat, diagram, i, hom_BC[-1] ) ) );
    
    m := ListN( [ 1 .. Length( m ) ], [ l_BC .. u_BC ], { index_j, j } -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, B[j+1], C[j], m[index_j] ) );
    
    return AsZFunction(
              function( i )
                
                if i - 1 < l_BC or u_BC < i - 1 then
                  return ZeroMorphism( cat, B[i], C[i-1] );
                elif l_BC <= i - 1 and i - 1 <= u_BC then
                  return m[ i - l_BC ];
                fi;
                
            end );
            
end );

##
InstallMethod( WitnessForBeingHomotopicToZeroMorphism,
          [ IsCochainMorphism ],
  
  phi -> WitnessForBeingHomotopicToZeroMorphism( CapCategory( phi ), phi )
);

##
InstallMethod( AsComplexMorphismOverOppositeCategory,
          [ IsCochainMorphism ],
  
  function( phi )
    local S, T, morphisms, psi;
    
    S := AsComplexOverOppositeCategory( Range( phi ) );
    
    T := AsComplexOverOppositeCategory( Source( phi ) );
    
    morphisms := i -> Opposite( Morphisms( phi )[-i] );
    
    psi := CreateComplexMorphism( CapCategory( S ), S, T, morphisms, -UpperBound( phi ), -LowerBound( phi ) );
    
    SetAsComplexMorphismOverOppositeCategory( psi, phi );
    
    return psi;
    
end );

##
InstallMethod( AsCochainComplexMorphism,
          [ IsChainMorphism ],
  
  alpha -> ModelingTowerMorphismConstructor( CapCategory( alpha ), AsCochainComplex( Source( alpha ) ), MorphismDatum( alpha ), AsCochainComplex( Range( alpha ) ) )
);

##
InstallMethod( AsChainComplexMorphism,
          [ IsCochainMorphism ],
  
  function( alpha )
    local ch_cat;
    
    ch_cat := ComplexesCategoryByChains( UnderlyingCategory( CapCategory( alpha ) ) );
    
    return MorphismConstructor( ch_cat, AsChainComplex( Source( alpha ) ), ModelingTowerMorphismDatum( ch_cat, alpha ), AsChainComplex( Range( alpha ) ) );
    
end );


#################################
#
# Display and View
#
#################################

##
InstallMethod( ViewObj,
          [ IsChainOrCochainMorphism ],
        
  function( phi )
    local lower_bound, upper_bound, dots;
    
    upper_bound := UpperBound( phi );
    lower_bound := LowerBound( phi );
    
    if IsInt( upper_bound ) then
      upper_bound := String( upper_bound );
    elif upper_bound = infinity then
      upper_bound := Concatenation( "+", TEXTMTRANSLATIONS!.infty );
    else
      upper_bound := Concatenation( "-", TEXTMTRANSLATIONS!.infty );
    fi;
    
    if IsInt( lower_bound ) then
      lower_bound := String( lower_bound );
    elif lower_bound = infinity then
      lower_bound := Concatenation( "+", TEXTMTRANSLATIONS!.infty );
    else
      lower_bound := Concatenation( "-", TEXTMTRANSLATIONS!.infty );
    fi;
    
    dots := Concatenation( ListWithIdenticalEntries( 3, TEXTMTRANSLATIONS!.cdot ) );
    
    Print( "<A morphism in ", Name( CapCategory( phi ) ), " supported in the window [", lower_bound, " ", dots, " ", upper_bound, "]>" );
    
end );

##
InstallOtherMethod( Display,
          [ IsChainOrCochainMorphism, IsInt, IsInt ],
  function( map, m, n )
    local s, i;
    
    Print( "\n" );
    for i in Reversed( [ m .. n ] ) do
      
      s := Concatenation( "== ", String( i ), " =======================" );
      Print( s );
      Print( "\n" );
      Display( map[ i ] );
      Print( "\n" );
      
    od;
    
    Print( "\nA morphism in ", Name( CapCategory( map ) ), " defined by the above data\n" );
    
end );

##
InstallMethod( Display,
          [ IsChainOrCochainMorphism ],
    
  function( phi )
    local l, u;
    
    l := LowerBound( phi );
    u := UpperBound( phi );
    
    if ForAll( [ l, u ], IsInt ) then
      
      Display( phi, l, u );
      
    else
      
      TryNextMethod( );
      
    fi;
      
end );

##
InstallOtherMethod( LaTeXOutput,
        [ IsChainOrCochainMorphism, IsInt, IsInt ],
        
  function( phi, l, u )
    local OnlyDatum, s, i;
    
    OnlyDatum := ValueOption( "OnlyDatum" );
    
    if OnlyDatum = true then
      
      s := "\\begin{array}{lc}\n ";
      
      for i in [ l .. u ] do
        
        s := Concatenation( s, "\\\\ \n", String( i ), ": &", LaTeXOutput( phi[ i ] : OnlyDatum := false ), " \\\\ \n " );
        
      od;
      
    else
      
      s := "\\begin{array}{ccc}\n ";
      
      if IsCochainMorphism( phi ) then
        
        s := Concatenation(
                s,
                LaTeXOutput( Source( phi )[ u ] ),
                "&-\\phantom{-}{",
                LaTeXOutput( phi[ u ] : OnlyDatum := true ),
                "}\\phantom{-}\\rightarrow&",
                LaTeXOutput( Range( phi )[ u ] ),
                "\n \\\\ \n"
              );
              
        for i in Reversed( [ l .. u - 1 ] ) do
          
          s := Concatenation(
                  s,
                  " \\uparrow_{\\phantom{", String( i ), "}}",
                  "&&",
                  " \n \\uparrow_{\\phantom{", String( i ), "}}",
                  "\n \\\\ \n "
                );
                
          s := Concatenation(
                  s,
                  LaTeXOutput( Source( phi ) ^ i : OnlyDatum := true ),
                  "&&",
                  LaTeXOutput( Range( phi ) ^ i : OnlyDatum := true ),
                  "\n \\\\ \n "
                );
                
          s := Concatenation(
                  s,
                  "\\vert_{", String( i ), "} ",
                  "&&",
                  "\\vert_{", String( i ), "} ",
                  "\n \\\\ \n "
                );
                
          s := Concatenation(
                s,
                LaTeXOutput( Source( phi )[ i ] ),
                "&-\\phantom{-}{",
                LaTeXOutput( phi[ i ] : OnlyDatum := true ),
                "}\\phantom{-}\\rightarrow&",
                LaTeXOutput( Range( phi )[ i ] ),
                "\n \\\\ \n "
              );
              
        od;
        
      else
        
        for i in Reversed( [ l + 1 .. u ] ) do
          
          s := Concatenation(
                s,
                "\\\\ \n",
                LaTeXOutput( Source( phi )[ i ] ),
                "&-\\phantom{-}{",
                LaTeXOutput( phi[ i ] : OnlyDatum := true ),
                "}\\phantom{-}\\rightarrow&",
                LaTeXOutput( Range( phi )[ i ] ),
                "\n "
              );
              
          s := Concatenation(
                  s,
                  "\\\\ \n \\vert^{", String( i ), "} ",
                  "&&",
                  "\\vert^{", String( i ), "} ",
                  "\n \\\\ \n "
                );
                
          s := Concatenation(
                  s,
                  LaTeXOutput( Source( phi ) ^ i : OnlyDatum := true ),
                  "&&",
                  LaTeXOutput( Range( phi ) ^ i : OnlyDatum := true ),
                  "\n \\\\ \n "
                );
                
          s := Concatenation(
                  s,
                  " \\downarrow_{\\phantom{", String( i ), "}}",
                  "&&",
                  " \n \\downarrow_{\\phantom{", String( i ), "}}"
                );
                
        od;
        
        s := Concatenation(
                s,
                "\\\\ \n",
                LaTeXOutput( Source( phi )[ l ] ),
                "&-\\phantom{-}{",
                LaTeXOutput( phi[ l ] : OnlyDatum := true ),
                "}\\phantom{-}\\rightarrow&",
                LaTeXOutput( Range( phi )[ l ] ),
                "\n \\\\ \n "
              );
              
      fi;
      
    fi;
    
    return Concatenation( s, "\\end{array}" );
    
end );

##
InstallMethod( LaTeXOutput,
          [ IsChainOrCochainMorphism ],
  phi -> LaTeXOutput(
              phi,
              Minimum( LowerBound( Source( phi ) ), LowerBound( Range( phi ) ) ),
              Maximum( UpperBound( Source( phi ) ), UpperBound( Range( phi ) ) )
          ) );
