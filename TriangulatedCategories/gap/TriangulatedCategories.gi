# SPDX-License-Identifier: GPL-2.0-or-later
# TriangulatedCategories: Framework for triangulated categories
#
# Implementations
#

###############################
##
##  Methods record
##
###############################

InstallValue( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD, rec(

StandardConeObject:= rec(
  filter_list := [ "category", "morphism" ],
  return_type := "object"
),

MorphismToStandardConeObjectWithGivenStandardConeObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  io_type := [ [ "alpha", "cone_alpha" ], [ "range_alpha", "cone_alpha" ] ],
  return_type := "morphism"
),

MorphismFromStandardConeObjectWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "cone_alpha", "alpha", "sh_source_alpha" ], [ "cone_alpha", "sh_source_alpha" ] ],
  return_type := "morphism"
),

MorphismToStandardConeObject := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "range_alpha", "cone_alpha" ] ],
  with_given_object_position := "Range",
  return_type := "morphism"
),

MorphismFromStandardConeObject := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "StandardConeObject( cat, alpha )",
  output_range_getter_string := "ShiftOnObject( cat, Source( alpha ) )",
  return_type := "morphism"
),

ShiftOnObject:= rec(
  filter_list := [ "category", "object" ],
  return_type := "object"
),

ShiftOnMorphismWithGivenObjects := rec(
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  filter_list := [ "category", "object", "morphism", "object" ],
  return_type := "morphism"
),

InverseShiftOnObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "object"
),

InverseShiftOnMorphismWithGivenObjects := rec(
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  filter_list := [ "category", "object", "morphism", "object" ],
  return_type := "morphism"
),

WitnessIsomorphismOntoStandardConeObject := rec(
  io_type := [ [ "alpha", "iota", "pi" ], [ "range_iota", "cone_alpha" ] ],
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  return_type := "morphism_or_fail"
),

WitnessIsomorphismFromStandardConeObject := rec(
  io_type := [ [ "alpha", "iota", "pi" ], [ "cone_alpha", "range_iota" ] ],
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  return_type := "morphism_or_fail"
),

IsExactTriangle := rec(
  filter_list := [ "category", "morphism", "morphism", "morphism" ],
  return_type := "bool"
),

UnitIsomorphismWithGivenObject := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "s", "sh_o_rev_sh_s" ], [ "s", "sh_o_rev_sh_s" ] ],
  return_type := "morphism"
),

#UnitIsomorphism := rec(
#  # filter_list := [ "category", "object" ],
#  io_type := [ [ "s" ], [ "s", "alpha", "sh_o_rev_sh_s" ] ],
#  return_type := "morphism"
#),

InverseOfCounitIsomorphismWithGivenObject := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "s", "rev_sh_o_sh_s" ], [ "s", "rev_sh_o_sh_s" ] ],
  return_type := "morphism"
),

#InverseOfCounitIsomorphism := rec(
#  # filter_list := [ "category", "object" ],
#  io_type := [ [ "s" ], [ "s", "alpha", "rev_sh_o_sh_s" ] ],
#  return_type := "morphism"
#),

InverseOfUnitIsomorphismWithGivenObject := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "s", "sh_o_rev_sh_s" ], [ "sh_o_rev_sh_s", "s" ] ],
  return_type := "morphism"
),

#InverseOfUnitIsomorphism := rec(
#  # filter_list := [ "category", "object" ],
#  io_type := [ [ "s" ], [ "sh_o_rev_sh_s", "alpha", "s" ] ]
#  return_type := "morphism"
#),

CounitIsomorphismWithGivenObject := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "s", "rev_sh_o_sh_s" ], [ "rev_sh_o_sh_s", "s" ] ],
  return_type := "morphism"
),

#CounitIsomorphism := rec(
#  # filter_list := [ "category", "object" ],
#  io_type := [ [ "s" ], [ "rev_sh_o_sh_s", "alpha", "s" ] ]
#  return_type := "morphism"
#),

