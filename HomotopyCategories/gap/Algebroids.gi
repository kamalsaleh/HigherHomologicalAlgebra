# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
##
InstallMethod( \.,
        [ IsHomotopyCategory, IsPosInt ],
   { C, string_as_int } -> ( UnderlyingCategory( C ).( NameRNam( string_as_int ) ) ) / C
);

##
BindGlobal( "_StRiNg",
  function( i )
    
    if IsList( i ) and not IsString( i ) then
      
      return List( i, ValueGlobal( "_StRiNg" ) );
    
    elif IsString( i ) then
      
      return ReplacedString( i, "-", "m" );
      
    elif i < 0 then
      
      return ReplacedString( String( i ), "-", "m" );
      
    else
      
      return String( i );
      
    fi;
    
end );

BindGlobal( "CREATE_ALGEBROID_OF_DIAGRAM",
  function( main_vertices, generating_maps_labels, bounds, extra_arrows, extra_relations, over_homotopy )
    local l, u, k, vertices, main_vertices_latex, vertices_latex, diffs, diffs_latex, maps, generating_maps_latex, maps_latex, arrows, extra_arrows_latex, arrows_latex, Q, kQ, oid, gmaps, diffs_rel, maps_rel, rels, kQ_mod_rels, Aoid, H, C, s, r, V, map, over_Z;
    
    #MAKE_READ_WRITE_GLOBAL( "REREADING" );
    #REREADING := true;
    #SetInfoLevel( InfoWarning, 0 );
    
    if Size( generating_maps_labels ) > 0 and IsInt( generating_maps_labels[ 1 ][ 2 ] ) then
      
      generating_maps_labels := List( generating_maps_labels, m -> [ m[ 1 ], main_vertices[ m[ 2 ] ], main_vertices[ m[ 3 ] ] ] );
      
    fi;
    
    l := bounds[ 1 ];
    
    u := bounds[ 2 ];
    
    k := HomalgFieldOfRationals( );
     
    vertices := ListX( main_vertices, [ l .. u ],
                    { V, i } -> Concatenation( V, "_", _StRiNg( i ) )
                  );
    
    main_vertices_latex := ValueOption( "OLaTeXStrings" );
    
    if main_vertices_latex = fail then
      
      main_vertices_latex := main_vertices;
      
    elif Size( main_vertices_latex ) <> Size( main_vertices ) then
      
      Error( "Bad LaTeX labels for vertices" );
      
    fi;
    
    vertices_latex := ListX( main_vertices_latex, [ l .. u ],
                    function( V, i )
                      if PositionSublist( V, "^" ) <> fail and V[ Length(V) ] = '}' then
                        V := ShallowCopy(V);
                        Remove( V, Length(V) );
                        return Concatenation( "{", V, ",", String( i ), "}}" );
                      else
                        return Concatenation( "{", V, "}^{", String( i ), "}" );
                      fi;
                  end );
    
    diffs := ListX( main_vertices, [ l .. u - 1 ],
                    { V, i } -> Concatenation(
                                      "d", V, "_", _StRiNg( i ),
                                      ":",
                                      V, "_", _StRiNg( i ),
                                      "->",
                                      V, "_", _StRiNg( i + 1 )
                                    )
                  );
    
    diffs_latex := ListX( main_vertices_latex, [ l .. u - 1 ],
                      { V, i } -> Concatenation( "\\partial_{", V, "}^{", String( i ), "}" )
                  );
   
    maps := ListX( generating_maps_labels, [ l .. u ],
                    { map, i } -> Concatenation(
                                      map[ 1 ], "_", _StRiNg( i ),
                                      ":",
                                      map[ 2 ], "_", _StRiNg( i ),
                                      "->",
                                      map[ 3 ], "_", _StRiNg( i )
                                    )
                       );
    
    generating_maps_latex := ValueOption( "MLaTeXStrings" );
    
    if generating_maps_latex = fail then
      
      generating_maps_latex := List( generating_maps_labels, g -> g[ 1 ] );
      
    fi;

    maps_latex := ListX( generating_maps_latex, [ l .. u ],
                    function( map, i )
                      if PositionSublist( map, "^" ) <> fail and map[ Length(map) ] = '}' then
                        map := ShallowCopy( map );
                        Remove( map, Length(map) );
                        return Concatenation( "{", map, ",", String( i ), "}}" );
                      else
                        return Concatenation( "{", map, "}^{", String( i ), "}" );
                      fi;
                  end );
    
    arrows := Concatenation( diffs, maps, extra_arrows );
        
    Q := RightQuiver(
            Concatenation(
                "q(",
                JoinStringsWithSeparator( vertices, "," ),
                ")[",
                JoinStringsWithSeparator( arrows, "," ),
                "]"
              )
          );
    
    extra_arrows_latex := ValueOption( "ELaTeXStrings" );
    
    if extra_arrows_latex <> fail then
      
      arrows_latex := Concatenation( diffs_latex, maps_latex, extra_arrows_latex );
      
      if NumberOfVertices( Q ) <> Size( vertices_latex ) or NumberOfArrows( Q ) <> Size( arrows_latex ) then
        
        Info( InfoWarning, 1, "AlgebroidOfDiagramInHomotopyCategory method needs to be checked!" );
        
      else
        
        SetLabelsAsLaTeXStrings( Q, vertices_latex, arrows_latex );
        
      fi;
      
    fi;
    
    kQ := PathAlgebra( k, Q );
    
    oid := Algebroid( kQ );
    
    AssignSetOfGeneratingMorphisms( oid );
    AssignSetOfObjects( oid );
    
    gmaps := SetOfGeneratingMorphisms( oid );
    
    diffs_rel := List( [ 1 .. Size( gmaps ) - 1 ],
              i -> UnderlyingQuiverAlgebraElement( gmaps[ i ] * gmaps[ i + 1 ] )
            );
    
    diffs_rel := Filtered( diffs_rel, r -> not IsZero( r ) );
    
    maps_rel := ListX( generating_maps_labels, [ l .. u - 1 ],
                  { m, i } ->
                    UnderlyingQuiverAlgebraElement(
                        oid.( Concatenation( "d", m[ 2 ], "_", _StRiNg( i ) ) )
                      * oid.( Concatenation( m[ 1 ], "_", _StRiNg( i + 1 ) ) )
                      - oid.( Concatenation( m[ 1 ], "_", _StRiNg( i ) ) )
                      * oid.( Concatenation( "d", m[ 3 ], "_", _StRiNg( i ) ) )
                    )
                  );
    
    rels := Concatenation(
                diffs_rel,
                maps_rel,
                List( extra_relations, r -> UnderlyingQuiverAlgebraElement( EvalString( r ) ) )
              );
    
    kQ_mod_rels := kQ / rels;
    
    over_Z := ValueOption( "over_Z" );
    
    if over_Z = true then
      oid := Algebroid( kQ_mod_rels, true );
    else
      oid := Algebroid( kQ_mod_rels );
    fi;
    
    AssignSetOfGeneratingMorphisms( oid );
    AssignSetOfObjects( oid );
    
    oid!.Name := Concatenation(
                      "Algebroid( V=", String( Size( vertices ) ), ", E=", 
                      String( Size( gmaps ) ), ", rel=", String( Size( rels ) ), " )"
                    );
    
    Aoid := AdditiveClosure( oid );
    
    if over_homotopy then
      
      H := HomotopyCategory( Aoid, true );
      
    else
      
      H := CochainComplexCategory( Aoid );
      
    fi;
    
    for V in main_vertices do
      
      C := CochainComplex( List( [ l .. u - 1 ], i -> oid.( Concatenation( "d", V, "_", _StRiNg( i ) ) ) / Aoid ), l );

      MakeReadWriteGlobal( V );
      
      if over_homotopy then
        DeclareSynonym( V, C / H );
      else
        DeclareSynonym( V, C );
      fi;
      
    od;
    
    for map in generating_maps_labels do
      
      s := ValueGlobal( map[ 2 ] );
      
      r := ValueGlobal( map[ 3 ] );
      
      if IsHomotopyCategoryObject( s ) then
        
        s := UnderlyingCell( s );
        
        r := UnderlyingCell( r );
        
      fi;
      
      C :=  CochainMorphism(
                  s,
                  r,
                  List( [ l .. u ], i -> oid.( Concatenation( map[ 1 ], "_", _StRiNg( i ) ) ) / Aoid ),
                  l
              );
      
      MakeReadWriteGlobal( map[ 1 ] );
      
      if over_homotopy then
        DeclareSynonym( map[ 1 ], C / H );
      else
        DeclareSynonym( map[ 1 ], C );
      fi;
      
    od;
    
    #REREADING := false;
    
    #SetInfoLevel( InfoWarning, 1 );
    
    return oid;
    
end );

