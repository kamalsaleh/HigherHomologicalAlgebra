# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
#
#####################################################################


##
InstallOtherMethod( \[\], [ IsHomotopyCategoryObject, IsInt ], ObjectAt );
InstallOtherMethod( \^, [ IsHomotopyCategoryObject, IsInt ], DifferentialAt );

##
for info in [ [ "Objects", 1 ],
              [ "ObjectAt", 2 ],
              [ "ObjectsSupport", 1 ],
              [ "Differentials", 1 ],
              [ "DifferentialAt", 2 ],
              [ "DifferentialsSupport", 1 ],
              [ "LowerBound", 1 ],
              [ "UpperBound", 1 ],
              [ "CohomologyAt", 2 ],
              [ "CohomologySupport", 1 ],
              [ "HomologyAt", 2 ],
              [ "HomologySupport", 1 ],
              [ "CoboundariesAt", 2 ],
              [ "CoboundariesEmbeddingAt", 2 ],
              [ "BoundariesAt", 2 ],
              [ "BoundariesEmbeddingAt", 2 ],
              [ "CocyclesEmbeddingAt", 2 ],
              [ "CocyclesAt", 2 ],
              [ "CyclesEmbeddingAt", 2 ],
              [ "CyclesAt", 2 ],
              ] do
  
  ##
  InstallOtherMethod(
      ValueGlobal( info[1] ),
      (function()
          if info[2] = 1 then
            return [ IsHomotopyCategoryObject ];
          elif info[2] = 2 then
            return [ IsHomotopyCategoryObject, IsInt ];
          fi;
      end)(),
      EvalString( ReplacedStringViaRecord( "i_args -> oper( s_args );",
                    rec( oper := info[1],
                         i_args := (function()
                                      if info[2] = 1 then
                                        return "C";
                                      elif info[2] = 2 then
                                        return "{ C, i }";
                                      fi;
                                    end)(),
                         s_args := (function()
                                      if info[2] = 1 then
                                        return "UnderlyingCell( C )";
                                      elif info[2] = 2 then
                                        return "UnderlyingCell( C ), i";
                                      fi;
                                    end)()))));
  
od;

##
InstallOtherMethod( ViewObj, [ IsHomotopyCategoryObject ], _complexes_ViewObj );

##
InstallOtherMethod( Display,
        [ IsHomotopyCategoryObject ],
  
  function ( C )
    local l, u;
    
    l := LowerBound( C );
    u := UpperBound( C );
    
    if ForAll( [ l, u ], IsInt ) then
        Display( UnderlyingCell( C ), l, u );
        Print( "\nAn object in ", Name( CapCategory( C ) ), " defined by the above data\n" );
    else
        TryNextMethod( );
    fi;
    
end );