MorphismBetweenStandardConeObjectsWithGivenObjects := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "object" ],
  io_type := [ [ "cone_alpha", "list", "cone_alpha_prime" ], [ "cone_alpha", "cone_alpha_prime" ] ],
  return_type := "morphism",
  is_with_given := false
),

DomainMorphismByOctahedralAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  return_type := "morphism",
),

MorphismToConeObjectByOctahedralAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  return_type := "morphism",
),

MorphismFromConeObjectByOctahedralAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  return_type := "morphism",
),

WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "cone_g", "f", "g", "h", "st_cone" ], [ "cone_g", "st_cone" ] ],
  return_type := "morphism",
),

WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "g", "h", "cone_g" ], [ "st_cone", "cone_g" ] ],
  return_type := "morphism",
),

WitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "cone", "f", "st_cone" ], [ "cone", "st_cone" ] ],
  return_type := "morphism",
),

WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "cone" ], [ "st_cone", "cone" ] ],
  return_type := "morphism",
),

WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "cone", "f", "st_cone" ], [ "cone", "st_cone" ] ],
  return_type := "morphism",
),

WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "cone" ], [ "st_cone", "cone" ] ],
  return_type := "morphism",
),

ShiftExpandingIsomorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism"
),

ShiftFactoringIsomorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism"
),

InverseShiftExpandingIsomorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism"
),

InverseShiftFactoringIsomorphismWithGivenObjects := rec(
  filter_list := [ "category", "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  return_type := "morphism"
)

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );


###########################################
#
# Convenient methods
#
##########################################

##
CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
  rec(
    ShiftOnMorphism :=
      [ [ "ShiftOnMorphismWithGivenObjects", 1 ], [ "ShiftOnObject", 2 ] ]
  )
);

InstallMethod( ShiftOnMorphism,
          [ IsCapCategoryMorphism ],
  alpha -> ShiftOnMorphismWithGivenObjects(
              ShiftOnObject( Source( alpha ) ),
              alpha,
              ShiftOnObject( Range( alpha ) )
            )
);

##
CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
  rec(
    InverseShiftOnMorphism :=
      [ [ "InverseShiftOnMorphismWithGivenObjects", 1 ], [ "InverseShiftOnObject", 2 ] ]
  )
);

InstallMethod( InverseShiftOnMorphism,
          [ IsCapCategoryMorphism ],
  alpha -> InverseShiftOnMorphismWithGivenObjects(
              InverseShiftOnObject( Source( alpha ) ),
              alpha,
              InverseShiftOnObject( Range( alpha ) )
            )
);

##
InstallMethod( ConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    
    return StandardConeObject( beta );
    
end );

##
InstallMethod( MorphismBetweenStandardConeObjects,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, mu, nu, beta )
    local cone_alpha, cone_beta;
    
    cone_alpha := StandardConeObject( alpha );

    cone_beta := StandardConeObject( beta );
    
    return MorphismBetweenStandardConeObjectsWithGivenObjects(
            cone_alpha, [ alpha, mu, nu, beta ], cone_beta );
end );

##
InstallMethod( MorphismBetweenStandardConeObjectsWithGivenObjects,
          [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ],
  function( cone_alpha, alpha, mu, nu, beta, cone_beta )
    
    return MorphismBetweenStandardConeObjectsWithGivenObjects(
            cone_alpha, [ alpha, mu, nu, beta ], cone_beta );
    
end );

##
InstallMethod( WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, u, r;
    
    s := ConeObjectByOctahedralAxiom( alpha, beta, gamma );
    
    u := DomainMorphismByOctahedralAxiom( alpha, beta, gamma );
     
    r := StandardConeObject( u );
    
    return WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
      
end );

##
InstallMethod( WitnessIsomorphismFromStandardConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, u, r;
    
    u := DomainMorphismByOctahedralAxiom( alpha, beta, gamma );
     
    s := StandardConeObject( u );

    r := ConeObjectByOctahedralAxiom( alpha, beta, gamma );
        
    return WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
      
end );

##
InstallMethod( ConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return ShiftOnObject( Source( alpha ) );
    
end );

##
InstallMethod( DomainMorphismByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return MorphismToStandardConeObject( alpha );
    
end );