BindGlobal( "MakeMorphismNullHomotopic",
  function( L )
    local map, s, r, lb, ub, diffs_s, diffs_r, maps, extra_arrows, diffs_s_h, diffs_r_h, rels, extra_relations, cat, vertices, vertices_id, i, j, extra_arrows_latex;
  
    map := EvalString( L[ 1 ] );
    
    s := Source( map );
    r := Range( map );
    
    lb := Maximum( ActiveLowerBound( s ), ActiveLowerBound( r ) + 1 );
    ub := Minimum( ActiveUpperBound( s ), ActiveUpperBound( r ) + 1 );
    
    maps := List( [ lb - 1 .. ub ],
                  i -> String( Representative( UnderlyingQuiverAlgebraElement( MorphismMatrix( map[ i ] )[1,1] ) ) )
                );
    
    if L[ 2 ] <> "0" and lb <= ub then
      
      diffs_s := List( [ lb - 1 .. ub - 1 ],
                  i -> String( Representative( UnderlyingQuiverAlgebraElement( MorphismMatrix( s ^ i )[1,1] ) ) )
                );
      
      diffs_r := List( [ lb - 1.. ub - 1 ],
                  i -> String( Representative( UnderlyingQuiverAlgebraElement( MorphismMatrix( r ^ i )[1,1] ) ) )
                );
      
      extra_arrows := List( [ lb .. ub ],
                   i -> Concatenation( 
                           L[ 2 ],
                           "_",
                           _StRiNg( i )
                          )
                  );
    
      diffs_s_h := ListN( diffs_s, extra_arrows, { d, h } -> JoinStringsWithSeparator( [ d, h ], "*" ) );
      diffs_r_h := ListN( extra_arrows, diffs_r, { h, d } -> JoinStringsWithSeparator( [ h, d ], "*" ) );
      rels := ListN( diffs_s_h{[2..Size(diffs_s_h)]}, diffs_r_h{[1..Size(diffs_s_h)-1]},
                    { s, r } -> Concatenation( s, "+", r )
                  );
      Add( rels, diffs_s_h[ 1 ], 1 );
      Add( rels, diffs_r_h[ Size( diffs_r_h ) ] );
  
      extra_relations := ListN( maps, rels,
                  function( m, r )
                    if m <> "0" then
                      return Concatenation( m, "-(", r, ")" );
                    else
                      return Concatenation( "-(", r, ")" );
                    fi;
                end );
    else
      
      extra_relations := maps;
      
    fi;
    
    cat := CapCategory( s );
    
    if IsHomotopyCategory( cat ) then
      
      vertices := List( SetOfObjects(
                        UnderlyingCategory(
                          DefiningCategory(
                            CapCategory( s ) )
                          )
                      ),
                      o -> Concatenation( "(", String( UnderlyingVertex(o) ), ")" )
                    );
    else
       
      vertices := List( SetOfObjects(
                        UnderlyingCategory(
                          UnderlyingCategory(
                            CapCategory( s ) )
                          )
                      ),
                      o -> Concatenation( "(", String( UnderlyingVertex(o) ), ")" )
                    );
    fi;
    
    vertices_id := List( vertices, v -> Concatenation( "IdentityMorphism", v ) );
    
    for i in [ 1 .. Size( vertices ) ] do
      for j in [ 1 .. Size( extra_relations ) ] do
       
       extra_relations[ j ] := ReplacedString( extra_relations[ j ], vertices[ i ], vertices_id[ i ] );
       
      od;
    od;
    
    if L[ 2 ] <> "0" then
      
      extra_arrows := List( [ lb .. ub ],
                 i -> Concatenation( 
                         L[ 2 ],
                         "_",
                         _StRiNg(i),
                         ":",
                         JoinStringsWithSeparator(
                             List( [ Source( map )[ i ][ 1 ], Range( map )[ i - 1 ][ 1 ] ], 
                                 o -> String( UnderlyingVertex( o ) )
                               ),
                             "->"
                         )
                       )
                );
      
      if IsBound( L[ 3 ] ) then
        
        extra_arrows_latex := List( [ lb .. ub ],
                      function( i )
                        local temp;
                        if PositionSublist( L[ 3 ], "^" ) <> fail and L[3][ Length( L[3] ) ] = '}' then
                          temp := ShallowCopy( L[3] );
                          Remove( temp, Length( temp ) );
                          return Concatenation( "{", temp, ",", String( i ), "}}" );
                        else
                          return Concatenation( "{", L[ 3 ], "}^{", String( i ), "}" );
                        fi;
                      end );
        
      else
        
        extra_arrows_latex := List( [ lb .. ub ],
                      i -> Concatenation( "{", L[ 2 ], "}^{", String( i ), "}" )
                );
        
      fi;
      
    else
      
      extra_arrows := [ ];
      
      extra_arrows_latex := fail;
      
    fi;
    
    return [ extra_arrows, extra_relations, extra_arrows_latex ];

end );

