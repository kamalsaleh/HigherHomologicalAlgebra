# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
#
#####################################################################


##
InstallMethod( \[\],
          [ IsHomotopyCategoryMorphism, IsInt ],
  
  { a, i } -> UnderlyingCell( a )[ i ]
);

##
InstallOtherMethod( ViewObj,
          [ IsHomotopyCategoryMorphism ],
  
  function( phi )
    local lower_bound, upper_bound, dots;
    
    upper_bound := UpperBound( UnderlyingCell( phi ) );
    lower_bound := LowerBound( UnderlyingCell( phi ) );
    
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
        [ IsHomotopyCategoryMorphism ],
        
  function( phi )
    local l, u;
    
    l := LowerBound( UnderlyingCell( phi ) );
    u := UpperBound( UnderlyingCell( phi ) );
    
    if ForAll( [ l, u ], IsInt ) then
        
        Display( UnderlyingCell( phi ), l, u );
        
        Print( "\nAn object in ", Name( CapCategory( phi ) ), " defined by the above data\n" );
        
    else
        TryNextMethod( );
    fi;
    
end );