##
InstallMethod( MorphismToConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return MorphismFromStandardConeObject( alpha );
    
end );

##
InstallMethod( MorphismFromConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return AdditiveInverseForMorphisms( ShiftOnMorphism( alpha ) );
    
end );

##
InstallMethod( ConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return Range( alpha );
    
end );

##
InstallMethod( DomainMorphismByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local u;
    
    u := MorphismFromStandardConeObject( alpha );
    
    return PreCompose(
              AdditiveInverseForMorphisms( InverseShiftOnMorphism( u ) ),
              CounitIsomorphism( Source( alpha ) )
            );
    
end );

##
InstallMethod( MorphismToConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ], IdFunc
);

##
InstallMethod( MorphismFromConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return PreCompose(
              MorphismToStandardConeObject( alpha ),
              UnitIsomorphism( StandardConeObject( alpha ) )
            );
    
end );

##
InstallMethod( WitnessIsomorphismOntoStandardConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := ConeObjectByRotationAxiom( alpha );
    
    r := StandardConeObject( DomainMorphismByRotationAxiom( alpha ) );
    
    return WitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects( s, alpha, r );
    
end );

##
InstallMethod( WitnessIsomorphismFromStandardConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := StandardConeObject( DomainMorphismByRotationAxiom( alpha ) );
    
    r := ConeObjectByRotationAxiom( alpha );
    
    return WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects( s, alpha, r );
    
end );

##
InstallMethod( WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := ConeObjectByInverseRotationAxiom( alpha );
    
    r := StandardConeObject( DomainMorphismByInverseRotationAxiom( alpha ) );
    
    return WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects( s, alpha, r );
    
end );

##
InstallMethod( WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := StandardConeObject( DomainMorphismByInverseRotationAxiom( alpha ) );
    
    r := ConeObjectByInverseRotationAxiom( alpha );
    
    return WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects( s, alpha, r );
    
end );

##
InstallMethod( DomainMorphismByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, r;
    
    s := StandardConeObject( alpha );
    
    r := StandardConeObject( gamma );
    
    return DomainMorphismByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
  
end );

##
InstallMethod( MorphismToConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, r;
    
    s := StandardConeObject( gamma );
    
    r := StandardConeObject( beta );
    
    return MorphismToConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
    
end );

##
InstallMethod( MorphismFromConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, r;
     
    s := StandardConeObject( beta );
    
    r := ShiftOnObject( StandardConeObject( alpha ) );
    
    return MorphismFromConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
    
end );

##
InstallMethod( StandardCoConeObject,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return InverseShiftOnObject( StandardConeObject( alpha ) );
    
end );

## at some time I was returning the additive inverse of this, but
## it turns out, this new method make things simpler.
##
InstallMethod( MorphismFromStandardCoConeObject,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return InverseShiftOnMorphism(
                  MorphismFromStandardConeObject( alpha )
                );
    
end );

##
InstallMethod( MorphismBetweenStandardCoConeObjects,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, mu, nu, beta )
    
    return InverseShiftOnMorphism(
              MorphismBetweenStandardConeObjects(
                    alpha,
                    mu,
                    nu,
                    beta
                  )
              );
    
end );

##
InstallMethod( CounitIsomorphism,
          [ IsCapCategoryObject ],
  a -> CounitIsomorphismWithGivenObject( a, Shift( Shift( a, 1 ), -1 ) )
);

##
InstallMethod( InverseOfCounitIsomorphism,
          [ IsCapCategoryObject ],
  a -> InverseOfCounitIsomorphismWithGivenObject( a, Shift( Shift( a, 1 ), -1 ) )
);

##
InstallMethod( UnitIsomorphism,
          [ IsCapCategoryObject ],
  a -> UnitIsomorphismWithGivenObject( a, Shift( Shift( a, -1 ), 1 ) )
);

##
InstallMethod( InverseOfUnitIsomorphism,
          [ IsCapCategoryObject ],
  a -> InverseOfUnitIsomorphismWithGivenObject( a, Shift( Shift( a, -1 ), 1 ) )
);