InstallMethod( AlgebroidOfDiagramInHomotopyCategory,
          [ IsList, IsList, IsList, IsList, IsList ],
  function( objects, maps, bounds, pre_rels, other_rels )
    local olatex, mlatex, extra_arrows, extra_relations, e, m, relations, oid, extra_arrows_latex;
    
    olatex := ValueOption( "OLaTeXStrings" );
    
    mlatex := ValueOption( "MLaTeXStrings" );
    
    CREATE_ALGEBROID_OF_DIAGRAM( objects, maps, bounds, [ ], [ ], false );
    
    extra_arrows := [ ];
    
    extra_relations := [ ];
    
    extra_arrows_latex := [ ];
    
    for m in pre_rels do
      
      e := MakeMorphismNullHomotopic( m );
      
      extra_arrows := Concatenation( extra_arrows, e[ 1 ] );
      
      extra_relations := Concatenation( extra_relations, e[ 2 ] );
      
      if extra_arrows_latex <> fail and e[ 3 ] <> fail then
        extra_arrows_latex := Concatenation( extra_arrows_latex, e[ 3 ] );
      else
        extra_arrows_latex := fail;
      fi;
      
    od;
    
    oid := CREATE_ALGEBROID_OF_DIAGRAM( objects, maps, bounds, extra_arrows, extra_relations, true : ELaTeXStrings := extra_arrows_latex, OLaTeXStrings := olatex, MLaTeXStrings := mlatex );
    
    for relations in other_rels do
      
      for m in relations do
        
        e := MakeMorphismNullHomotopic( m );
        
        extra_arrows := Concatenation( extra_arrows, e[ 1 ] );
        
        extra_relations := Concatenation( extra_relations, e[ 2 ] );
        
        if extra_arrows_latex <> fail and e[ 3 ] <> fail then
          extra_arrows_latex := Concatenation( extra_arrows_latex, e[ 3 ] );
        else
          extra_arrows_latex := fail;
        fi;
        
      od;
      
      oid := CREATE_ALGEBROID_OF_DIAGRAM( objects, maps, bounds, extra_arrows, extra_relations, true : ELaTeXStrings := extra_arrows_latex, OLaTeXStrings := olatex, MLaTeXStrings := mlatex );
      
    od;
     
    oid!.defining_data := [ objects, maps, bounds, extra_arrows, extra_arrows_latex, extra_relations, true ];
    
    return oid;
    
end );

