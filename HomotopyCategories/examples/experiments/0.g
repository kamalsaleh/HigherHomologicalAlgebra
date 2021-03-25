LoadPackage( "HomotopyCategories" );
SetSpecialSettings();
EnhanceAllPackages();

higher_homotopies := [ "s", "t", "u", "v", "w", "x", "y", "z" ];
U := "u";

create_algebroid :=
function( N, l, bounds, labels_of_objects, labels_of_morphisms )
  local objects, maps, pre_rels, other_rels, oid, Aoid, Ho, HoHo, m, label_of_object, label_of_morphism;

  objects := [ ];
  olatex := [ ];
  maps := [ ];
  mlatex := [ ];
  pre_rels := [ ];
  other_rels := List( [ l + 1 .. l + N-3 ], i -> [ ] );
  
  for label_of_object in labels_of_objects do
    
    objects := Concatenation( objects, List( [ l .. l + N - 1 ], i -> _StRiNg( Concatenation( label_of_object, String( i ) ) ) ) );
    
    olatex := Concatenation( olatex, List( [ l .. l + N - 1 ], i -> Concatenation( label_of_object, "^{", U, String( i ), "}" ) ) );
    
    maps := Concatenation( maps, List( [ l .. l + N - 2 ], 
              i -> [ 
                    _StRiNg( Concatenation( "d", label_of_object, "_", String( i ) ) ),
                    _StRiNg( Concatenation( label_of_object, String( i ) ) ),
                    _StRiNg( Concatenation( label_of_object, String( i + 1) ) )
                   ]
            ) );
    
    mlatex :=  Concatenation( mlatex, List( [ l .. l + N - 2 ], i -> Concatenation( "\\partial_{", label_of_object, "}^{", U, String( i ), "}" ) ) );

    
    pre_rels := Concatenation( pre_rels, List( [ l .. l + N - 3 ], 
              i -> [ 
                    _StRiNg( Concatenation( "PreCompose( d", label_of_object, "_", String( i ), ", d", label_of_object, "_", String( i + 1 ), " )" ) ),
                    _StRiNg( Concatenation( "h_", label_of_object, String( i ) ) ),
                    Concatenation( "h_{", label_of_object,"}^{", U, String( i ), "}" )
                   ]
            ) );
    
    other_rels := ListN( other_rels,
        List( [ 1 .. N - 3 ], shift ->
          List( [ l .. l + N - shift - 3 ], i ->
            [
              _StRiNg( Concatenation(
                  "BasisOfExternalHom( Shift( ", label_of_object, String( i ), ",",
                  String( shift), " ), ", label_of_object, String( i+shift+2 ), " )[ 1 ]"
                ) ), 
              _StRiNg( Concatenation( higher_homotopies[shift], "_", label_of_object, String( i ) ) ),
              Concatenation( higher_homotopies[shift], "_{", label_of_object, "}^{", U, String( i ), "}" )
            ]
          ) ), Concatenation );
  
  od;
  
  for label_of_morphism in labels_of_morphisms do
    
     maps := Concatenation( maps, List( [ l .. l + N-1 ], 
              i -> [ 
                    _StRiNg( Concatenation( label_of_morphism[ 1 ], String( i ) ) ),
                    _StRiNg( Concatenation( label_of_morphism[ 2 ], String( i ) ) ),
                    _StRiNg( Concatenation( label_of_morphism[ 3 ], String( i ) ) )
                   ]
            ) );
    
     mlatex := Concatenation( mlatex, List( [ l .. l + N-1 ], i -> Concatenation( label_of_morphism[ 1 ], "^{", U, String( i ), "}" ) ) );
     
     pre_rels := Concatenation( pre_rels, List( [ l .. l + N-2 ], 
              i -> [ 
                    Concatenation(
                      _StRiNg( Concatenation( "PreCompose( d", label_of_morphism[ 2 ], "_", String( i ), ", ", label_of_morphism[ 1 ], String( i + 1 ), " )" ) ),
                      "-",
                      _StRiNg( Concatenation( "PreCompose( ", label_of_morphism[ 1 ], String( i ), ", ", "d", label_of_morphism[ 3 ], "_", String( i ) , " )" ) )
                    ),
                    _StRiNg( Concatenation( "h_", label_of_morphism[ 1 ], String( i ) ) ),
                    Concatenation( "h_{", label_of_morphism[ 1 ], "}^{", U, String( i ), "}" )
                   ]
            ) );
     
     other_rels := Concatenation( other_rels,
        List( [ 1 .. N-2 ], shift ->
          List( [ l .. l + N - shift - 2 ], i ->
            [
              _StRiNg( Concatenation(
                  "BasisOfExternalHom( Shift( ", label_of_morphism[ 2 ], String( i ), ",",
                  String( shift), " ), ", label_of_morphism[ 3 ], String( i+shift+1 ), " )[ 1 ]"
                ) ), 
              _StRiNg( Concatenation( higher_homotopies[shift], "_", label_of_morphism[ 1 ], String( i ) ) ),
              Concatenation( higher_homotopies[shift], "_{", label_of_morphism[ 1 ], "}^{", U, String( i ), "}" )
            ]
          ) ) );
    
  
  od;
   
  oid := AlgebroidOfDiagramInHomotopyCategory( objects, maps, bounds, pre_rels, other_rels : OLaTeXStrings := olatex, MLaTeXStrings := mlatex );
  Aoid := AdditiveClosure( oid );
  Ho := HomotopyCategory( Aoid, true );
  HoHo := HomotopyCategory( Ho, true );
  
  for label_of_object in labels_of_objects do
    
    m := List( [ l .. l + N-2 ], i -> _StRiNg( Concatenation( "d", label_of_object, "_", String( i ) ) ) );
    
    MakeReadWriteGlobal( label_of_object );
    
    BindGlobal( label_of_object, HomotopyCategoryObject( HoHo, List( m, ValueGlobal ), l ) );
    
  od;
  
  for label_of_morphism in labels_of_morphisms do
    
    m := List( [ l .. l + N-1 ], i -> _StRiNg( Concatenation( label_of_morphism[ 1 ], String( i ) ) ) );
    
    MakeReadWriteGlobal( label_of_morphism[ 1 ] );
    
    BindGlobal( label_of_morphism[ 1 ], HomotopyCategoryMorphism( ValueGlobal( label_of_morphism[ 2 ] ), ValueGlobal( label_of_morphism[ 3 ] ), List( m, ValueGlobal ), l ) );
    
  od;
  
  return HoHo;
  
end;

N := 5; # Nr ob objects in each object in HoHo
u := 0;
l :=  u - N + 1;
bounds := [ l, l+N+1 ];
labels_of_objects := [ "A", "B" ];
labels_of_morphisms := [ [ "f", "A", "B" ] ];
Error();
HoHo := create_algebroid( N, l, bounds, labels_of_objects, labels_of_morphisms );

