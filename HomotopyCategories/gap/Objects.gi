# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
#
#####################################################################

##
InstallMethod( \[\],
  [ IsHomotopyCategoryObject, IsInt ],
    { a, i } -> UnderlyingCell( a )[ i ] );

##
InstallMethod( \^,
  [ IsHomotopyCategoryObject, IsInt ],
    { a, i } -> UnderlyingCell( a ) ^ i );

##
InstallOtherMethod( Display,
        [ IsHomotopyCategoryObject, IsInt, IsInt ],
  
  function( C, m, n )
    
    Display( UnderlyingCell( C ), m, n );
    
end );

InstallOtherMethod( ViewObj,
        [ IsHomotopyCategoryObject ],
  
  function( C )
    local lower_bound, upper_bound, dots;
    
    upper_bound := UpperBound( UnderlyingCell( C ) );
    lower_bound := LowerBound( UnderlyingCell( C ) );
    
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
    
    Print( "<An object in ", Name( CapCategory( C ) ), " supported in the window [", lower_bound, " ", dots, " ", upper_bound, "]>" );
    
end );

##
InstallOtherMethod( Display,
        [ IsHomotopyCategoryObject ],
        
  function( C )
    local l, u;
    
    l := LowerBound( UnderlyingCell( C ) );
    u := UpperBound( UnderlyingCell( C ) );
    
    if ForAll( [ l, u ], IsInt ) then
        
        Display( UnderlyingCell( C ), l, u );
        
        Print( "\nAn object in ", Name( CapCategory( C ) ), " defined by the above data\n" );
        
    else
        TryNextMethod( );
    fi;
    
end );