###
#InstallMethod( ShiftExpandingIsomorphism,
#                [ IsList ],
#  function( L )
#    return ShiftExpandingIsomorphismWithGivenObjects( ShiftOnObject( DirectSum( L ) ), L, DirectSum( List( L, ShiftOnObject ) ) );
#end );
#
###
#InstallMethod( InverseShiftExpandingIsomorphism,
#                [ IsList ],
#  function( L )
#    return InverseShiftExpandingIsomorphismWithGivenObjects(
#            InverseShiftOnObject( DirectSum( L ) ),
#            L,
#            DirectSum( List( L, InverseShiftOnObject ) )
#          );
#end );
#
###
#InstallMethod( ShiftFactoringIsomorphism,
#                [ IsList ],
#    function( L )
#    return ShiftFactoringIsomorphismWithGivenObjects(
#            DirectSum(
#            List( L, ShiftOnObject ) ),
#            L,
#            ShiftOnObject( DirectSum( L ) )
#          );
#end );
#
###
#InstallMethod( InverseShiftFactoringIsomorphism,
#          [ IsList ],
#    function( L )
#    return InverseShiftFactoringIsomorphismWithGivenObjects(
#              DirectSum( List( L, InverseShiftOnObject ) ),
#              L,
#              InverseShiftOnObject( DirectSum( L ) )
#          );
#end );

###
#InstallMethod( IsomorphismFromStandardExactTriangle,
#                [ IsCapCategoryExactTriangle ],
#                -1000,
#    function( T )
#    local F, p;
#    F := T!.UnderlyingLazyMethods;
#    if not IsomorphismFromStandardExactTriangle in F then
#        TryNextMethod( );
#    else
#        p := Position( F, IsomorphismFromStandardExactTriangle );
#        return CallFuncList( F[p+1], F[ p+2 ] );
#    fi;
#end );
#
###
#InstallMethod( IsomorphismOntoStandardExactTriangle,
#                [ IsCapCategoryExactTriangle ],
#                -1000,
#    function( T )
#    local F, p;
#    F := T!.UnderlyingLazyMethods;
#    if not IsomorphismOntoStandardExactTriangle in F then
#        TryNextMethod( );
#    else
#        p := Position( F, IsomorphismOntoStandardExactTriangle );
#        return CallFuncList( F[p+1], F[ p+2 ] );
#    fi;
#end );
#

##
InstallMethod( ShiftOp,
          [ IsCapCategoryCell, IsInt ],
  function( cell, n )
    local C;
    
    C := CapCategory( cell );
    
    if not IsTriangulatedCategory( C ) then
      TryNextMethod( );
    fi;
    
    if n = 0 then
      
      return cell;
      
    elif n > 0 then
    
      if IsCapCategoryObject( cell ) then
        
        return ShiftOnObject( Shift( cell, n - 1 ) );
        
      else
        
        return ShiftOnMorphism( Shift( cell, n - 1 ) );
        
      fi;
      
    else
      
      if IsCapCategoryObject( cell ) then
        
        return InverseShiftOnObject( Shift( cell, n + 1 ) );
        
      else
        
        return InverseShiftOnMorphism( Shift( cell, n + 1 ) );
        
      fi;
      
    fi;

end );

##
InstallOtherMethod( Shift,
              [ IsCapCategoryCell ],
  function( c )
    
    if not IsTriangulatedCategory( CapCategory( c ) ) then
      
      TryNextMethod( );
      
    fi;
    
    return Shift( c, 1 );
    
end );

##
InstallMethod( InverseShift,
              [ IsCapCategoryCell ],
  function( c )
    
    if not IsTriangulatedCategory( CapCategory( c ) ) then
      
      TryNextMethod( );
      
    fi;
    
    return Shift( c, -1 );
    
end );

##
InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS_FOR_TRIANGULATED_CATEGORY,
               IsCapCategory and IsTriangulatedCategory,
               0,

   function( category )

   AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "TriangulatedCategories", "LogicForTriangulatedCategories" ),
        "PredicateImplicationsForTriangulatedCategories.tex" ) );

   TryNextMethod( );

end );
