# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
#####################################################################

##
for info in [ [ "Morphisms", 1 ],
              [ "MorphismAt", 2 ],
              [ "MorphismsSupport", 1 ],
              [ "LowerBound", 1 ],
              [ "UpperBound", 1 ],
              [ "CohomologyFunctorialAt", 2 ],
              [ "HomologyFunctorialAt", 2 ],
              [ "CocyclesFunctorialAt", 2 ],
              [ "CyclesFunctorialAt", 2 ],
              ] do
  
  ##
  InstallOtherMethod(
      ValueGlobal( info[1] ),
      (function()
          if info[2] = 1 then
            return [ IsHomotopyCategoryMorphism ];
          elif info[2] = 2 then
            return [ IsHomotopyCategoryMorphism, IsInt ];
          fi;
      end)(),
      EvalString( ReplacedStringViaRecord( "i_args -> oper( s_args );",
                    rec( oper := info[1],
                         i_args := (function()
                                      if info[2] = 1 then
                                        return "phi";
                                      elif info[2] = 2 then
                                        return "{ phi, i }";
                                      fi;
                                    end)(),
                         s_args := (function()
                                      if info[2] = 1 then
                                        return "UnderlyingCell( phi )";
                                      elif info[2] = 2 then
                                        return "UnderlyingCell( phi ), i";
                                      fi;
                                    end)()))));
  
od;

##
InstallMethod( \[\],
          [ IsHomotopyCategoryMorphism, IsInt ],
  
  { phi, i } -> UnderlyingCell( phi )[ i ]
);

##
InstallOtherMethod( ViewObj, [ IsHomotopyCategoryMorphism ], _complexes_ViewObj );

##
InstallOtherMethod( Display,
        [ IsHomotopyCategoryMorphism ],
        
  function( phi )
    local l, u;
    
    l := LowerBound( phi );
    u := UpperBound( phi );
    
    if ForAll( [ l, u ], IsInt ) then
        Display( UnderlyingCell( phi ), l, u );
        Print( "\nA morphism in ", Name( CapCategory( phi ) ), " defined by the above data\n" );
    else
        TryNextMethod( );
    fi;
    
end );