bounds := [ -3, 3 ];

o := [ "A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4" ];
olatex := [ "A_1", "A_2", "A_3", "A_4", "B_1", "B_2", "B_3", "B_4" ];

m :=
 [
       [ "a1", "A1", "A2" ],
       [ "a2", "A2", "A3" ],
       [ "a3", "A3", "A4" ],
       [ "b1", "B1", "B2" ],
       [ "b2", "B2", "B3" ],
       [ "b3", "B3", "B4" ],
       [ "phi1", "A1", "B1" ],
       [ "phi2", "A2", "B2" ],
       [ "phi3", "A3", "B3" ],
       [ "phi4", "A4", "B4" ],
       [ "h2", "A2", "B1" ],
       [ "h3", "A3", "B2" ],
       [ "h4", "A4", "B3" ]
 ];

mlatex := [ "\\alpha_1", "\\alpha_2", "\\alpha_3", "\\beta_1", "\\beta_2", "\\beta_3", "\\phi_1", "\\phi_2", "\\phi_3", "\\phi_4", "h_2", "h_3", "h_4" ];

pre_rels :=
    [
      [ "PreCompose(a1,a2)", "ha1" ],
      [ "PreCompose(a2,a3)", "ha2" ],
      [ "PreCompose(b1,b2)", "hb1" ],
      [ "PreCompose(b2,b3)", "hb2" ],
      
      [ "PreCompose(a1,phi2)-PreCompose(phi1,b1)", "s_1" ],
      [ "PreCompose(a2,phi3)-PreCompose(phi2,b2)", "s_2" ],
      [ "PreCompose(a3,phi4)-PreCompose(phi3,b3)", "s_3" ],
      
      [ "PreCompose(a1,h2)-phi1", "t_1" ],
      [ "PreCompose(a2,h3)+PreCompose(h2,b1)-phi2", "t_2" ],
      [ "PreCompose(a3,h4)+PreCompose(h3,b2)-phi3", "t_3" ],
      [ "PreCompose(h4,b3)-phi4", "t_4" ],
      
    ];

other_rels :=
  [
    [
      [ "BasisOfExternalHom( Shift( A1, 1 ), B2 )[1]", "x" ],
      [ "BasisOfExternalHom( Shift( A3, 1 ), B4 )[1]", "y" ]
    ]
  ];
