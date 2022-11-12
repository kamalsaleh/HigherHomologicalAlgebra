# SPDX-License-Identifier: GPL-2.0-or-later
# DgComplexesCategories: Category of graded (co)chain complexes of an additive category
#
# Implementations
#


#objects := [ [ "A", [ 0, 5 ] ],
#             [ "B", [ 1, 6 ] ] ];
#
#morphisms := [ [ "phi", [ 1, 2 ], 1, [ 0, 5 ], "\\phi" ],
#          [ "psi", [ 2, 1 ], -1, [ 1, 6 ], "\\psi" ] ];
#
#relations := [ [ "PreCompose( phi, psi )", 1 ] ];
#other_relations := [];

InstallOtherMethod( DgCochainComplexCategory,
        [ IsList, IsList, IsList, IsList ],
        
  function ( objects, morphisms, relations, other_relations )
    local lower_bound, upper_bound, o, d, m, q, F, k, kF, additive_closure, dgCh_additive_closure, i,
      mat, linear_rels, rel, kF_rels, morphism_info, object_info, obj, relation_info;
        
    for morphism_info in morphisms do
        
        if IsList( morphism_info[4] ) then
          
          morphism_info[4][1] := Maximum( objects[morphism_info[2][1]][2][1], objects[morphism_info[2][2]][2][1] - morphism_info[3], morphism_info[4][1] );
          morphism_info[4][2] := Minimum( objects[morphism_info[2][1]][2][2], objects[morphism_info[2][2]][2][2] - morphism_info[3], morphism_info[4][2] );
          
        elif morphism_info[4] = fail then
          
          morphism_info[4] := [ ];
          morphism_info[4][1] := Maximum( objects[morphism_info[2][1]][2][1], objects[morphism_info[2][2]][2][1] - morphism_info[3] );
          morphism_info[4][2] := Minimum( objects[morphism_info[2][1]][2][2], objects[morphism_info[2][2]][2][2] - morphism_info[3] );
          
        else
          
          Error( "Wrong input!\n" );
          
        fi;
        
        if not IsBound( morphism_info[5] ) then
            morphism_info[5] := morphism_info[1];
        fi;
        
    od;
    
    o := Concatenation(
                List( objects, object_info ->
                        List( [ object_info[2][1] .. object_info[2][2] ],
                          j -> [ Concatenation( object_info[1], "_", ReplacedString( String(j), "-", "m" ) ),
                                 Concatenation( object_info[1], "^{", String(j), "}" ) ] ) ) );
    
    d := Concatenation(
                List( objects,
                 object_info -> List( [ object_info[2][1] .. object_info[2][2] - 1 ],
                                   i -> [ Concatenation( "d", object_info[1], "_", ReplacedString( String( i ), "-", "m" ),
                                                         ":",
                                                         object_info[1], "_", ReplacedString( String( i ), "-", "m" ),
                                                         "->",
                                                         object_info[1], "_", ReplacedString( String( i + 1 ), "-", "m"  ) ),
                                          Concatenation( "\\partial_{", object_info[1], "}^{", String( i ), "}" ) ] ) ) );
    
    m := Concatenation(
                List( morphisms, morphism_info ->
                        List( [ morphism_info[4][1] .. morphism_info[4][2] ],
                            j -> [  Concatenation(
                                            morphism_info[1],
                                            "_",
                                            ReplacedString( String( j ), "-", "m" ),
                                            ":",
                                            Concatenation( objects[morphism_info[2][1]][1], "_", ReplacedString( String(j), "-", "m" ) ),
                                            "->",
                                            Concatenation( objects[morphism_info[2][2]][1], "_", ReplacedString( String(j+morphism_info[3]), "-", "m" ) ) ),
                                    Concatenation(
                                            morphism_info[5],
                                            "^{",
                                            String( j ),
                                            "}" ) ] ) ) );
    
    q := RightQuiver(
                Concatenation(
                    "q(",
                    JoinStringsWithSeparator( List( o, z -> z[1] ), "," ),
                    ")[",
                    JoinStringsWithSeparator( List( d, z -> z[1] ), "," ),
                    ",",
                    JoinStringsWithSeparator( List( m, z -> z[1] ), "," ),
                    "]" ) );
    
    SetLabelsAsLaTeXStrings( q, List( o, z -> z[2] ), Concatenation( List( d, z -> z[2] ), List( m, z -> z[2] ) ) );
    
    F := FreeCategory( q );
    
    k := HomalgFieldOfRationals( );
    
    kF := k[ F ];
    
    additive_closure := AdditiveClosure( kF );
    
    dgCh_additive_closure := DgCochainComplexCategory( additive_closure );
    
    for object_info in objects do
        
        MakeReadWriteGlobal( object_info[1] );
        
        DeclareSynonym( object_info[1],
            DgCochainComplex(
                dgCh_additive_closure,
                List( [ object_info[2][1] .. object_info[2][2] - 1 ],
                  i -> kF.( Concatenation( "d", object_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / additive_closure ),
                object_info[2][1] ) );
    od;
    
    for morphism_info in morphisms do
        
        MakeReadWriteGlobal( morphism_info[1] );
        
        DeclareSynonym( morphism_info[1],
            DgCochainComplexMorphism(
                dgCh_additive_closure,
                EvalString( objects[morphism_info[2][1]][1] ),
                EvalString( objects[morphism_info[2][2]][1] ),
                morphism_info[3],
                List( [ morphism_info[4][1] .. morphism_info[4][2] ], i -> kF.( Concatenation( morphism_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / additive_closure ),
                morphism_info[4][1] ) );
    
    od;
    
    linear_rels := [ ];
    
    for object_info in objects do
        obj := EvalString( object_info[1] );
        for i in [ object_info[2][1] .. object_info[2][2] - 2 ] do
            Add( linear_rels, MorphismMatrix( PreCompose( obj^i, obj^(i+1) ) )[1,1] );
        od;
    od;
    
    for relation_info in relations do
        m := EvalString( relation_info[1] );
        for i in [ objects[relation_info[2]][2][1] .. objects[relation_info[2]][2][2] ] do
            mat := MorphismMatrix( m[i] );
            if IsBound( mat[1] ) and IsBound( mat[1][1] ) then
                Add( linear_rels, mat[1,1] );
            fi;
        od;
    od;
    
    kF_rels := kF / linear_rels;
    
    additive_closure := AdditiveClosure( kF_rels );
    
    dgCh_additive_closure := DgCochainComplexCategory( additive_closure );
    
    for object_info in objects do
        
        MakeReadWriteGlobal( object_info[1] );
        
        DeclareSynonym( object_info[1],
            DgCochainComplex(
                dgCh_additive_closure,
                List( [ object_info[2][1] .. object_info[2][2] - 1 ],
                  i -> kF_rels.( Concatenation( "d", object_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / additive_closure ),
                object_info[2][1] ) );
    od;
    
    for morphism_info in morphisms do
        
        MakeReadWriteGlobal( morphism_info[1] );
        
        DeclareSynonym( morphism_info[1],
            DgCochainComplexMorphism(
                dgCh_additive_closure,
                EvalString( objects[morphism_info[2][1]][1] ),
                EvalString( objects[morphism_info[2][2]][1] ),
                morphism_info[3],
                List( [ morphism_info[4][1] .. morphism_info[4][2] ], i -> kF_rels.( Concatenation( morphism_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / additive_closure ),
                morphism_info[4][1] ) );
    
    od;
    
    if not IsEmpty( other_relations ) then
      Error( "Sorry, we can not handle `other_relations` entry yet!\n" );
    fi;
    
    return dgCh_additive_closure;
    
end );
